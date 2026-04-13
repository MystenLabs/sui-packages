module 0x47f4f464e774f1f2a5527311a64a9ea5475933764145e9783185c361517f4109::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        raised: u64,
        presale_tokens: 0x2::coin::Coin<T0>,
        liquidity_tokens: 0x2::coin::Coin<T0>,
        team_tokens: 0x2::coin::Coin<T0>,
        creator_tokens: 0x2::coin::Coin<T0>,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
        contributions: 0x2::table::Table<address, u64>,
    }

    public entry fun contribute<T0: drop + store + key>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::table::add<address, u64>(&mut arg0.contributions, 0x2::tx_context::sender(arg3), v0);
        arg0.raised = arg0.raised + v0;
    }

    public entry fun create<T0: drop + store + key>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Presale<T0>{
            id               : 0x2::object::new(arg6),
            raised           : 0,
            presale_tokens   : 0x2::coin::mint<T0>(arg0, arg1, arg6),
            liquidity_tokens : 0x2::coin::mint<T0>(arg0, arg2, arg6),
            team_tokens      : 0x2::coin::mint<T0>(arg0, arg3, arg6),
            creator_tokens   : 0x2::coin::mint<T0>(arg0, arg4, arg6),
            sui_raised       : 0x2::balance::zero<0x2::sui::SUI>(),
            contributions    : 0x2::table::new<address, u64>(arg6),
        };
        0x2::transfer::transfer<Presale<T0>>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

