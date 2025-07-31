module 0x21716b4ede9cfc3d07f42a6f34b0914d6aee3c188fbc65b77407795ba37771c4::navi_adaptor {
    public fun is_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u256) : bool {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg1, arg2, arg3) > arg4
    }

    public fun verify_navi_position_healthy(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u256) {
        assert!(is_navi_position_healthy(arg0, arg1, arg2, arg3, arg4), 1);
    }

    // decompiled from Move bytecode v6
}

