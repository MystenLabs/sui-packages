module 0x388750ccc5bb5b792fa986b296f4cc86194e724d99e4a112d3687ff2e3249453::livros {
    struct Livro has store, key {
        id: 0x2::object::UID,
        titulo: 0x1::string::String,
        autor: 0x1::string::String,
        ano: u16,
    }

    struct Biblioteca has store, key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        total_livros: u64,
    }

    public fun adicionar_livro(arg0: &mut Biblioteca, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Livro{
            id     : 0x2::object::new(arg5),
            titulo : arg1,
            autor  : arg2,
            ano    : arg3,
        };
        0x2::dynamic_field::add<vector<u8>, vector<u8>>(&mut v0.id, b"conteudo_walrus", arg4);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"disponivel", true);
        0x2::dynamic_field::add<0x2::object::ID, Livro>(&mut arg0.id, 0x2::object::uid_to_inner(&v0.id), v0);
        arg0.total_livros = arg0.total_livros + 1;
    }

    public fun criar_biblioteca(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Biblioteca{
            id           : 0x2::object::new(arg1),
            nome         : arg0,
            total_livros : 0,
        };
        0x2::transfer::share_object<Biblioteca>(v0);
    }

    public fun emprestar_livro(arg0: &mut Biblioteca, arg1: 0x2::object::ID) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Livro>(&mut arg0.id, arg1);
        0x2::dynamic_field::remove<vector<u8>, bool>(&mut v0.id, b"disponivel");
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"disponivel", false);
    }

    // decompiled from Move bytecode v6
}

