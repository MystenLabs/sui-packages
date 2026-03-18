module 0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::referral {
    public fun update_referral_claim_pause(arg0: &0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::DragonBallCollector, arg1: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_functional(arg0);
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::referral_admin::update_referral_claim_pause(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::DragonBallCollector, arg1: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_functional(arg0);
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::referral_admin::update_referral_params(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

