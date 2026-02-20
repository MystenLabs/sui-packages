module 0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::referral {
    public fun update_referral_claim_pause(arg0: &0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::DragonBallCollector, arg1: &mut 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_functional(arg0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::referral_admin::update_referral_claim_pause(0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::DragonBallCollector, arg1: &mut 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_functional(arg0);
        0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::referral_admin::update_referral_params(0x6cc212ed4d117713b39d2f235339f042be80579c20147baf25eac7458f3f9ee6::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

