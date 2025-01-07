module 0xe53343b7a64ec5fed2e126e7a521c1794db28d04ec07c1475f9e2b83bc41ed14::sui_winner {
    struct Round has store, key {
        id: 0x2::object::UID,
        round: u64,
    }

    struct Winner has copy, drop {
        prize: u64,
        winning_number: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Round{
            id    : 0x2::object::new(arg0),
            round : 1,
        };
        0x2::transfer::share_object<Round>(v0);
    }

    entry fun random(arg0: &mut Round, arg1: u64, arg2: vector<u8>) : Winner {
        arg0.round = arg0.round + 1;
        let v0 = 0xe53343b7a64ec5fed2e126e7a521c1794db28d04ec07c1475f9e2b83bc41ed14::drand_lib::derive_randomness(arg2);
        let v1 = Winner{
            prize          : arg1,
            winning_number : 0xe53343b7a64ec5fed2e126e7a521c1794db28d04ec07c1475f9e2b83bc41ed14::drand_lib::safe_selection(18775, &v0),
        };
        0x2::event::emit<Winner>(v1);
        v1
    }

    // decompiled from Move bytecode v6
}

