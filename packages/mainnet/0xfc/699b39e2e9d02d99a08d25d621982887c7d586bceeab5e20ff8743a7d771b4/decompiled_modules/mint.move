module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::mint {
    struct MintAbility has drop {
        dummy_field: bool,
    }

    public fun mint<T0>(arg0: &mut 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::has_ability<T0, MintAbility>(arg0), 9223372144228958209);
        assert!(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::investors_config::is_whitelisted<T0>(arg1, arg3), 9223372148524056579);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::mint<T0>(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::treasury_cap_mut<T0>(arg0), arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

