module 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::mint {
    struct MintAbility has drop {
        dummy_field: bool,
    }

    public fun mint<T0>(arg0: &mut 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::has_ability<T0, MintAbility>(arg0), 9223372144228958209);
        assert!(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::investors_config::is_whitelisted<T0>(arg1, arg3), 9223372148524056579);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::security_token::mint<T0>(0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::auth::treasury_cap_mut<T0>(arg0), arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

