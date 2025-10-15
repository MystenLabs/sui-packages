module 0xbaa48df403bf932f761fe5e0e26b6d22051ee1964a409957d099933b868ce46::cracha {
    struct Cracha has store, key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        edicao_bootcamp: u64,
    }

    public fun atualizar_nome(arg0: &mut Cracha, arg1: 0x1::string::String) {
        arg0.nome = arg1;
    }

    entry fun emitir(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Cracha{
            id              : 0x2::object::new(arg1),
            nome            : arg0,
            edicao_bootcamp : 2,
        };
        0x2::transfer::transfer<Cracha>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun get_edicao_bootcamp(arg0: &Cracha) : u64 {
        arg0.edicao_bootcamp
    }

    public fun get_nome(arg0: &Cracha) : 0x1::string::String {
        arg0.nome
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

