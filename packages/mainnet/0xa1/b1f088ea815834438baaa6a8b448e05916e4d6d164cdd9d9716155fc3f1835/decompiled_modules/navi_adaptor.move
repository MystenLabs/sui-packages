module 0xa1b1f088ea815834438baaa6a8b448e05916e4d6d164cdd9d9716155fc3f1835::navi_adaptor {
    struct NaviHealthFactorVerified has copy, drop {
        account: address,
        health_factor: u256,
        safe_check_hf: u256,
    }

    public fun is_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg2: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: address, arg4: u256) : bool {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::logic::user_health_factor(arg0, arg1, arg2, arg3) > arg4
    }

    public fun verify_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg2: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: address, arg4: u256) {
        let v0 = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::logic::user_health_factor(arg0, arg1, arg2, arg3);
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

    // decompiled from Move bytecode v6
}

