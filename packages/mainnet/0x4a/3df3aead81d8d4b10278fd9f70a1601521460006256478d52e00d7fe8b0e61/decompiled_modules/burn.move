module 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::burn {
    struct BurnAbility has drop {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &mut 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::Auth<T0>, arg1: 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::SecurityToken<T0>) {
        assert!(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::has_ability<T0, BurnAbility>(arg0), 9223372088394383361);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::burn<T0>(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::treasury_cap_mut<T0>(arg0), 0x2::object::id<0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::SecurityToken<T0>>(&arg1), arg1);
    }

    public fun burn_amount<T0>(arg0: &mut 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::Auth<T0>, arg1: &mut 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::SecurityToken<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::has_ability<T0, BurnAbility>(arg0), 9223372135639023617);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::burn<T0>(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::treasury_cap_mut<T0>(arg0), 0x2::object::id<0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::SecurityToken<T0>>(arg1), 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::split_with_treasury_cap<T0>(arg1, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::treasury_cap<T0>(arg0), arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

