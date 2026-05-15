module 0xc996af634114c283978fa94b7226f69ca2599df7be5814439bdfb90489c16930::govex {
    public fun swap_a2b<T0, T1, T2>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg3: u64, arg4: address, arg5: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg6: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x7279de2610213cdc1da0945f41f7ef7a58abf343e88165fb443be60f066e00a2::swap_entry::swap_spot_asset_to_stable<T0, T1, T2>(arg2, arg1, arg3, arg4, 0x1::option::none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(), true, arg5, arg6, arg7, arg8, arg9);
        transfer_balance_if_present<T0, T1>(v1, 0x2::tx_context::sender(arg9));
        0x1::option::destroy_some<0x2::coin::Coin<T1>>(v0)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg3: u64, arg4: address, arg5: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg6: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x7279de2610213cdc1da0945f41f7ef7a58abf343e88165fb443be60f066e00a2::swap_entry::swap_spot_stable_to_asset<T0, T1, T2>(arg2, arg1, arg3, arg4, 0x1::option::none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(), true, arg5, arg6, arg7, arg8, arg9);
        transfer_balance_if_present<T0, T1>(v1, 0x2::tx_context::sender(arg9));
        0x1::option::destroy_some<0x2::coin::Coin<T0>>(v0)
    }

    fun transfer_balance_if_present<T0, T1>(arg0: 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg1: address) {
        if (0x1::option::is_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg0)) {
            0x2::transfer::public_transfer<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(0x1::option::destroy_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg0), arg1);
        } else {
            0x1::option::destroy_none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

