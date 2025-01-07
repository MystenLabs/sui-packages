module 0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::init_order {
    struct OrderCreated has copy, drop {
        hash: address,
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

    public fun initialize_order<T0>(arg0: &mut 0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::state::State, arg1: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0xd260b616703c9c976719f4e5375a74e642603a1518dcb813246f5e782729af99::state::FeeManagerState, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: u64, arg6: address, arg7: u16, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: u8, arg16: u8, arg17: address, arg18: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch_timestamp_ms(arg18);
        assert!(!0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::state::is_paused(arg0), 0);
        assert!(0x2::coin::value<T0>(&arg3) >= arg5, 2);
        let v0 = 0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::amount::normalize_amount(0x2::coin::value<T0>(&arg3), 0x2::coin::get_decimals<T0>(arg4));
        assert!(v0 > arg11 + arg12, 3);
        let v1 = 0x2::tx_context::sender(arg18);
        let v2 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg1);
        let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::token_address<T0>(&v2));
        let v4 = 0xd260b616703c9c976719f4e5375a74e642603a1518dcb813246f5e782729af99::calculate_fee_rate::calculate_fee(arg2, arg8, arg7, v3, arg9, v0, arg14, arg15);
        assert!(arg15 <= 50, 45);
        assert!(v4 <= 50, 4);
        if (arg14 == @0x0) {
            assert!(arg15 == 0, 45);
        };
        let v5 = 0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::order::new(v1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), v3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v4, arg16, arg17);
        let v6 = 0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::order::to_hash(&v5);
        assert!(!0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::state::has_source_order(arg0, v6), 1);
        assert!(!0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::state::has_dest_order(arg0, v6), 1);
        let (v7, v8) = 0xbeac1dac87a4a85cb13234ee219e4c9233381c61ef216f0c65904403a263b202::state::add_source_order<T0>(arg0, 0x2::coin::into_balance<T0>(arg3), v6, v1, v3, arg7, arg11, arg12, arg18);
        let v9 = OrderCreated{
            hash                 : v6,
            token_in             : v3,
            amount_in            : v7,
            amount_in_normalized : v0,
            locked_fund_id       : v8,
            addr_dest            : arg6,
            chain_dest           : arg7,
            token_out            : arg8,
            amount_out_min       : arg9,
            gas_drop             : arg10,
            fee_cancel           : arg11,
            fee_refund           : arg12,
            deadline             : arg13,
            addr_ref             : arg14,
            fee_rate_ref         : arg15,
            fee_rate_mayan       : v4,
            auction_mode         : arg16,
            key_rnd              : arg17,
        };
        0x2::event::emit<OrderCreated>(v9);
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

