module 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill {
    struct FulfillWinnerPrepared has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    struct OrderFulfilled has copy, drop {
        hash: address,
    }

    public fun complete_fulfill<T0>(arg0: &mut 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::State, arg1: &0xe3040102b5b4d6241b22e2c3c6d2abb41595849d939326e3d67bfd537ea34ee::state::FeeManagerState, arg2: &0x2::clock::Clock, arg3: 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::FulfillMessage, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, _, _) = handle_fulfill<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun complete_fulfill_with_post<T0>(arg0: &mut 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::State, arg1: &0xe3040102b5b4d6241b22e2c3c6d2abb41595849d939326e3d67bfd537ea34ee::state::FeeManagerState, arg2: &0x2::clock::Clock, arg3: 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::FulfillMessage, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let (v0, v1, v2) = handle_fulfill<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::borrow_mut_emitter_cap(arg0), 0, 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::unlock_message::serialize(0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::unlock_message::new(v0, v1, v2, arg8)))
    }

    fun handle_fulfill<T0>(arg0: &mut 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::State, arg1: &0xe3040102b5b4d6241b22e2c3c6d2abb41595849d939326e3d67bfd537ea34ee::state::FeeManagerState, arg2: &0x2::clock::Clock, arg3: 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::FulfillMessage, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : (address, u16, address) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::unpack(arg3);
        assert!(!0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::has_dest_order(arg0, v0), 5);
        assert!(v4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(v12 == 0x2::tx_context::sender(arg9), 2);
        assert!(v8 > 0x2::clock::timestamp_ms(arg2) / 1000, 6);
        let v13 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg5);
        assert!(0x2::object::id_to_address(&v13) == v5, 7);
        let v14 = 0x2::coin::value<T0>(&arg4);
        let v15 = 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::amount::bps(v14, (v10 as u16));
        let v16 = 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::amount::bps(v14, (v11 as u16));
        assert!(v14 - v15 - v16 >= 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::amount::denormalize_amount(v6, 0x2::coin::get_decimals<T0>(arg5)), 8);
        if (v7 > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg6), 9);
            assert!(0x2::coin::value<0x2::sui::SUI>(0x1::option::borrow<0x2::coin::Coin<0x2::sui::SUI>>(&arg6)) >= 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::amount::denormalize_amount(v7, 0x2::coin::get_decimals<0x2::sui::SUI>(arg7)), 9);
        };
        0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::fulfill_dest_order<T0>(arg0, arg4, arg6, v3, v9, 0xe3040102b5b4d6241b22e2c3c6d2abb41595849d939326e3d67bfd537ea34ee::state::get_fee_collector(arg1), v15, v16, v0, v1, v2, arg8, arg9);
        let v17 = OrderFulfilled{hash: v0};
        0x2::event::emit<OrderFulfilled>(v17);
        (v0, v1, v2)
    }

    public fun prepare_fulfill_simple(arg0: &0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::State, arg1: address, arg2: address, arg3: u16, arg4: address, arg5: address, arg6: u16, arg7: address, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u8, arg15: u8, arg16: u8, arg17: address, arg18: &0x2::tx_context::TxContext) : 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::FulfillMessage {
        assert!(!0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::is_paused(arg0), 0);
        assert!(arg6 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(arg16 == 1, 3);
        let v0 = 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::order::new(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        assert!(0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::order::to_hash(&v0) == arg1, 4);
        0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::new(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13, arg14, arg15, 0x2::tx_context::sender(arg18))
    }

    public fun prepare_fulfill_winner(arg0: &0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg2: &0x2::tx_context::TxContext) : 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::FulfillMessage {
        assert!(!0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::is_paused(arg0), 0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::state::verify_auction_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let v3 = 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::deserialize(v2);
        assert!(0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::get_chain_dest(&v3) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 1);
        assert!(0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::get_driver(&v3) == 0x2::tx_context::sender(arg2), 2);
        let v4 = FulfillWinnerPrepared{
            hash         : 0x86d4d54e91d0cff32d832fd63e148f8090cf8435360cca6adf556284b150d6dd::fulfill_message::get_hash(&v3),
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1),
        };
        0x2::event::emit<FulfillWinnerPrepared>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

