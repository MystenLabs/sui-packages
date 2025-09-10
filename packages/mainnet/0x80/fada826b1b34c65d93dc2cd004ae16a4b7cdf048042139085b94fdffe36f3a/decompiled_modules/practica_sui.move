module 0x80fada826b1b34c65d93dc2cd004ae16a4b7cdf048042139085b94fdffe36f3a::practica_sui {
    struct Banco has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        clientes: vector<Cliente>,
    }

    struct Cliente has drop, store {
        nombre: 0x1::string::String,
        edad: u16,
        genero: 0x1::string::String,
        rfc: 0x1::string::String,
        deuda: u64,
    }

    public fun abonar_a_cuenta(arg0: &mut Banco, arg1: u64, arg2: u64) {
        assert!(0x1::vector::length<Cliente>(&arg0.clientes) > arg1, 13906834359026974721);
        let v0 = 0x1::vector::borrow_mut<Cliente>(&mut arg0.clientes, arg1);
        v0.deuda = v0.deuda - arg2;
    }

    public fun apertura_prestamo_cliente(arg0: &mut Banco, arg1: 0x1::string::String, arg2: u16, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) {
        let v0 = Cliente{
            nombre : arg1,
            edad   : arg2,
            genero : arg3,
            rfc    : arg4,
            deuda  : arg5,
        };
        0x1::vector::push_back<Cliente>(&mut arg0.clientes, v0);
    }

    public fun crear_banco(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Banco{
            id       : 0x2::object::new(arg1),
            nombre   : arg0,
            clientes : 0x1::vector::empty<Cliente>(),
        };
        0x2::transfer::transfer<Banco>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_cliente(arg0: &mut Banco, arg1: u64) {
        assert!(0x1::vector::length<Cliente>(&arg0.clientes) > arg1, 13906834337552138241);
        0x1::vector::remove<Cliente>(&mut arg0.clientes, arg1);
    }

    public fun eliminar_ultimo_cliente(arg0: &mut Banco) {
        0x1::vector::pop_back<Cliente>(&mut arg0.clientes);
    }

    public fun solicitar_mas_deuda(arg0: &mut Banco, arg1: u64, arg2: u64) {
        assert!(0x1::vector::length<Cliente>(&arg0.clientes) > arg1, 13906834384796778497);
        let v0 = 0x1::vector::borrow_mut<Cliente>(&mut arg0.clientes, arg1);
        v0.deuda = v0.deuda + arg2;
    }

    // decompiled from Move bytecode v6
}

