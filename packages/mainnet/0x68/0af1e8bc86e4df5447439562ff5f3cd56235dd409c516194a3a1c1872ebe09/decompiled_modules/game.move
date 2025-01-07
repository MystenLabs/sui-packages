module 0x680af1e8bc86e4df5447439562ff5f3cd56235dd409c516194a3a1c1872ebe09::game {
    struct GameInfo has key {
        id: 0x2::object::UID,
        owner: address,
        ref: address,
    }

    public entry fun create_user(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameInfo{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            ref   : arg0,
        };
        0x2::transfer::share_object<GameInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

