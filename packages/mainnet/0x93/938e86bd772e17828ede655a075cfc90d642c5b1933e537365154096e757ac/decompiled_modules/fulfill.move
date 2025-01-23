module 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::fulfill {
    struct FulfillWinnerPrepared has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    struct OrderFulfilled has copy, drop {
        hash: address,
        amount_fulfilled: u64,
        dest_order_status: u8,
        locked_funds_id: 0x1::option::Option<0x2::object::ID>,
        with_post: bool,
    }

    struct FulfillTicket has drop {
        order: 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::Order,
        order_hash: address,
        winner: address,
        amount_promised: u64,
    }

    public fun complete_fulfill<T0>(arg0: &mut 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: &0x2::clock::Clock, arg2: FulfillTicket, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let (v0, v1, v2) = handle_fulfill<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v3 = OrderFulfilled{
            hash              : arg2.order_hash,
            amount_fulfilled  : v1,
            dest_order_status : v0,
            locked_funds_id   : v2,
            with_post         : false,
        };
        0x2::event::emit<OrderFulfilled>(v3);
    }

    public fun complete_fulfill_with_post<T0>(arg0: &mut 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: &0x2::clock::Clock, arg2: FulfillTicket, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let v0 = arg2.order_hash;
        let (v1, v2, v3) = handle_fulfill<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v4 = OrderFulfilled{
            hash              : v0,
            amount_fulfilled  : v2,
            dest_order_status : v1,
            locked_funds_id   : v3,
            with_post         : true,
        };
        0x2::event::emit<OrderFulfilled>(v4);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::borrow_mut_emitter_cap(arg0), 0, 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_message::serialize(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_message::new(v0, 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::chain_source(&arg2.order), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::token_in(&arg2.order), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::addr_ref(&arg2.order), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::fee_rate_ref(&arg2.order), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::fee_rate_mayan(&arg2.order), arg7, arg2.winner, 0x2::clock::timestamp_ms(arg1) / 1000)))
    }

    fun handle_fulfill<T0>(arg0: &mut 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: &0x2::clock::Clock, arg2: FulfillTicket, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : (u8, u64, 0x1::option::Option<0x2::object::ID>) {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let FulfillTicket {
            order           : v0,
            order_hash      : v1,
            winner          : v2,
            amount_promised : v3,
        } = arg2;
        let v4 = v0;
        assert!(!0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::has_dest_order(arg0, v1), 4);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::chain_dest(&v4) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(v2 == 0x2::tx_context::sender(arg8), 1);
        let v5 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::deadline(&v4) > v5, 5);
        let v6 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4);
        assert!(0x2::object::id_to_address(&v6) == 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::token_out(&v4), 6);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::amount::normalize_amount(0x2::coin::value<T0>(&arg3), 0x2::coin::get_decimals<T0>(arg4)) >= v3, 7);
        if (0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::gas_drop(&v4) > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::amount::denormalize_amount(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::gas_drop(&v4), 0x2::coin::get_decimals<0x2::sui::SUI>(arg6)), 8);
        };
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::fulfill_dest_order<T0>(arg0, arg3, arg5, 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::addr_dest(&v4), v1, 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::chain_source(&v4), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::token_in(&v4), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::addr_ref(&v4), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::fee_rate_ref(&v4), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::fee_rate_mayan(&v4), arg7, v2, v5, 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::payload_type(&v4), 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::custom_payload(&v4), arg8)
    }

    public fun prepare_fulfill_simple(arg0: &0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: &0x2::clock::Clock, arg2: address, arg3: u8, arg4: address, arg5: u16, arg6: address, arg7: address, arg8: u16, arg9: address, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u16, arg16: address, arg17: u8, arg18: u8, arg19: u8, arg20: u64, arg21: u64, arg22: address, arg23: address, arg24: &0x2::tx_context::TxContext) : FulfillTicket {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        assert!(arg8 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(arg19 == 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::auction_mode_dont_care(), 2);
        let v0 = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::new(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::to_hash(&v0) == arg2, 3);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::deadline(&v0) > 0x2::clock::timestamp_ms(arg1) / 1000, 5);
        FulfillTicket{
            order           : v0,
            order_hash      : arg2,
            winner          : 0x2::tx_context::sender(arg24),
            amount_promised : arg10,
        }
    }

    public fun prepare_fulfill_winner(arg0: &0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg2: &0x2::clock::Clock, arg3: u8, arg4: address, arg5: u16, arg6: address, arg7: address, arg8: u16, arg9: address, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u16, arg16: address, arg17: u8, arg18: u8, arg19: u8, arg20: u64, arg21: u64, arg22: address, arg23: address, arg24: &0x2::tx_context::TxContext) : FulfillTicket {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::verify_auction_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5) = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::fulfill_message::unpack(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::fulfill_message::deserialize(v2));
        let v6 = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::new(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        assert!(v3 == 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::to_hash(&v6), 3);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::chain_dest(&v6) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::auction_mode(&v6) != 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::auction_mode_dont_care(), 2);
        let v7 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::deadline(&v6) > v7, 5);
        if (v7 >= 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::deadline(&v6) - (0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::order::penalty_period(&v6) as u64)) {
            assert!(v5 == 0x2::tx_context::sender(arg24), 1);
        };
        let v8 = FulfillWinnerPrepared{
            hash         : v3,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1),
        };
        0x2::event::emit<FulfillWinnerPrepared>(v8);
        FulfillTicket{
            order           : v6,
            order_hash      : v3,
            winner          : 0x2::tx_context::sender(arg24),
            amount_promised : v4,
        }
    }

    // decompiled from Move bytecode v6
}

