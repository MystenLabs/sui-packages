module 0xfbc02ebf345aacd073be8e9dfda01e51c708de7ada1b6afacbd8cefa8ea83352::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        assert!(!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::has_protocol_cap<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::SuilendObligationCapKey>(arg1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::suilend_obligation_cap_key()), 1);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), arg3);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::store_protocol_cap<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::suilend_obligation_cap_key(), 0xfbc02ebf345aacd073be8e9dfda01e51c708de7ada1b6afacbd8cefa8ea83352::suilend_adapter::create_obligation<T0>(arg2, arg4), arg4);
    }

    public fun register_suilend_leg_auth<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::register_protocol_leg_auth<T0, T1, 0xfbc02ebf345aacd073be8e9dfda01e51c708de7ada1b6afacbd8cefa8ea83352::suilend_entry::SuilendLegAuth>(arg1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_SUILEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

