module 0x8496ac8b922176918fa1091fcda4eb677f2d68b038c834c805c0ab8c8ba81449::suilend {
    struct SuilendSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg1, arg2, arg3);
        let v1 = SuilendSwapEvent{
            amount_in    : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            amount_out   : 0x2::coin::value<T0>(&v0),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<0x2::sui::SUI>(),
            coin_b       : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SuilendSwapEvent>(v1);
        v0
    }

    public fun swap_b2a<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, arg2, arg1, arg3);
        let v1 = SuilendSwapEvent{
            amount_in    : 0x2::coin::value<T0>(&arg2),
            amount_out   : 0x2::coin::value<0x2::sui::SUI>(&v0),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<0x2::sui::SUI>(),
            coin_b       : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SuilendSwapEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

