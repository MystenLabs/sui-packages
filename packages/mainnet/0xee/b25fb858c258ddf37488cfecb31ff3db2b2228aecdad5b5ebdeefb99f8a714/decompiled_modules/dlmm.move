module 0xeeb25fb858c258ddf37488cfecb31ff3db2b2228aecdad5b5ebdeefb99f8a714::dlmm {
    struct DlmmSwapEvent has copy, drop, store {
        pair: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::config::GlobalConfig, arg1: &mut 0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::lb_pair::swap<T0, T1>(arg0, arg1, true, arg3, arg2, 0x2::coin::zero<T1>(arg5), arg4, arg5);
        let v2 = v1;
        let v3 = DlmmSwapEvent{
            pair         : 0x2::object::id<0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::lb_pair::LBPair<T0, T1>>(arg1),
            amount_in    : 0x2::coin::value<T0>(&arg2),
            amount_out   : 0x2::coin::value<T1>(&v2),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DlmmSwapEvent>(v3);
        0xeeb25fb858c258ddf37488cfecb31ff3db2b2228aecdad5b5ebdeefb99f8a714::utils::transfer_or_destroy_coin<T0>(v0, arg5);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::config::GlobalConfig, arg1: &mut 0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::lb_pair::swap<T0, T1>(arg0, arg1, false, arg3, 0x2::coin::zero<T0>(arg5), arg2, arg4, arg5);
        let v2 = v0;
        let v3 = DlmmSwapEvent{
            pair         : 0x2::object::id<0x9bcead5aa8d76d730bd70614bfdaf3fe6c5f323f0df561a0d5373cdaee469e9b::lb_pair::LBPair<T0, T1>>(arg1),
            amount_in    : 0x2::coin::value<T1>(&arg2),
            amount_out   : 0x2::coin::value<T0>(&v2),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DlmmSwapEvent>(v3);
        0xeeb25fb858c258ddf37488cfecb31ff3db2b2228aecdad5b5ebdeefb99f8a714::utils::transfer_or_destroy_coin<T1>(v1, arg5);
        v2
    }

    // decompiled from Move bytecode v6
}

