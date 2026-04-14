module 0x215f7bb059b7ef4c152476edba969b5c992ca83536c68b8a084f24f88c7ad900::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::LLVGlobal, arg1: &mut 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T1, T2>, arg2: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::LLVPoolAdminCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::assert_version(arg0);
        assert!(!0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::has_protocol_cap<T1, T2, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::SuilendObligationCapKey>(arg1, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::suilend_obligation_cap_key()), 1);
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::store_protocol_cap<T1, T2, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, arg2, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::suilend_obligation_cap_key(), 0x215f7bb059b7ef4c152476edba969b5c992ca83536c68b8a084f24f88c7ad900::suilend_adapter::create_obligation<T0>(arg3, arg5));
    }

    // decompiled from Move bytecode v7
}

