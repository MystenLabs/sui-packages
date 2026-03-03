module 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::referral {
    public fun update_referral_claim_pause(arg0: &0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::referral_admin::update_referral_claim_pause(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::referral_admin::update_referral_params(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

