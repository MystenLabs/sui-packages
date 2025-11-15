module 0xb13c76a775a4d37a9c49a1d0d3bb05db581e24659feb85512b9122b0e439af43::spinosanctuary {
    struct Spinosaurus has store, key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        versao: 0x1::string::String,
        tipo: 0x1::string::String,
        saude: u8,
        fome: u8,
    }

    struct Habitat has key {
        id: 0x2::object::UID,
        nome: 0x1::string::String,
        tipo: 0x1::string::String,
        capacidade: u8,
        spinos: vector<Spinosaurus>,
    }

    public fun adicionar_spino(arg0: &mut Habitat, arg1: Spinosaurus) {
        assert!(0x1::vector::length<Spinosaurus>(&arg0.spinos) < (arg0.capacidade as u64), 1);
        assert!(arg0.tipo == arg1.tipo, 2);
        0x1::vector::push_back<Spinosaurus>(&mut arg0.spinos, arg1);
    }

    public fun atualizar_spino(arg0: &mut Habitat, arg1: u8, arg2: u8) {
        assert!(arg1 >= 0 && arg1 <= 150, 3);
        assert!(arg2 >= 0 && arg2 <= 150, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Spinosaurus>(&arg0.spinos)) {
            let v1 = 0x1::vector::borrow_mut<Spinosaurus>(&mut arg0.spinos, v0);
            v1.saude = arg1;
            v1.fome = arg2;
            v0 = v0 + 1;
        };
    }

    public entry fun criar_habitat(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Habitat{
            id         : 0x2::object::new(arg3),
            nome       : 0x1::string::utf8(arg0),
            tipo       : 0x1::string::utf8(arg1),
            capacidade : arg2,
            spinos     : 0x1::vector::empty<Spinosaurus>(),
        };
        0x2::transfer::share_object<Habitat>(v0);
    }

    public fun criar_spino(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Spinosaurus{
            id     : 0x2::object::new(arg3),
            nome   : 0x1::string::utf8(arg0),
            versao : 0x1::string::utf8(arg1),
            tipo   : 0x1::string::utf8(arg2),
            saude  : 100,
            fome   : 0,
        };
        0x2::transfer::transfer<Spinosaurus>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_habitat_info(arg0: &Habitat) : (0x1::string::String, 0x1::string::String, u8, u64) {
        (arg0.nome, arg0.tipo, arg0.capacidade, 0x1::vector::length<Spinosaurus>(&arg0.spinos))
    }

    public fun get_spino_info(arg0: &Spinosaurus) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8, u8) {
        (arg0.nome, arg0.versao, arg0.tipo, arg0.saude, arg0.fome)
    }

    // decompiled from Move bytecode v6
}

