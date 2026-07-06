module 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::referral {
    public fun update_referral_claim_pause(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::referral_admin::update_referral_claim_pause(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::referral_admin::update_referral_params(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

