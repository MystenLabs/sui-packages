module 0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::claim_liquidity {
    public fun claim_with_liquidity<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg7: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg8: &0x2::clock::Clock, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claimable_amount<T0>(arg0, 0x2::tx_context::sender(arg10), arg8);
        if (0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0) < v0) {
            0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::navi::pool_withdraw_navi<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg6, arg9, v0 - 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0), arg10);
            assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0) >= v0, 13906834337552138241);
        };
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claim<T0>(arg0, arg8, arg10)
    }

    // decompiled from Move bytecode v7
}

