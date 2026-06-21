module 0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::claim_liquidity_scallop {
    public fun claim_with_liquidity_scallop<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claimable_amount<T0>(arg0, 0x2::tx_context::sender(arg6), arg5);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0);
        if (v1 < v0) {
            0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::scallop::pool_withdraw_scallop<T0>(arg0, arg1, arg2, arg4, arg3, arg5, v0 - v1, arg6);
            assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0) >= v0, 13906834298897432577);
        };
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claim<T0>(arg0, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

