module 0x6a597178a8270cb5301aaff09f7cabd5b64cd57361a1fde23e7801cdcea86df0::adapter {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0x9c6c8b7ebf4c46d8bc9189168d944da5fcb6823bcfd739af71e128550c57292::dlmm::swap_a2b<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T0>(arg0), arg4), 0, arg3, arg4)));
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0x9c6c8b7ebf4c46d8bc9189168d944da5fcb6823bcfd739af71e128550c57292::dlmm::swap_b2a<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T1>(arg0), arg4), 0, arg3, arg4)));
    }

    // decompiled from Move bytecode v6
}

