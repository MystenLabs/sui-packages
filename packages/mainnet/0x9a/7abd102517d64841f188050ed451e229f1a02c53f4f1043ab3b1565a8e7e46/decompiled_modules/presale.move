module 0x9a7abd102517d64841f188050ed451e229f1a02c53f4f1043ab3b1565a8e7e46::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        status: u8,
        raised: u64,
        presale_tokens: 0x2::coin::Coin<T0>,
        liquidity_tokens: 0x2::coin::Coin<T0>,
        creator_tokens: 0x2::coin::Coin<T0>,
        team_tokens: 0x2::coin::Coin<T0>,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create_presale<T0: drop + store + key>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Presale<T0>{
            id               : 0x2::object::new(arg2),
            status           : 0,
            raised           : 0,
            presale_tokens   : 0x2::coin::mint<T0>(arg0, arg1, arg2),
            liquidity_tokens : 0x2::coin::mint<T0>(arg0, arg1, arg2),
            creator_tokens   : 0x2::coin::mint<T0>(arg0, arg1, arg2),
            team_tokens      : 0x2::coin::mint<T0>(arg0, arg1, arg2),
            sui_raised       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<Presale<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

