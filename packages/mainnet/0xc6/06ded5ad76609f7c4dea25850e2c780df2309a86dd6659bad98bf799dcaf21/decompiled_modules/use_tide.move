module 0xc606ded5ad76609f7c4dea25850e2c780df2309a86dd6659bad98bf799dcaf21::use_tide {
    public fun balances<T0, T1>(arg0: &0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_amm::TidePool) : (u64, u64) {
        0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_amm::balances<T0, T1>(arg0)
    }

    // decompiled from Move bytecode v6
}

