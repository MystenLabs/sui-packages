module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::token_gated_rule {
    struct TokenGatedRule<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Config<phantom T0> has store {
        min_balance: u64,
    }

    public fun add<T0, T1>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap, arg2: u64, arg3: bool) {
        let v0 = TokenGatedRule<T1>{dummy_field: false};
        let v1 = Config<T1>{min_balance: arg2};
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add<T0, TokenGatedRule<T1>, Config<T1>>(v0, arg0, arg1, v1, arg3);
    }

    public fun remove<T0, T1>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let Config {  } = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::remove<T0, TokenGatedRule<T1>, Config<T1>>(arg0, arg1);
    }

    public fun min_balance<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>) : u64 {
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, TokenGatedRule<T1>, Config<T1>>(arg0).min_balance
    }

    public fun prove<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<T0>, arg2: &0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(arg2) >= 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, TokenGatedRule<T1>, Config<T1>>(arg0).min_balance, 0);
        let v0 = TokenGatedRule<T1>{dummy_field: false};
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add_approval<T0, TokenGatedRule<T1>>(v0, arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

