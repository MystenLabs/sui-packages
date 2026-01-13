module 0x3200e2e4d34366060862e0efa622b3b1e905fa4f4d92e2297795653730ff2add::bulldog_game {
    struct BULLDOG_GAME has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
    }

    fun init(arg0: BULLDOG_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    // decompiled from Move bytecode v6
}

