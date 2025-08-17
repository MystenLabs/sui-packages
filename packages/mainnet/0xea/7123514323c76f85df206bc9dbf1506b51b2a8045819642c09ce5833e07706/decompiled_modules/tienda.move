module 0xea7123514323c76f85df206bc9dbf1506b51b2a8045819642c09ce5833e07706::tienda {
    struct Tienda has key {
        id: 0x2::object::UID,
        productos: 0x2::vec_map::VecMap<u64, Producto>,
        empleados: 0x2::vec_map::VecMap<u64, Empleado>,
    }

    struct Producto has drop, store {
        nombreProducto: 0x1::string::String,
        precioProducto: u16,
        talleProducto: 0x1::string::String,
        tipoProducto: 0x1::string::String,
        cantidadProducto: u16,
        disponibilidadProducto: bool,
    }

    struct Empleado has drop, store {
        nombreEmpleado: 0x1::string::String,
        cargoEmpleado: 0x1::string::String,
        cuitEmpleado: u32,
        turnoEmpleado: 0x1::string::String,
        estadoEmpleado: bool,
    }

    public fun agregar_empleado(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32, arg5: 0x1::string::String, arg6: bool) {
        assert!(!0x2::vec_map::contains<u64, Empleado>(&arg0.empleados, &arg1), 1);
        let v0 = Empleado{
            nombreEmpleado : arg2,
            cargoEmpleado  : arg3,
            cuitEmpleado   : arg4,
            turnoEmpleado  : arg5,
            estadoEmpleado : arg6,
        };
        0x2::vec_map::insert<u64, Empleado>(&mut arg0.empleados, arg1, v0);
    }

    public fun agregar_producto(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String, arg3: u16, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u16) {
        assert!(!0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 1);
        let v0 = Producto{
            nombreProducto         : arg2,
            precioProducto         : arg3,
            talleProducto          : arg4,
            tipoProducto           : arg5,
            cantidadProducto       : arg6,
            disponibilidadProducto : true,
        };
        0x2::vec_map::insert<u64, Producto>(&mut arg0.productos, arg1, v0);
    }

    public fun crear_tienda(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Tienda{
            id        : 0x2::object::new(arg0),
            productos : 0x2::vec_map::empty<u64, Producto>(),
            empleados : 0x2::vec_map::empty<u64, Empleado>(),
        };
        0x2::transfer::transfer<Tienda>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_empleado(arg0: &mut Tienda, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Empleado>(&arg0.empleados, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<u64, Empleado>(&mut arg0.empleados, &arg1);
    }

    public fun eliminar_producto(arg0: &mut Tienda, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<u64, Producto>(&mut arg0.productos, &arg1);
    }

    public fun eliminar_tienda(arg0: Tienda) {
        let Tienda {
            id        : v0,
            productos : _,
            empleados : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun modificar_cantidad_producto(arg0: &mut Tienda, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Producto>(&mut arg0.productos, &arg1).cantidadProducto = arg2;
    }

    public fun modificar_cargo_empleado(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Empleado>(&arg0.empleados, &arg1), 2);
        0x2::vec_map::get_mut<u64, Empleado>(&mut arg0.empleados, &arg1).cargoEmpleado = arg2;
    }

    public fun modificar_cuit_empleado(arg0: &mut Tienda, arg1: u64, arg2: u32) {
        assert!(0x2::vec_map::contains<u64, Empleado>(&arg0.empleados, &arg1), 2);
        0x2::vec_map::get_mut<u64, Empleado>(&mut arg0.empleados, &arg1).cuitEmpleado = arg2;
    }

    public fun modificar_disponibilidad_producto(arg0: &mut Tienda, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Producto>(&mut arg0.productos, &arg1).disponibilidadProducto = arg2;
    }

    public fun modificar_estado_empleado(arg0: &mut Tienda, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, Empleado>(&arg0.empleados, &arg1), 2);
        0x2::vec_map::get_mut<u64, Empleado>(&mut arg0.empleados, &arg1).estadoEmpleado = arg2;
    }

    public fun modificar_nombre_empleado(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Empleado>(&arg0.empleados, &arg1), 2);
        0x2::vec_map::get_mut<u64, Empleado>(&mut arg0.empleados, &arg1).nombreEmpleado = arg2;
    }

    public fun modificar_nombre_producto(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Producto>(&mut arg0.productos, &arg1).nombreProducto = arg2;
    }

    public fun modificar_precio_producto(arg0: &mut Tienda, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Producto>(&mut arg0.productos, &arg1).precioProducto = arg2;
    }

    public fun modificar_talle_producto(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Producto>(&mut arg0.productos, &arg1).talleProducto = arg2;
    }

    public fun modificar_tipo_producto(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Producto>(&arg0.productos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Producto>(&mut arg0.productos, &arg1).tipoProducto = arg2;
    }

    public fun modificar_turno_empleado(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Empleado>(&arg0.empleados, &arg1), 2);
        0x2::vec_map::get_mut<u64, Empleado>(&mut arg0.empleados, &arg1).turnoEmpleado = arg2;
    }

    // decompiled from Move bytecode v6
}

