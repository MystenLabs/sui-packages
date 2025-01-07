module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_crosschain {
    public entry fun deposit_collateral<T0, T1>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::ProtectedEC, arg4: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg0);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T1>>(arg1, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T1>());
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::new_holder_key(0x1::string::utf8(arg6), 0x1::string::utf8(arg7));
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::contain<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolderKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolder<T0, T1>>(arg2, v1), 7);
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolderKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolder<T0, T1>>(arg2, v1);
        let v3 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChainKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChain>(arg1, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain_key(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::lend_chain<T0, T1>(v2)));
        let v4 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::cross_chain_fee(v3);
        let v5 = 0x2::coin::value<T1>(&arg8);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::is_created_status<T0, T1>(v2), 10);
        assert!(0x2::tx_context::sender(arg10) == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::borrower<T0, T1>(v2), 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg4) + v4, 12);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::add_collateral_balance<T0, T1>(v2, 0x2::coin::into_balance<T1>(arg8));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::deposit_collateral<T0, T1>(v2, v5, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T1>(v0)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v4, arg10), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::relayer_wallet(arg1));
        let v6 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T1>(v0));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::send_message(arg3, arg4, gen_deposit_collateral_message_payload((0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::lend_chain<T0, T1>(v2) as u64), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::chain_address(v3), arg6, v5, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::collateral_amount<T0, T1>(v2), *0x1::string::bytes(&v6), arg7), arg5, arg9);
    }

    public entry fun withdraw_collateral<T0, T1>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg1: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg2: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::ProtectedEC, arg4: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg0);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>());
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T1>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T1>());
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::price_feed::is_valid_price_info_object<T0>(arg9, v0), 3);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::price_feed::is_valid_price_info_object<T1>(arg10, v1), 4);
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolderKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolder<T0, T1>>(arg1, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::new_holder_key(0x1::string::utf8(arg6), 0x1::string::utf8(arg7)));
        let v3 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::collateral_amount<T0, T1>(v2);
        let v4 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChainKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChain>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain_key(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::lend_chain<T0, T1>(v2)));
        let v5 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::cross_chain_fee(v4);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::is_created_status<T0, T1>(v2), 10);
        assert!(0x2::tx_context::sender(arg12) == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::borrower<T0, T1>(v2), 9);
        assert!(v3 >= arg8, 11);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg4) + v5, 12);
        let v6 = v3 - arg8;
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::is_valid_collateral_amount<T0, T1>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::min_health_ratio(arg2), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::lend_amount<T0, T1>(v2), v6, v0, v1, arg9, arg10, arg11), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::sub_collateral_balance<T0, T1>(v2, arg8), arg12), 0x2::tx_context::sender(arg12));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::withdraw_collateral<T0, T1>(v2, arg8, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T1>(v1)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v5, arg12), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::relayer_wallet(arg2));
        let v7 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T1>(v1));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::send_message(arg3, arg4, gen_withdraw_collateral_message_payload((0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::lend_chain<T0, T1>(v2) as u64), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::chain_address(v4), arg6, arg8, v6, *0x1::string::bytes(&v7), arg7), arg5, arg11);
    }

    public entry fun deposit_collateral_to_take_loan<T0, T1>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg1: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg2: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::ProtectedEC, arg4: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<T1>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg0);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>());
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T1>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T1>());
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::cross_chain_fee(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChainKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChain>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain_key(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::chain_id<T0>(v0))));
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::is_lend_coin<T0>(v0), 1);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::is_collateral_coin<T1>(v1), 2);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::price_feed::is_valid_price_info_object<T0>(arg7, v0), 3);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::price_feed::is_valid_price_info_object<T1>(arg8, v1), 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg4) + v2, 12);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::is_valid_collateral_amount<T0, T1>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::min_health_ratio(arg2), arg12, 0x2::coin::value<T1>(&arg6), v0, v1, arg7, arg8, arg16), 6);
        let v3 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::new_holder_key(0x1::string::utf8(arg10), 0x1::string::utf8(arg11));
        assert!(!0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::contain<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolderKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolder<T0, T1>>(arg1, v3), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v2, arg17), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::relayer_wallet(arg2));
        let v4 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T0>(v0));
        let v5 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T1>(v1));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::send_message(arg3, arg4, gen_collateral_created_message_payload(arg14, arg15, arg9, arg10, arg12, *0x1::string::bytes(&v4), arg13, 0x2::coin::value<T1>(&arg6), *0x1::string::bytes(&v5), arg11), arg5, arg16);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::add<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolderKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::CollateralHolder<T0, T1>>(arg1, v3, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::collateral_holder::new<T0, T1>(0x1::string::utf8(arg10), (arg14 as u16), arg12, 0x2::tx_context::sender(arg17), 0x2::coin::into_balance<T1>(arg6), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T1>(v1)), 0x1::string::utf8(arg11), 0x2::clock::timestamp_ms(arg16), arg17));
    }

    fun gen_collateral_created_message_payload(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg0));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::create_loan_offer_cross_chain_fun());
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg4));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg6));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg7));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg8);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg9);
        v0
    }

    fun gen_deposit_collateral_message_payload(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg0));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::update_deposit_collateral_cross_chain_fun());
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg3));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg4));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg6);
        v0
    }

    fun gen_repay_loan_message_payload(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg0));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::refund_collateral_to_repaid_borrower_fun());
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg3);
        v0
    }

    fun gen_withdraw_collateral_message_payload(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg0));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::update_withdraw_collateral_cross_chain_fun());
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg3));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::u64_to_string(arg4));
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, b",");
        0x1::vector::append<u8>(&mut v0, arg6);
        v0
    }

    public entry fun repay<T0, T1>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::custodian::Custodian<T0>, arg4: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::ProtectedEC, arg5: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg0);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg1, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>());
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T1>>(arg1, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T1>());
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChainKey, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::ForeignChain>(arg1, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::new_foreign_chain_key(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::chain_id<T1>(v1)));
        let v3 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::LoanKey<T0, T1>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::Loan<T0, T1>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::new_loan_key<T0, T1>(arg8));
        let v4 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::cross_chain_fee(v2);
        assert!(0x2::tx_context::sender(arg10) == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::borrower<T0, T1>(v3), 14);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::is_fund_transferred_status<T0, T1>(v3), 13);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::start_timestamp<T0, T1>(v3) + 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::duration<T0, T1>(v3) * 1000 > 0x2::clock::timestamp_ms(arg9), 15);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg5) + v4, 12);
        let v5 = ((((0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::amount<T0, T1>(v3) * 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::interest<T0, T1>(v3) / 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::default_rate_factor() * 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::duration<T0, T1>(v3)) as u128) / (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::seconds_in_year() as u128)) as u64);
        let v6 = ((((v5 * 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrower_fee_percent(arg1)) as u128) / (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::default_rate_factor() as u128)) as u64);
        let v7 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::amount<T0, T1>(v3) + v6 + v5;
        assert!(0x2::coin::value<T0>(&arg7) == v7, 16);
        let v8 = 0x2::coin::into_balance<T0>(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg10), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::hot_wallet(arg1));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::custodian::add_treasury_balance<T0>(arg3, 0x2::balance::split<T0>(&mut v8, v6));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::repay<T0, T1>(v3, v7, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::collateral_amount<T0, T1>(v3), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T0>(v0)), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::token_address<T1>(v1)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v4, arg10), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::relayer_wallet(arg1));
        let v9 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::offer_id<T0, T1>(v3);
        let v10 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(0x2::object::id_to_address(&v9))));
        let v11 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char_without_prefix(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry::borrower<T0, T1>(v3))));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole::send_message(arg4, arg5, gen_repay_loan_message_payload((0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::chain_id<T1>(v1) as u64), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::foreign_chain::chain_address(v2), *0x1::string::bytes(&v10), *0x1::string::bytes(&v11)), arg6, arg9);
    }

    // decompiled from Move bytecode v6
}

