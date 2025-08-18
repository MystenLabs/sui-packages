module 0x5cb295803b01c571feaf7655b8d11878ecdc4a667e641509381eb0fec1f3a5e6::controlGastos {
    struct Cuenta has store, key {
        id: 0x2::object::UID,
        gastos: 0x2::vec_map::VecMap<u64, Gasto>,
    }

    struct Gasto has copy, drop, store {
        titulo: 0x1::string::String,
        descripcion: 0x1::string::String,
        monto: u16,
    }

    public fun actualizar_monto(arg0: &mut Cuenta, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Gasto>(&arg0.gastos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Gasto>(&mut arg0.gastos, &arg1).monto = arg2;
    }

    public fun actualizar_titulo(arg0: &mut Cuenta, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Gasto>(&arg0.gastos, &arg1), 2);
        0x2::vec_map::get_mut<u64, Gasto>(&mut arg0.gastos, &arg1).titulo = arg2;
    }

    public fun agregar_gasto(arg0: &mut Cuenta, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16) {
        let v0 = Gasto{
            titulo      : arg2,
            descripcion : arg3,
            monto       : arg4,
        };
        assert!(!0x2::vec_map::contains<u64, Gasto>(&arg0.gastos, &arg1), 1);
        0x2::vec_map::insert<u64, Gasto>(&mut arg0.gastos, arg1, v0);
    }

    public fun crear_cuenta(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Cuenta{
            id     : 0x2::object::new(arg0),
            gastos : 0x2::vec_map::empty<u64, Gasto>(),
        };
        0x2::transfer::transfer<Cuenta>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_cuenta(arg0: Cuenta) {
        let Cuenta {
            id     : v0,
            gastos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_gasto(arg0: &mut Cuenta, arg1: u64) {
        let (_, _) = 0x2::vec_map::remove<u64, Gasto>(&mut arg0.gastos, &arg1);
    }

    // decompiled from Move bytecode v6
}

