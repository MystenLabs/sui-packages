module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::sealed_swap_action {
    public fun begin_sealed_swap<T0>(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::KeeperRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::swap_action::SwapReceipt) {
        assert!(!0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_paused(arg2), 261);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_allowed(arg2, 0x2::tx_context::sender(arg7)), 262);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_type(0x1::vector::borrow<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::ActionBlock>(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::actions<T0>(arg0), 0)) == 0, 260);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::sealed_intent::verify_sealed_data<T0>(arg0, &arg5);
        let (v0, v1, v2) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::sealed_intent::deserialize_sealed_data(arg5);
        let v3 = v1;
        let (v4, v5, v6, v7) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::swap_action::deserialize_swap_params_v3(v2);
        let v8 = if (v6 > 0) {
            v6
        } else {
            0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::max_oracle_freshness_ms(arg1)
        };
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::swap_action::check_oracle_freshness(arg3, v8, arg6);
        let (v9, v10, v11) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::execute_sealed<T0>(arg0, arg1, v0, &v3, arg4, arg6, arg7);
        let v12 = v9;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::treasury(arg1));
        let v13 = 0x2::coin::value<T0>(&v12);
        let v14 = if (v5 > 0) {
            v5
        } else {
            0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::swap_action::oracle_min_output(arg3, v13, v4)
        };
        (v12, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::swap_action::new_receipt(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T0>>(arg0), 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::owner<T0>(arg0), v14, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::swap_action::oracle_expected_output(arg3, v13, v4), v7))
    }

    // decompiled from Move bytecode v6
}

