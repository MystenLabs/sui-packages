module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi_oracle {
    public fun bound<T0, T1>(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8, arg3: u8, arg4: &0x2::coin_registry::Currency<T0>, arg5: &0x2::coin_registry::Currency<T1>, arg6: u64) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::MarketBound<T0, T1> {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::new<T0, T1>(0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg0), feed<T0>(arg1, arg2), feed<T1>(arg1, arg3), 0x2::coin_registry::decimals<T0>(arg4), 0x2::coin_registry::decimals<T1>(arg5), arg6)
    }

    fun feed<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8) : u8 {
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, arg1) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg0, arg1)
    }

    public(friend) fun price(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg1: u8, arg2: &0x2::clock::Clock) : (u256, u8) {
        let (v0, v1, v2) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg2, arg0, arg1);
        assert!(v0, 0);
        (v1, v2)
    }

    // decompiled from Move bytecode v7
}

