module 0x576976da39e63cd432af379446baaac9b68a606bca5f8b941e69e5ea23806d0d::calculadora {
    struct Operacion has key {
        id: 0x2::object::UID,
        valor: 0x1::option::Option<Valor>,
    }

    struct Valor has drop, store {
        first: u64,
        second: u64,
        resolved: u64,
        tipo: 0x1::string::String,
    }

    public fun agregar_division(arg0: &mut Operacion, arg1: u64, arg2: u64) {
        assert!(0x1::option::is_none<Valor>(&arg0.valor), 1);
        let v0 = Valor{
            first    : arg1,
            second   : arg2,
            resolved : arg1 / arg2,
            tipo     : 0x1::string::utf8(b"division"),
        };
        0x1::option::fill<Valor>(&mut arg0.valor, v0);
    }

    public fun agregar_multiplicacion(arg0: &mut Operacion, arg1: u64, arg2: u64) {
        assert!(0x1::option::is_none<Valor>(&arg0.valor), 1);
        let v0 = Valor{
            first    : arg1,
            second   : arg2,
            resolved : arg1 * arg2,
            tipo     : 0x1::string::utf8(b"multiplicacion"),
        };
        0x1::option::fill<Valor>(&mut arg0.valor, v0);
    }

    public fun agregar_resta(arg0: &mut Operacion, arg1: u64, arg2: u64) {
        assert!(0x1::option::is_none<Valor>(&arg0.valor), 1);
        let v0 = Valor{
            first    : arg1,
            second   : arg2,
            resolved : arg1 - arg2,
            tipo     : 0x1::string::utf8(b"resta"),
        };
        0x1::option::fill<Valor>(&mut arg0.valor, v0);
    }

    public fun agregar_suma(arg0: &mut Operacion, arg1: u64, arg2: u64) {
        assert!(0x1::option::is_none<Valor>(&arg0.valor), 1);
        let v0 = Valor{
            first    : arg1,
            second   : arg2,
            resolved : arg1 + arg2,
            tipo     : 0x1::string::utf8(b"suma"),
        };
        0x1::option::fill<Valor>(&mut arg0.valor, v0);
    }

    public fun crea_operaciones(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Operacion{
            id    : 0x2::object::new(arg0),
            valor : 0x1::option::none<Valor>(),
        };
        0x2::transfer::transfer<Operacion>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun remove_operacion(arg0: &mut Operacion) {
        if (0x1::option::is_none<Valor>(&arg0.valor)) {
            0x1::option::extract<Valor>(&mut arg0.valor);
        };
    }

    // decompiled from Move bytecode v6
}

