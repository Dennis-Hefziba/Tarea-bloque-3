#!/bin/bash

# Ruta al archivo CSV
archivo="/workspaces/Tarea-bloque-3/ventas.csv"

# Redirigir toda la salida al archivo reporte.txt
exec >> /workspaces/Tarea-bloque-3/reporte.txt

# Generar el total de ventas por mes
echo "**************************************************"
echo "Total de ventas por mes:"
echo "************************************************"
awk -F, '{split($1, fecha, "/"); mes = strftime("%B %Y", mktime(fecha[3]" "fecha[2]" "fecha[1]" 0 0 0")); ventas[mes] += $3} END {for (mes in ventas) print "Mes:", mes ", Total Ventas:", ventas[mes]}' $archivo

echo "**********************************************************"

# Producto más vendido en el año
echo "Producto más vendido en el año:"
awk -F, 'NR>1{productos[$2]+=$3} END {for (producto in productos) print productos[producto], producto}' $archivo | sort -nr | head -1 | while read monto producto; do
    echo "Producto: $producto, Monto: $monto"
done

echo "**********************************************************"

# Cliente más frecuente
echo "Cliente más frecuente:"
awk -F, 'NR>1{clientes[$4]++} END {max = 0; max_cliente = ""; for (cliente in clientes) {if (clientes[cliente] > max) {max = clientes[cliente]; max_cliente = cliente}}; print "Cliente:", max_cliente, ", Veces:", max}' $archivo

echo "**********************************************************"

# Calcular el monto total anual
total_anual=$(awk -F, 'NR>1{total+=$3} END {print total}' $archivo)
echo "Monto total anual: $total_anual"
echo ""
echo ""

