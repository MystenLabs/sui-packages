module 0x3d2976e317b6512a4dd59fff178069bc402a1bb7ef6fa30f58b60757ee95d07a::mensagem {
    struct Mensagem has key {
        id: 0x2::object::UID,
        texto: 0x1::string::String,
    }

    public fun criar(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Mensagem{
            id    : 0x2::object::new(arg1),
            texto : arg0,
        };
        0x2::transfer::share_object<Mensagem>(v0);
    }

    // decompiled from Move bytecode v6
}

