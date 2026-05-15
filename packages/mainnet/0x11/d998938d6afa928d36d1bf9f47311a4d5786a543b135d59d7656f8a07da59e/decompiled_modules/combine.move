module 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::combine {
    public fun combine<T0, T1: drop>(arg0: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::SplitEscrow<T0>, arg1: &mut 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::MarketCore<T0>, arg2: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::pt_object::PTObject, arg3: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject, arg4: &T1, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T1>(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::adapter_auth_type_ref<T0>(arg1));
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::pt_object::escrow_id(&arg2) == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::id<T0>(&arg0), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_combine_pt_yt_mismatch());
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::escrow_id(&arg3) == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::id<T0>(&arg0), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_combine_pt_yt_mismatch());
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth_match(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::adapter_auth_type_ref<T0>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::pt_object::adapter_auth_type_ref(&arg2));
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth_match(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::adapter_auth_type_ref<T0>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::adapter_auth_type_ref(&arg3));
        let (v0, v1) = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::consume_for_combine<T0, T1>(&mut arg0, arg1, arg4, arg5, arg6);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::pt_object::destroy_for_base(arg2);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::destroy_for_base(arg3);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::destroy_settled<T0>(arg0);
        (v0, v1)
    }

    public fun total_value<T0>(arg0: &0x2::balance::Balance<T0>, arg1: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0) + 0x2::balance::value<T0>(arg1)
    }

    // decompiled from Move bytecode v7
}

