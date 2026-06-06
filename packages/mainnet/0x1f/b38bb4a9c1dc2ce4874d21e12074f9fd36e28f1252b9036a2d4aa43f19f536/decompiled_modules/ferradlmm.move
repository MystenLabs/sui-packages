module 0x1fb38bb4a9c1dc2ce4874d21e12074f9fd36e28f1252b9036a2d4aa43f19f536::ferradlmm {
    struct FerraDlmmSwapEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, arg2, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        let v2 = v1;
        0x1fb38bb4a9c1dc2ce4874d21e12074f9fd36e28f1252b9036a2d4aa43f19f536::utils::transfer_or_destroy_coin<T0>(v0, arg4);
        let v3 = FerraDlmmSwapEvent{
            pool_id      : 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg1),
            amount_in    : 0x2::coin::value<T0>(&arg2),
            amount_out   : 0x2::coin::value<T1>(&v2),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FerraDlmmSwapEvent>(v3);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), arg2, arg3, arg4);
        let v2 = v0;
        0x1fb38bb4a9c1dc2ce4874d21e12074f9fd36e28f1252b9036a2d4aa43f19f536::utils::transfer_or_destroy_coin<T1>(v1, arg4);
        let v3 = FerraDlmmSwapEvent{
            pool_id      : 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg1),
            amount_in    : 0x2::coin::value<T1>(&arg2),
            amount_out   : 0x2::coin::value<T0>(&v2),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FerraDlmmSwapEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

