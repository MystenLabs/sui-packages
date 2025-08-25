module 0x61fdd61f4d7085053d5efe3154471dce9b1b335245db6ee9b425a217046aa5e0::onchain_game {
    struct GameAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Sword has store, key {
        id: 0x2::object::UID,
        min_level: u64,
        strength: u64,
    }

    struct Hero has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        hitpoints: u64,
        xp: u64,
        url: 0x2::url::Url,
        sword: 0x1::option::Option<Sword>,
    }

    public entry fun create_hero(arg0: &GameAdminCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{
            id        : 0x2::object::new(arg4),
            name      : 0x1::string::utf8(arg2),
            level     : 1,
            hitpoints : 100,
            xp        : 0,
            url       : 0x2::url::new_unsafe_from_bytes(arg3),
            sword     : 0x1::option::none<Sword>(),
        };
        0x2::transfer::transfer<Hero>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

