module 0x2c423fdb7a71fdc2bfcd1713b4a6cbec6f2ac78dce16bbc7c7a7942bfd31e125::navi_adaptor {
    struct NaviHealthFactorVerified has copy, drop {
        account: address,
        health_factor: u256,
        safe_check_hf: u256,
    }

    public fun is_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg3: address, arg4: u256) : bool {
        0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::logic::user_health_factor(arg0, arg1, arg2, arg3) > arg4
    }

    public fun verify_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::storage::Storage, arg2: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg3: address, arg4: u256) {
        let v0 = 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::logic::user_health_factor(arg0, arg1, arg2, arg3);
        let v1 = NaviHealthFactorVerified{
            account       : arg3,
            health_factor : v0,
            safe_check_hf : arg4,
        };
        0x2::event::emit<NaviHealthFactorVerified>(v1);
        let v2 = v0 / 1000000000000000000;
        let v3 = v2;
        if (v2 > 1000000000) {
            v3 = 1000000000;
        };
        assert!(v0 > arg4, (v3 as u64));
    }

    // decompiled from Move bytecode v7
}

