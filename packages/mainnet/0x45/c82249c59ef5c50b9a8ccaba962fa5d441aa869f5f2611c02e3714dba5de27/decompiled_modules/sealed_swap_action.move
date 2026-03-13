module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_swap_action {
    public fun begin_sealed_swap<T0>(arg0: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<T0>, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::ProtocolConfig, arg2: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::KeeperRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action::SwapReceipt) {
        assert!(!0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_paused(arg2), 261);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_allowed(arg2, 0x2::tx_context::sender(arg8)), 262);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_type(0x1::vector::borrow<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::ActionBlock>(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::actions<T0>(arg0), 0)) == 0, 260);
        0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_intent::verify_sealed_data<T0>(arg0, &arg6);
        let (v0, v1, v2) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_intent::deserialize_sealed_data(arg6);
        let v3 = v1;
        let (v4, v5, v6) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action::deserialize_swap_params(v2);
        let v7 = if (v5 > 0) {
            v5
        } else {
            0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::max_oracle_freshness_ms(arg1)
        };
        0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action::check_oracle_freshness(arg3, v7, arg7);
        0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action::check_oracle_freshness(arg4, v7, arg7);
        let (v8, v9, v10) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::execute_sealed<T0>(arg0, arg1, v0, &v3, arg5, arg7, arg8);
        let v11 = v8;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::treasury(arg1));
        let v12 = 0x2::coin::value<T0>(&v11);
        let v13 = if (v4 > 0) {
            v4
        } else {
            0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action::cross_rate_min_output(arg3, arg4, v12)
        };
        (v11, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action::new_receipt(0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<T0>>(arg0), 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::owner<T0>(arg0), v13, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action::cross_rate_expected_output(arg3, arg4, v12), v6))
    }

    // decompiled from Move bytecode v6
}

