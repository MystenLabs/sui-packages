module 0xe6799c8363cfac5d93e63c6bcd3dc32c79ca1c05cb96d47ba7e54c230f4ea396::navi_adaptor {
    struct NaviHealthFactorVerified has copy, drop {
        account: address,
        health_factor: u256,
        safe_check_hf: u256,
    }

    public fun is_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u256) : bool {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg1, arg2, arg3) > arg4
    }

    public fun verify_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u256) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg1, arg2, arg3);
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

