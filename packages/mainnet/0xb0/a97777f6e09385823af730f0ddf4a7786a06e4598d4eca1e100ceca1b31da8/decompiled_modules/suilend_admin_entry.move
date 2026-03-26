module 0xb0a97777f6e09385823af730f0ddf4a7786a06e4598d4eca1e100ceca1b31da8::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVGlobal, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T1, T2>, arg2: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVPoolAdminCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::assert_version(arg0);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3), arg4);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::store_protocol_cap<T1, T2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::suilend_obligation_cap_key(), 0xb0a97777f6e09385823af730f0ddf4a7786a06e4598d4eca1e100ceca1b31da8::suilend_adapter::create_obligation<T0>(arg3, arg5));
    }

    // decompiled from Move bytecode v6
}

