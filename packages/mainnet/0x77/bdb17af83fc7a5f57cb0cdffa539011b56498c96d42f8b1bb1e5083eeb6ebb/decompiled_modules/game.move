module 0x77bdb17af83fc7a5f57cb0cdffa539011b56498c96d42f8b1bb1e5083eeb6ebb::game {
    struct Personagem has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        health: u64,
        strength: u64,
        wood: u64,
        stone: u64,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        strength_bonus: u64,
        health_bonus: u64,
    }

    public fun collect_item(arg0: &mut Personagem, arg1: u8, arg2: u64) {
        if (arg1 == 0) {
            arg0.wood = arg0.wood + arg2;
        } else if (arg1 == 1) {
            arg0.stone = arg0.stone + arg2;
        };
    }

    public fun create_personagem(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Personagem{
            id       : 0x2::object::new(arg2),
            name     : 0x1::string::utf8(arg0),
            url      : 0x1::string::utf8(arg1),
            health   : 100,
            strength : 10,
            wood     : 0,
            stone    : 0,
        };
        0x2::transfer::public_transfer<Personagem>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun end_battle(arg0: &mut Personagem, arg1: u64, arg2: bool) {
        if (arg2) {
            if (arg1 <= 30) {
                arg0.strength = arg0.strength + 1;
                arg0.health = arg0.health + 1;
            };
            if (arg0.health > arg1) {
                arg0.health = arg0.health - arg1;
            } else {
                arg0.health = 0;
            };
            arg0.wood = arg0.wood + 10;
            arg0.stone = arg0.stone + 5;
        } else {
            arg0.health = 0;
        };
    }

    public fun health(arg0: &Personagem) : u64 {
        arg0.health
    }

    public fun mint_item(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg0 == b"axe") {
            (b"Uma machadinha simples, bons tempos da pedra lascada.", b"Machadinha de Pedra")
        } else {
            assert!(arg0 == b"shield", 3);
            (b"Pode ser usado como mesa de centro.", b"Escudo de Madeira")
        };
        let v2 = Item{
            id             : 0x2::object::new(arg4),
            name           : 0x1::string::utf8(v1),
            description    : 0x1::string::utf8(v0),
            url            : 0x1::string::utf8(arg1),
            strength_bonus : arg2,
            health_bonus   : arg3,
        };
        0x2::transfer::public_transfer<Item>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun name(arg0: &Personagem) : 0x1::string::String {
        arg0.name
    }

    public fun revive_personagem(arg0: &mut Personagem, arg1: u64) {
        assert!(arg0.health == 0, 2);
        arg0.health = arg1;
    }

    public fun stone(arg0: &Personagem) : u64 {
        arg0.stone
    }

    public fun strength(arg0: &Personagem) : u64 {
        arg0.strength
    }

    public fun wood(arg0: &Personagem) : u64 {
        arg0.wood
    }

    // decompiled from Move bytecode v6
}

