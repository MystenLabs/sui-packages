module 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::referral {
    public fun update_referral_claim_pause(arg0: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::referral_admin::update_referral_claim_pause(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::referral_admin::update_referral_params(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

