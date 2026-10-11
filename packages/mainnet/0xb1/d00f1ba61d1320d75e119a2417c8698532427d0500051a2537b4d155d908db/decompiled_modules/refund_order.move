module 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::refund_order {
    struct OrderRefunded has copy, drop {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        addr_dest: address,
        currency_id: address,
        coin_type: 0x1::ascii::String,
        amount_in: u64,
        amount_refunded: u64,
        fee_refund: u64,
        gas_drop: u64,
        relayer: address,
    }

    public fun refund_order<T0: drop>(arg0: &mut 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::State, arg1: &mut 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::FundsReceiver, arg2: &0x2::coin_registry::Currency<T0>, arg3: u256, arg4: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::assert_valid_version(arg0);
        let (v0, _, v2, v3, v4) = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::remove_pending_order(arg0, arg3);
        assert!(v2 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>(), 0);
        let (_, v6, v7, _, v9, _, v11, v12, _, _) = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::order_payload::unpack(v4);
        let v15 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg2);
        let v16 = 0x2::object::id_to_address(&v15);
        assert!(v12 <= 0x2::clock::timestamp_ms(arg6) / 1000 || v7 == v16, 1);
        let v17 = 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::state::receive_minted_funds<T0>(arg1, v3, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::denormalize_amount(v9, 0xb1d00f1ba61d1320d75e119a2417c8698532427d0500051a2537b4d155d908db::amount::sui_decimals()), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v6);
        let v18 = 0x1::u64::min(v11, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v17, v6);
        let v19 = OrderRefunded{
            cctp_nonce         : arg3,
            cctp_source_domain : v0,
            addr_dest          : v6,
            currency_id        : v16,
            coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount_in          : v3,
            amount_refunded    : 0x2::coin::value<T0>(&v17),
            fee_refund         : v18,
            gas_drop           : 0x2::coin::value<0x2::sui::SUI>(&arg5),
            relayer            : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<OrderRefunded>(v19);
        0x2::coin::split<T0>(&mut v17, v18, arg7)
    }

    // decompiled from Move bytecode v7
}

