module 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::init_order {
    struct OrderCreated has copy, drop {
        hash: address,
        trader: address,
        token_in: address,
        amount_in: u64,
        amount_in_normalized: u64,
        locked_fund_id: 0x2::object::ID,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_cancel: u64,
        fee_refund: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        auction_mode: u8,
        key_rnd: address,
    }

    struct PrepareOrderTouched has copy, drop {
        coin_type: 0x1::ascii::String,
        coin_metadata: 0x2::object::ID,
        amount_in_initial: u64,
    }

    public fun initialize_order<T0>(arg0: &mut 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::state::State, arg1: address, arg2: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg3: &0xd260b616703c9c976719f4e5375a74e642603a1518dcb813246f5e782729af99::state::FeeManagerState, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: u64, arg7: address, arg8: u16, arg9: address, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: address, arg16: u8, arg17: u8, arg18: address, arg19: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch_timestamp_ms(arg19);
        assert!(!0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::state::is_paused(arg0), 0);
        assert!(0x2::coin::value<T0>(&arg4) >= arg6, 2);
        let v0 = 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::amount::normalize_amount(0x2::coin::value<T0>(&arg4), 0x2::coin::get_decimals<T0>(arg5));
        assert!(v0 > arg12 + arg13, 3);
        let v1 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg2);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::token_address<T0>(&v1));
        let v3 = 0xd260b616703c9c976719f4e5375a74e642603a1518dcb813246f5e782729af99::calculate_fee_rate::calculate_fee(arg3, arg9, arg8, v2, arg10, v0, arg15, arg16);
        assert!(arg16 <= 50, 45);
        assert!(v3 <= 50, 4);
        if (arg15 == @0x0) {
            assert!(arg16 == 0, 45);
        };
        let v4 = 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::order::new(arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), v2, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v3, arg17, arg18);
        let v5 = 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::order::to_hash(&v4);
        assert!(!0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::state::has_source_order(arg0, v5), 1);
        assert!(!0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::state::has_dest_order(arg0, v5), 1);
        let (v6, v7) = 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::state::add_source_order<T0>(arg0, 0x2::coin::into_balance<T0>(arg4), v5, arg1, v2, arg8, arg12, arg13, arg19);
        let v8 = OrderCreated{
            hash                 : v5,
            trader               : arg1,
            token_in             : v2,
            amount_in            : v6,
            amount_in_normalized : v0,
            locked_fund_id       : v7,
            addr_dest            : arg7,
            chain_dest           : arg8,
            token_out            : arg9,
            amount_out_min       : arg10,
            gas_drop             : arg11,
            fee_cancel           : arg12,
            fee_refund           : arg13,
            deadline             : arg14,
            addr_ref             : arg15,
            fee_rate_ref         : arg16,
            fee_rate_mayan       : v3,
            auction_mode         : arg17,
            key_rnd              : arg18,
        };
        0x2::event::emit<OrderCreated>(v8);
    }

    public fun prepare_initialize_order<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &0x2::coin::CoinMetadata<T0>) {
        let v0 = PrepareOrderTouched{
            coin_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_metadata     : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1),
            amount_in_initial : 0x2::coin::value<T0>(arg0),
        };
        0x2::event::emit<PrepareOrderTouched>(v0);
    }

    // decompiled from Move bytecode v6
}

