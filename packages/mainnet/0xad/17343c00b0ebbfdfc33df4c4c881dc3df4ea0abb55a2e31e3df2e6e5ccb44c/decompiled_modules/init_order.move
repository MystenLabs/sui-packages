module 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::init_order {
    struct OrderCreated has copy, drop {
        hash: address,
        payload_type: u8,
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
        penalty_period: u16,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        auction_mode: u8,
        base_bond: u64,
        per_bps_bond: u64,
        key_rnd: address,
        custom_payload: address,
    }

    struct InitOrderLogged has copy, drop {
        coin_type: 0x1::ascii::String,
        coin_metadata: 0x2::object::ID,
        amount_in_initial: u64,
        custom_payload_raw: vector<u8>,
        custom_payload_hash: address,
    }

    struct InitOrderTicket<phantom T0> {
        payload_type: u8,
        trader: address,
        input_funds: 0x2::balance::Balance<T0>,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_cancel: u64,
        fee_refund: u64,
        deadline: u64,
        penalty_period: u16,
        addr_ref: address,
        fee_rate_ref: u8,
        auction_mode: u8,
        base_bond: u64,
        per_bps_bond: u64,
        key_rnd: address,
        custom_payload: address,
    }

    public fun initialize_order<T0>(arg0: &mut 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::State, arg1: &0x2::coin::CoinMetadata<T0>, arg2: InitOrderTicket<T0>, arg3: 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::SwiftInitParams, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::is_paused(arg0), 0);
        0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::assert_valid_version(arg0);
        let InitOrderTicket {
            payload_type   : v0,
            trader         : v1,
            input_funds    : v2,
            addr_dest      : v3,
            chain_dest     : v4,
            token_out      : v5,
            amount_out_min : v6,
            gas_drop       : v7,
            fee_cancel     : v8,
            fee_refund     : v9,
            deadline       : v10,
            penalty_period : v11,
            addr_ref       : v12,
            fee_rate_ref   : v13,
            auction_mode   : v14,
            base_bond      : v15,
            per_bps_bond   : v16,
            key_rnd        : v17,
            custom_payload : v18,
        } = arg2;
        let v19 = v2;
        let v20 = 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::coin_metadata_id(&arg3);
        assert!(0x2::object::borrow_id<0x2::coin::CoinMetadata<T0>>(arg1) == &v20, 6);
        assert!(v0 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::payload_type(&arg3), 6);
        assert!(v1 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::trader(&arg3), 6);
        assert!(0x2::balance::value<T0>(&v19) == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::amount_in(&arg3), 6);
        assert!(v3 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::addr_dest(&arg3), 6);
        assert!(v4 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::chain_dest(&arg3), 6);
        assert!(v5 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::token_out(&arg3), 6);
        assert!(v6 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::amount_out_min(&arg3), 6);
        assert!(v7 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::gas_drop(&arg3), 6);
        assert!(v8 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::fee_cancel(&arg3), 6);
        assert!(v9 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::fee_refund(&arg3), 6);
        assert!(v10 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::deadline(&arg3), 6);
        assert!(v11 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::penalty_period(&arg3), 6);
        assert!(v12 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::addr_ref(&arg3), 6);
        assert!(v13 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::fee_rate_ref(&arg3), 6);
        assert!(v14 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::auction_mode(&arg3), 6);
        assert!(v15 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::base_bond(&arg3), 6);
        assert!(v16 == 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::per_bps_bond(&arg3), 6);
        let v21 = 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::amount::normalize_amount(0x2::balance::value<T0>(&v19), 0x2::coin::get_decimals<T0>(arg1));
        assert!(v21 > v8 + v9, 3);
        let v22 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id();
        assert!(v22 != v4, 7);
        let v23 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1);
        let v24 = 0x2::object::id_to_address(&v23);
        let v25 = 0xb6aa4fc21102728d1d9467de0129961f91dbc4fd73b903a2021d476656ef6fb2::calculate_swift_fee::fee_rate_mayan(&arg3);
        assert!(v13 <= 100, 5);
        assert!(v25 <= 100, 4);
        if (v12 == @0x0) {
            assert!(v13 == 0, 5);
        };
        let v26 = 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::order::new(v0, v1, v22, v24, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v25, v14, v15, v16, v17, v18);
        let v27 = 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::order::to_hash(&v26);
        assert!(!0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::has_source_order(arg0, v27), 1);
        assert!(!0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::has_dest_order(arg0, v27), 1);
        let (v28, v29) = 0xad17343c00b0ebbfdfc33df4c4c881dc3df4ea0abb55a2e31e3df2e6e5ccb44c::state::add_source_order<T0>(arg0, v19, v27, v1, v24, v4, v8, v9, arg4);
        let v30 = OrderCreated{
            hash                 : v27,
            payload_type         : v0,
            trader               : v1,
            token_in             : v24,
            amount_in            : v28,
            amount_in_normalized : v21,
            locked_fund_id       : v29,
            addr_dest            : v3,
            chain_dest           : v4,
            token_out            : v5,
            amount_out_min       : v6,
            gas_drop             : v7,
            fee_cancel           : v8,
            fee_refund           : v9,
            deadline             : v10,
            penalty_period       : v11,
            addr_ref             : v12,
            fee_rate_ref         : v13,
            fee_rate_mayan       : v25,
            auction_mode         : v14,
            base_bond            : v15,
            per_bps_bond         : v16,
            key_rnd              : v17,
            custom_payload       : v18,
        };
        0x2::event::emit<OrderCreated>(v30);
    }

    public fun log_initialize_order<T0>(arg0: u64, arg1: &0x2::coin::CoinMetadata<T0>, arg2: vector<u8>) {
        let v0 = InitOrderLogged{
            coin_type           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_metadata       : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1),
            amount_in_initial   : arg0,
            custom_payload_raw  : arg2,
            custom_payload_hash : 0x2::address::from_bytes(0x2::hash::keccak256(&arg2)),
        };
        0x2::event::emit<InitOrderLogged>(v0);
    }

    public fun prepare_initialize_order<T0>(arg0: u8, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u16, arg13: address, arg14: u8, arg15: u8, arg16: u64, arg17: u64, arg18: address, arg19: address) : InitOrderTicket<T0> {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        assert!(arg3 > 0, 2);
        InitOrderTicket<T0>{
            payload_type   : arg0,
            trader         : arg1,
            input_funds    : 0x2::coin::into_balance<T0>(arg2),
            addr_dest      : arg4,
            chain_dest     : arg5,
            token_out      : arg6,
            amount_out_min : arg7,
            gas_drop       : arg8,
            fee_cancel     : arg9,
            fee_refund     : arg10,
            deadline       : arg11,
            penalty_period : arg12,
            addr_ref       : arg13,
            fee_rate_ref   : arg14,
            auction_mode   : arg15,
            base_bond      : arg16,
            per_bps_bond   : arg17,
            key_rnd        : arg18,
            custom_payload : arg19,
        }
    }

    // decompiled from Move bytecode v6
}

