module 0x52fc07d314d3cc41fb6b9b6a62ac1f5473e919174e388cf6d4aaafbab1adfe7b::steammfe {
    struct SteammfeSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::pool::Pool<T3, T4, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::cpmm::CpQuoter, T5>, arg1: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::Bank<T0, T1, T3>, arg2: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = if (arg6) {
            0x2::coin::value<T1>(&arg4)
        } else {
            0x2::coin::value<T2>(&arg5)
        };
        let v1 = 0x2::coin::from_balance<T1>(0x2::coin::into_balance<T1>(arg4), arg8);
        let v2 = 0x2::coin::from_balance<T2>(0x2::coin::into_balance<T2>(arg5), arg8);
        0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::script_v1::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, &mut v1, &mut v2, arg6, v0, 0, arg7, arg8);
        (v1, v2)
    }

    public fun swap_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::pool::Pool<T3, T4, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::cpmm::CpQuoter, T5>, arg1: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::Bank<T0, T1, T3>, arg2: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::zero<T2>(arg6);
        let (v1, v2) = swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, v0, true, arg5, arg6);
        let v3 = v2;
        0x52fc07d314d3cc41fb6b9b6a62ac1f5473e919174e388cf6d4aaafbab1adfe7b::utils::transfer_or_destroy_coin<T1>(v1, arg6);
        let v4 = SteammfeSwapEvent{
            amount_in    : 0x2::coin::value<T1>(&arg4),
            amount_out   : 0x2::coin::value<T2>(&v3),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T1>(),
            coin_b       : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<SteammfeSwapEvent>(v4);
        v3
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::pool::Pool<T3, T4, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::cpmm::CpQuoter, T5>, arg1: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::Bank<T0, T1, T3>, arg2: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg6);
        let (v1, v2) = swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v0, arg4, false, arg5, arg6);
        let v3 = v1;
        0x52fc07d314d3cc41fb6b9b6a62ac1f5473e919174e388cf6d4aaafbab1adfe7b::utils::transfer_or_destroy_coin<T2>(v2, arg6);
        let v4 = SteammfeSwapEvent{
            amount_in    : 0x2::coin::value<T2>(&arg4),
            amount_out   : 0x2::coin::value<T1>(&v3),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T1>(),
            coin_b       : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<SteammfeSwapEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

