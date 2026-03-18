module 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::referral {
    public fun update_referral_claim_pause(arg0: &0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::referral_admin::update_referral_claim_pause(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::referral_admin::update_referral_params(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

