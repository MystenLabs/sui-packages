module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::blocklist {
    struct BlocklistInvestorAbility has drop {
        dummy_field: bool,
    }

    public fun blocklist_investor<T0>(arg0: &0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: address) {
        assert!(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::has_ability<T0, BlocklistInvestorAbility>(arg0), 9223372118459154433);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::investors_config::blocklist_investor<T0>(arg1, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::auth::policy_cap<T0>(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

