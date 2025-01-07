module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::burn {
    struct BurnAbility has drop {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &mut 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::Auth<T0>, arg1: 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::SecurityToken<T0>) {
        assert!(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::has_ability<T0, BurnAbility>(arg0), 9223372088394383361);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::burn<T0>(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::treasury_cap_mut<T0>(arg0), 0x2::object::id<0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::SecurityToken<T0>>(&arg1), arg1);
    }

    public fun burn_amount<T0>(arg0: &mut 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::Auth<T0>, arg1: &mut 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::SecurityToken<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::has_ability<T0, BurnAbility>(arg0), 9223372135639023617);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::burn<T0>(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::treasury_cap_mut<T0>(arg0), 0x2::object::id<0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::SecurityToken<T0>>(arg1), 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token::split_with_treasury_cap<T0>(arg1, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::treasury_cap<T0>(arg0), arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

