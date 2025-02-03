module 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::transferflag {
    struct UpdateTransferFlagAbility has drop {
        dummy_field: bool,
    }

    public fun update_transfer_flag<T0>(arg0: &mut 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64) {
        assert!(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::has_ability<T0, UpdateTransferFlagAbility>(arg0), 9223372118459154433);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::transfer_config::update_transfer_flag<T0>(arg1, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::policy_cap_mut<T0>(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

