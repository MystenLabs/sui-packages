module 0x46f6e814cb4068300300cc2cf1f7a2b601186dd82fdeb11a12b1e686069cfa6::game_counter {
    struct GameCounter has key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun get_next_id(arg0: &mut GameCounter) : u64 {
        arg0.count = arg0.count + 1;
        arg0.count
    }

    public fun init_gc(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCounter{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<GameCounter>(v0);
    }

    // decompiled from Move bytecode v6
}

