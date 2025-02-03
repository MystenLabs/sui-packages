module 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::restrict {
    struct RestrictInvestorAbility has drop {
        dummy_field: bool,
    }

    public fun restrict_investor<T0>(arg0: &0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: address) {
        assert!(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::has_ability<T0, RestrictInvestorAbility>(arg0), 9223372118459154433);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::investors_config::restrict_investor<T0>(arg1, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::policy_cap<T0>(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

