module 0xaf115340f88fc6bd1105088ceb2cfb581798047b1a8078546b422cd0d1aa4894::cracha {
    struct Cracha has store, key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        edicao_bootcamp: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun atualizar_nome(arg0: &mut Cracha, arg1: 0x1::string::String) {
        arg0.nome = arg1;
    }

    public entry fun emitir(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Cracha{
            id              : 0x2::object::new(arg3),
            nome            : arg0,
            edicao_bootcamp : arg1,
            image_url       : arg2,
        };
        0x2::transfer::transfer<Cracha>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_edicao_bootcamp(arg0: &Cracha) : 0x1::string::String {
        arg0.edicao_bootcamp
    }

    public fun get_nome(arg0: &Cracha) : 0x1::string::String {
        arg0.nome
    }

    // decompiled from Move bytecode v6
}

