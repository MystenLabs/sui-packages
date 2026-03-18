module 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::referral {
    public fun update_referral_claim_pause(arg0: &0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::referral_admin::update_referral_claim_pause(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::referral_admin::update_referral_params(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

