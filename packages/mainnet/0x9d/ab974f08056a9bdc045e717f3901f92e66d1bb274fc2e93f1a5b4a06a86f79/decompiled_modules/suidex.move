module 0x9dab974f08056a9bdc045e717f3901f92e66d1bb274fc2e93f1a5b4a06a86f79::suidex {
    public fun append_model_0_to_1<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v2_edge(arg1, (v0 as u64), (v1 as u64), 3000, 1000000)
    }

    public fun append_model_1_to_0<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v2_edge(arg1, (v1 as u64), (v0 as u64), 3000, 1000000)
    }

    public fun model_0_to_1<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v2_route((v0 as u64), (v1 as u64), 3000, 1000000)
    }

    public fun model_1_to_0<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg0);
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v2_route((v1 as u64), (v0 as u64), 3000, 1000000)
    }

    public fun swap_exact_in_0_to_1<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens0_for_tokens1_composable<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T0>(arg3, arg5), 1, arg4, arg5))
    }

    public fun swap_exact_in_1_to_0<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens1_for_tokens0_composable<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T1>(arg3, arg5), 1, arg4, arg5))
    }

    // decompiled from Move bytecode v7
}

