module 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::combine {
    public fun combine<T0, T1: drop>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<T0>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, arg3: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg4: &T1, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth<T1>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_auth_type_ref<T0>(arg1));
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::escrow_id(&arg2) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(&arg0), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_combine_pt_yt_mismatch());
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(&arg3) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<T0>(&arg0), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_combine_pt_yt_mismatch());
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth_match(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_auth_type_ref<T0>(arg1), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::adapter_auth_type_ref(&arg2));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth_match(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_auth_type_ref<T0>(arg1), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::adapter_auth_type_ref(&arg3));
        let (v0, v1) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::consume_for_combine<T0, T1>(&mut arg0, arg1, arg4, arg5, arg6);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::destroy_for_base(arg2);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::destroy_for_base(arg3);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::destroy_settled<T0>(arg0);
        (v0, v1)
    }

    public fun total_value<T0>(arg0: &0x2::balance::Balance<T0>, arg1: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0) + 0x2::balance::value<T0>(arg1)
    }

    // decompiled from Move bytecode v7
}

