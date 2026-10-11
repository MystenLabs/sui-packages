module 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::fulfill_order {
    struct OrderPreparedToFulfill has copy, drop {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        driver: address,
        currency_id: address,
        coin_type: 0x1::ascii::String,
        amount_in: u64,
        amount_in_swap: u64,
        fee_redeem: u64,
        fee_ref: u64,
        fee_mayan: u64,
        gas_drop: u64,
    }

    struct OrderFulfilled has copy, drop {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        addr_dest: address,
        token_out: address,
        coin_type: 0x1::ascii::String,
        amount_out: u64,
    }

    struct FulfillReceipt {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        addr_dest: address,
        token_out: address,
        amount_out_min: u64,
    }

    public fun complete_fulfill_order<T0>(arg0: &0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::State, arg1: &0x2::coin_registry::Currency<T0>, arg2: 0x2::coin::Coin<T0>, arg3: FulfillReceipt) {
        0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::assert_valid_version(arg0);
        let FulfillReceipt {
            cctp_nonce         : v0,
            cctp_source_domain : v1,
            addr_dest          : v2,
            token_out          : v3,
            amount_out_min     : v4,
        } = arg3;
        let v5 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v5) == v3, 2);
        let v6 = 0x2::coin::value<T0>(&arg2);
        assert!(v6 >= 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::denormalize_amount(v4, 0x2::coin_registry::decimals<T0>(arg1)), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v2);
        let v7 = OrderFulfilled{
            cctp_nonce         : v0,
            cctp_source_domain : v1,
            addr_dest          : v2,
            token_out          : v3,
            coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount_out         : v6,
        };
        0x2::event::emit<OrderFulfilled>(v7);
    }

    public fun get_fulfill_receipt_addr_dest(arg0: &FulfillReceipt) : address {
        arg0.addr_dest
    }

    public fun get_fulfill_receipt_amount_out_min(arg0: &FulfillReceipt) : u64 {
        arg0.amount_out_min
    }

    public fun get_fulfill_receipt_nonce(arg0: &FulfillReceipt) : u256 {
        arg0.cctp_nonce
    }

    public fun get_fulfill_receipt_token_out(arg0: &FulfillReceipt) : address {
        arg0.token_out
    }

    public fun start_fulfill_order<T0: drop>(arg0: &mut 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::State, arg1: &mut 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::FundsReceiver, arg2: &0xcc3077222cba99e18fcd9ccc3412591508f50eff0092822a8df5f12803a1dec2::state::FeeManagerState, arg3: &0x2::coin_registry::Currency<T0>, arg4: u256, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, FulfillReceipt) {
        0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::assert_valid_version(arg0);
        assert!(0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::is_whitelisted_driver(arg0, 0x2::tx_context::sender(arg8)), 0);
        let (v0, _, v2, v3, v4) = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::remove_pending_order(arg0, arg4);
        assert!(v2 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>(), 1);
        let (v5, v6, v7, v8, v9, v10, _, v12, v13, v14) = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::order_payload::unpack(v4);
        let v15 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg3);
        let v16 = 0x2::object::id_to_address(&v15);
        assert!(v7 != v16, 2);
        assert!(v12 > 0x2::clock::timestamp_ms(arg7) / 1000, 3);
        let v17 = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::receive_minted_funds<T0>(arg1, v3, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::denormalize_amount(v9, 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::sui_decimals()), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, v6);
        let v18 = 0x1::u64::min(v10, v3);
        let v19 = 0x2::coin::value<T0>(&v17);
        let v20 = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::cap_fee_rate(v14);
        let v21 = if (v13 != @0x0) {
            0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::bps(v19, (v20 as u16))
        } else {
            0
        };
        let v22 = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::bps(v19, (0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::cap_fee_rate(0xcc3077222cba99e18fcd9ccc3412591508f50eff0092822a8df5f12803a1dec2::calculate_fast_mctp_fee::calculate_protocol_fee_rate(arg2, v5, v0, v16, v19, v7, v13, v20)) as u16));
        if (v21 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v17, v21, arg8), v13);
        };
        if (v22 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v17, v22, arg8), 0xcc3077222cba99e18fcd9ccc3412591508f50eff0092822a8df5f12803a1dec2::state::get_fee_collector(arg2));
        };
        let v23 = OrderPreparedToFulfill{
            cctp_nonce         : arg4,
            cctp_source_domain : v0,
            driver             : 0x2::tx_context::sender(arg8),
            currency_id        : v16,
            coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount_in          : v3,
            amount_in_swap     : 0x2::coin::value<T0>(&v17),
            fee_redeem         : v18,
            fee_ref            : v21,
            fee_mayan          : v22,
            gas_drop           : 0x2::coin::value<0x2::sui::SUI>(&arg6),
        };
        0x2::event::emit<OrderPreparedToFulfill>(v23);
        let v24 = FulfillReceipt{
            cctp_nonce         : arg4,
            cctp_source_domain : v0,
            addr_dest          : v6,
            token_out          : v7,
            amount_out_min     : v8,
        };
        (0x2::coin::split<T0>(&mut v17, v18, arg8), v17, v24)
    }

    // decompiled from Move bytecode v7
}

