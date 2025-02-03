module 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::quote {
    fun get_amount_out(arg0: 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::fees::Fees, arg1: u64) : u64 {
        arg1 - 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::fees::get_fee_out_amount(&arg0, arg1)
    }

    public fun amount_out<T0, T1, T2>(arg0: &0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound_curve_amm::SeedPool, arg1: u64) : u64 {
        if (0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::utils::is_coin_x<T0, T1>()) {
            let (v1, v2, v3) = get_pool_data<T0, T1, T2>(arg0);
            let v4 = v3;
            get_amount_out(v4, 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound::get_amount_out(arg1 - 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::fees::get_fee_in_amount(&v4, arg1), v1, v2, true))
        } else {
            let (v5, v6, v7) = get_pool_data<T1, T0, T2>(arg0);
            let v8 = v7;
            get_amount_out(v8, 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound::get_amount_out(arg1 - 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::fees::get_fee_in_amount(&v8, arg1), v5, v6, false))
        }
    }

    fun get_pool_data<T0, T1, T2>(arg0: &0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound_curve_amm::SeedPool) : (u64, u64, 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::fees::Fees) {
        (0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound_curve_amm::balance_x<T0, T1, T2>(arg0), 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound_curve_amm::balance_y<T0, T1, T2>(arg0), 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound_curve_amm::fees<T0, T1, T2>(arg0))
    }

    // decompiled from Move bytecode v6
}

