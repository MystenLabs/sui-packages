module 0xe55b2efc3896c9b8553a43562b6331fb7a36b550466b3d3ce9fda77c6f83ec8d::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        raised: u64,
        presale_tokens: 0x2::coin::Coin<T0>,
        liquidity_tokens: 0x2::coin::Coin<T0>,
        creator_tokens: 0x2::coin::Coin<T0>,
        team_tokens: 0x2::coin::Coin<T0>,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create_presale<T0: drop + store + key>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Presale<T0>{
            id               : 0x2::object::new(arg5),
            raised           : 0,
            presale_tokens   : 0x2::coin::mint<T0>(arg0, arg1, arg5),
            liquidity_tokens : 0x2::coin::mint<T0>(arg0, arg2, arg5),
            creator_tokens   : 0x2::coin::mint<T0>(arg0, arg4, arg5),
            team_tokens      : 0x2::coin::mint<T0>(arg0, arg3, arg5),
            sui_raised       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<Presale<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

