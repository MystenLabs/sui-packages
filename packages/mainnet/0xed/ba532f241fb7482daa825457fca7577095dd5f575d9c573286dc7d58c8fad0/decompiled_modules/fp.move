module 0xedba532f241fb7482daa825457fca7577095dd5f575d9c573286dc7d58c8fad0::fp {
    public fun ferra<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u32, arg2: bool) {
        assert!(within((0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0) as u128), (arg1 as u128), arg2), 112);
    }

    public fun flowx_amm<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u128, arg2: bool) {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0));
        assert!(v0 > 0 && within(ratio(v0, v1), arg1, arg2), 115);
    }

    public fun kriya<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: u128, arg2: bool) {
        let (v0, v1, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        assert!(v0 > 0 && within(ratio(v0, v1), arg1, arg2), 114);
    }

    public fun momentum2<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(within(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0), arg1, arg2), 108);
    }

    public fun oracle_pool<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg1: &0x2::clock::Clock, arg2: u128, arg3: bool) {
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg0, arg1);
        assert!(within(v0, arg2, arg3), 116);
    }

    fun ratio(arg0: u64, arg1: u64) : u128 {
        ((arg1 as u128) << 64) / (arg0 as u128)
    }

    fun within(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 >= arg1 || arg0 <= arg1
    }

    // decompiled from Move bytecode v7
}

