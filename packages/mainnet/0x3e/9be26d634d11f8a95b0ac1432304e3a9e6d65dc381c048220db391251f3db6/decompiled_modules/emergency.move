module 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::emergency {
    public entry fun emergency_withdraw<T0>(arg0: &mut 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::Vault<T0>, arg1: 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::ShareReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::emergency_mode<T0>(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_emergency_mode());
        assert!(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::vault_id(&arg1) == 0x2::object::id<0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::Vault<T0>>(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::wrong_vault_id());
        let v0 = 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::shares(&arg1);
        assert!(v0 > 0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::insufficient_shares());
        let v1 = (0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::mul_div((0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::idle_usdc_value<T0>(arg0) as u128), v0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::total_shares<T0>(arg0)) as u64);
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::burn_shares_from_total<T0>(arg0, v0);
        let v2 = 0x2::tx_context::sender(arg3);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::take_idle<T0>(arg0, v1), arg3), v2);
        };
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::destroy_receipt_forcibly(arg1);
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_emergency_withdraw(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_emergency_withdraw(0x2::object::id<0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::Vault<T0>>(arg0), v2, v0, v1, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault::idle_usdc_value<T0>(arg0), 0x2::clock::timestamp_ms(arg2)));
    }

    // decompiled from Move bytecode v7
}

