module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::simple_payment_rule {
    struct SimplePaymentRule has drop {
        dummy_field: bool,
    }

    struct Config<phantom T0> has store {
        amount: u64,
        recipient: address,
    }

    public fun add<T0, T1>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap, arg2: u64, arg3: address, arg4: bool) {
        let v0 = SimplePaymentRule{dummy_field: false};
        let v1 = Config<T1>{
            amount    : arg2,
            recipient : arg3,
        };
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add<T0, SimplePaymentRule, Config<T1>>(v0, arg0, arg1, v1, arg4);
    }

    public fun remove<T0, T1>(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let Config {
            amount    : _,
            recipient : _,
        } = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::remove<T0, SimplePaymentRule, Config<T1>>(arg0, arg1);
    }

    public fun amount<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>) : u64 {
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, SimplePaymentRule, Config<T1>>(arg0).amount
    }

    public fun pay<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::FeeConfig, arg2: u64, arg3: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::has_approval<T0, SimplePaymentRule>(arg0, arg3), 1);
        let v0 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, SimplePaymentRule, Config<T1>>(arg0);
        assert!(v0.amount == arg2, 2);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::collect<T1>(arg1, arg4, v0.amount, v0.recipient, arg5);
        let v1 = SimplePaymentRule{dummy_field: false};
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add_approval<T0, SimplePaymentRule>(v1, arg0, arg3);
    }

    public fun recipient<T0, T1>(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<T0>) : address {
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<T0, SimplePaymentRule, Config<T1>>(arg0).recipient
    }

    // decompiled from Move bytecode v7
}

