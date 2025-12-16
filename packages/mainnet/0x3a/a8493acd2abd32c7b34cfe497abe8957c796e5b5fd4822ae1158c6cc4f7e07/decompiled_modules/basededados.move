module 0x3aa8493acd2abd32c7b34cfe497abe8957c796e5b5fd4822ae1158c6cc4f7e07::basededados {
    struct Usuario has drop, store {
        nome_usuario: 0x1::string::String,
        idade: u8,
        informacao: vector<0x1::string::String>,
    }

    struct BaseDeDados has store, key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        dados: 0x2::vec_map::VecMap<u8, Usuario>,
    }

    public fun adicionar_informacao(arg0: &mut BaseDeDados, arg1: u8, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u8, Usuario>(&arg0.dados, &arg1), 2);
        0x1::vector::push_back<0x1::string::String>(&mut 0x2::vec_map::get_mut<u8, Usuario>(&mut arg0.dados, &arg1).informacao, arg2);
    }

    public fun adicionar_usuario(arg0: &mut BaseDeDados, arg1: 0x1::string::String, arg2: u8, arg3: u8) {
        assert!(!0x2::vec_map::contains<u8, Usuario>(&arg0.dados, &arg3), 1);
        let v0 = Usuario{
            nome_usuario : arg1,
            idade        : arg2,
            informacao   : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::vec_map::insert<u8, Usuario>(&mut arg0.dados, arg3, v0);
    }

    public fun criar_base_de_dados(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x1::string::String) : BaseDeDados {
        BaseDeDados{
            id    : 0x2::object::new(arg0),
            nome  : arg1,
            dados : 0x2::vec_map::empty<u8, Usuario>(),
        }
    }

    public fun publicar_base_de_dados(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x1::string::String) {
        let v0 = BaseDeDados{
            id    : 0x2::object::new(arg0),
            nome  : arg1,
            dados : 0x2::vec_map::empty<u8, Usuario>(),
        };
        0x2::transfer::public_transfer<BaseDeDados>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

