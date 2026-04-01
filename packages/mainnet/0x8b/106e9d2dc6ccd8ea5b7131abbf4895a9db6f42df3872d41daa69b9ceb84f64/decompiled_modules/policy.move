module 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::policy {
    struct PolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AgentPolicy has drop, store {
        owner: address,
        max_per_transaction: u64,
        max_per_period: u64,
        period_ms: u64,
        period_start: u64,
        period_spent: u64,
        whitelisted_recipients: vector<address>,
        expiry: u64,
    }

    struct PolicySet has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        max_per_transaction: u64,
        max_per_period: u64,
        period_ms: u64,
    }

    struct PolicyRevoked has copy, drop {
        account_id: 0x2::object::ID,
    }

    struct PolicyViolation has copy, drop {
        account_id: 0x2::object::ID,
        violation: u64,
        amount: u64,
    }

    public(friend) fun check_and_record(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = PolicyKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_ref(arg0), v0)) {
            return
        };
        let v1 = PolicyKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_mut(arg0), v1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        if (v2.expiry > 0) {
            assert!(v3 <= v2.expiry, 304);
        };
        assert!(arg1 <= v2.max_per_transaction, 301);
        if (!0x1::vector::is_empty<address>(&v2.whitelisted_recipients)) {
            assert!(0x1::vector::contains<address>(&v2.whitelisted_recipients, &arg2), 303);
        };
        if (v3 >= v2.period_start + v2.period_ms) {
            v2.period_start = v3;
            v2.period_spent = 0;
        };
        assert!(v2.period_spent + arg1 <= v2.max_per_period, 302);
        v2.period_spent = v2.period_spent + arg1;
    }

    public fun get_max_per_period(arg0: &0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount) : u64 {
        let v0 = PolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_ref(arg0), v0).max_per_period
    }

    public fun get_max_per_transaction(arg0: &0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount) : u64 {
        let v0 = PolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_ref(arg0), v0).max_per_transaction
    }

    public fun get_period_spent(arg0: &0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount) : u64 {
        let v0 = PolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_ref(arg0), v0).period_spent
    }

    public fun get_policy_owner(arg0: &0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount) : address {
        let v0 = PolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_ref(arg0), v0).owner
    }

    public fun has_policy(arg0: &0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount) : bool {
        let v0 = PolicyKey{dummy_field: false};
        0x2::dynamic_field::exists_<PolicyKey>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_ref(arg0), v0)
    }

    public fun revoke_policy(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_policy(arg0), 305);
        let v0 = PolicyKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_mut(arg0), v0);
        assert!(0x2::tx_context::sender(arg1) == v1.owner, 300);
        let v2 = PolicyRevoked{account_id: 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::account_id(arg0)};
        0x2::event::emit<PolicyRevoked>(v2);
    }

    public fun set_policy(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: u64, arg2: u64, arg3: u64, arg4: vector<address>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!has_policy(arg0), 306);
        let v1 = AgentPolicy{
            owner                  : v0,
            max_per_transaction    : arg1,
            max_per_period         : arg2,
            period_ms              : arg3,
            period_start           : 0x2::clock::timestamp_ms(arg6),
            period_spent           : 0,
            whitelisted_recipients : arg4,
            expiry                 : arg5,
        };
        let v2 = PolicyKey{dummy_field: false};
        0x2::dynamic_field::add<PolicyKey, AgentPolicy>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::id_mut(arg0), v2, v1);
        let v3 = PolicySet{
            account_id          : 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::account_id(arg0),
            owner               : v0,
            max_per_transaction : arg1,
            max_per_period      : arg2,
            period_ms           : arg3,
        };
        0x2::event::emit<PolicySet>(v3);
    }

    // decompiled from Move bytecode v6
}

