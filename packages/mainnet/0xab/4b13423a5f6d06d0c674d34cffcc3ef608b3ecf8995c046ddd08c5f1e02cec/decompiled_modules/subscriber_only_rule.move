module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::subscriber_only_rule {
    struct SubscriberOnlyRule has drop {
        dummy_field: bool,
    }

    struct Config has store {
        tiers: vector<0x2::object::ID>,
    }

    public fun add<T0>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap, arg2: vector<0x2::object::ID>, arg3: bool) {
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg2), 2);
        let v0 = SubscriberOnlyRule{dummy_field: false};
        let v1 = Config{tiers: arg2};
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add<T0, SubscriberOnlyRule, Config>(v0, arg0, arg1, v1, arg3);
    }

    public fun remove<T0>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let Config {  } = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::remove<T0, SubscriberOnlyRule, Config>(arg0, arg1);
    }

    public fun prove<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<T0>, arg2: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::subscriptions::Tier<T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::subscriptions::Tier<T1>>(arg2);
        assert!(0x1::vector::contains<0x2::object::ID>(&0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, SubscriberOnlyRule, Config>(arg0).tiers, &v0), 0);
        assert!(0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::subscriptions::is_active_subscriber<T1>(arg2, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_account<T0>(arg1), arg3), 1);
        let v1 = SubscriberOnlyRule{dummy_field: false};
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add_approval<T0, SubscriberOnlyRule>(v1, arg0, arg1);
    }

    public fun tiers<T0>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>) : vector<0x2::object::ID> {
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, SubscriberOnlyRule, Config>(arg0).tiers
    }

    // decompiled from Move bytecode v7
}

