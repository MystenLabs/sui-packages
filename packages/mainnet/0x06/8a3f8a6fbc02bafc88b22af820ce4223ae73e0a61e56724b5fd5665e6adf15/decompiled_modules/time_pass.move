module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::time_pass {
    struct Policy has drop {
        dummy_field: bool,
    }

    struct Config has store {
        issuance_enabled: bool,
        price_per_ms: u64,
        minimum_duration_ms: u64,
        maximum_duration_ms: u64,
    }

    struct State has store {
        valid_from_ms: u64,
        valid_until_ms: u64,
    }

    struct TimePassCreatedEvent has copy, drop {
        tool: 0x2::object::ID,
        cashier: 0x2::object::ID,
        pass: 0x2::object::ID,
        beneficiary: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind,
        valid_from_ms: u64,
        valid_until_ms: u64,
    }

    struct TimePassOfferChangedEvent has copy, drop {
        cashier: 0x2::object::ID,
        issuance_enabled: bool,
        price_per_ms: u64,
        minimum_duration_ms: u64,
        maximum_duration_ms: u64,
    }

    public fun collect(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: vector<0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>>) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = Policy{dummy_field: false};
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::collect<Policy>(arg0, arg1, v0, arg2)
    }

    fun assert_valid_terms(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 13906835746301673477);
        assert!(arg1 > 0 && arg1 <= arg2, 13906835759186313217);
    }

    public fun buy(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = buy_(arg0, arg1, arg2, arg3, arg4, arg5);
        share(v0);
        v1
    }

    fun buy_(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, 0x2::object::ID) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        assert!(v1.issuance_enabled, 13906834685444882439);
        assert!(arg3 >= v1.minimum_duration_ms && arg3 <= v1.maximum_duration_ms, 13906834702624358401);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v2 <= 18446744073709551615 - arg3, 13906834715510046733);
        let v3 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::send_deposit(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), checked_multiply(v1.price_per_ms, arg3)), arg5);
        (new_pass(arg0, arg2, v2, v2 + arg3, arg5), v3)
    }

    public fun buy_more(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        assert!(v1.issuance_enabled, 13906834870128476167);
        assert!(arg3 >= v1.minimum_duration_ms && arg3 <= v1.maximum_duration_ms, 13906834887307952129);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_cashier<Policy, State>(arg1) == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), 13906834895898411017);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = Policy{dummy_field: false};
        let v4 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state<Policy, State>(arg1, v3).valid_until_ms;
        let v5 = if (v2 < v4) {
            v4
        } else {
            v2
        };
        assert!(v5 <= 18446744073709551615 - arg3, 13906834913078542349);
        let v6 = Policy{dummy_field: false};
        let v7 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state_mut<Policy, State>(arg1, v6);
        if (v2 >= v7.valid_until_ms) {
            v7.valid_from_ms = v2;
        };
        v7.valid_until_ms = v5 + arg3;
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::send_deposit(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), checked_multiply(v1.price_per_ms, arg3)), arg5)
    }

    fun checked_multiply(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 == 0 || arg0 <= 18446744073709551615 / arg1, 13906835492899127309);
        arg0 * arg1
    }

    public fun close_issuance(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config_mut<Policy, Config>(arg0, arg1, v0);
        v1.issuance_enabled = false;
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), v1);
    }

    public fun derive_id(arg0: 0x2::object::ID, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind) : 0x2::object::ID {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::derive_policy_account_id<Policy>(arg0, arg1)
    }

    fun emit_offer(arg0: 0x2::object::ID, arg1: &Config) {
        let v0 = TimePassOfferChangedEvent{
            cashier             : arg0,
            issuance_enabled    : arg1.issuance_enabled,
            price_per_ms        : arg1.price_per_ms,
            minimum_duration_ms : arg1.minimum_duration_ms,
            maximum_duration_ms : arg1.maximum_duration_ms,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<TimePassOfferChangedEvent>(v0);
    }

    public fun enable(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: u64, arg3: u64, arg4: u64) {
        assert_valid_terms(arg2, arg3, arg4);
        let v0 = Config{
            issuance_enabled    : true,
            price_per_ms        : arg2,
            minimum_duration_ms : arg3,
            maximum_duration_ms : arg4,
        };
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), &v0);
        let v1 = Policy{dummy_field: false};
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::add_policy_with_config<Policy, Config>(arg0, arg1, v1, v0);
    }

    public fun get_invocation(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationRequest, arg3: &mut 0x2::tx_context::TxContext) : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation {
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::invocation_request_authorized_at_ms(&arg2);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_cashier<Policy, State>(arg1) == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0) && 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_beneficiary<Policy, State>(arg1) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::invocation_request_source(&arg2), 13906835381229715465);
        let v1 = Policy{dummy_field: false};
        let v2 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state<Policy, State>(arg1, v1);
        assert!(v0 >= v2.valid_from_ms && v0 < v2.valid_until_ms, 13906835398409715723);
        let v3 = Policy{dummy_field: false};
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_id<Policy, State>(arg1));
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::new_invocation<Policy>(arg0, arg2, v3, v4, 0, arg3)
    }

    public fun issue(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State> {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::assert_owner(arg0, arg1);
        let v0 = Policy{dummy_field: false};
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0).issuance_enabled, 13906835222315794439);
        assert!(arg3 < arg4, 13906835226610499587);
        new_pass(arg0, arg2, arg3, arg4, arg5)
    }

    fun new_pass(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State> {
        let v0 = Policy{dummy_field: false};
        let v1 = State{
            valid_from_ms  : arg2,
            valid_until_ms : arg3,
        };
        let v2 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::new_policy_account<Policy, State>(arg0, arg1, v0, v1);
        let v3 = TimePassCreatedEvent{
            tool           : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool(arg0),
            cashier        : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0),
            pass           : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_id<Policy, State>(&v2),
            beneficiary    : arg1,
            valid_from_ms  : arg2,
            valid_until_ms : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<TimePassCreatedEvent>(v3);
        v2
    }

    public fun offer(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier) : (bool, u64, u64, u64) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        (v1.issuance_enabled, v1.price_per_ms, v1.minimum_duration_ms, v1.maximum_duration_ms)
    }

    public fun open_issuance(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config_mut<Policy, Config>(arg0, arg1, v0);
        v1.issuance_enabled = true;
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), v1);
    }

    public fun share(arg0: 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>) {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::share_policy_account<Policy, State>(arg0);
    }

    public fun update_terms(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: u64, arg3: u64, arg4: u64) {
        assert_valid_terms(arg2, arg3, arg4);
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config_mut<Policy, Config>(arg0, arg1, v0);
        v1.price_per_ms = arg2;
        v1.minimum_duration_ms = arg3;
        v1.maximum_duration_ms = arg4;
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), v1);
    }

    public fun update_window(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg2: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg3: u64, arg4: u64) {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::assert_owner(arg0, arg2);
        let v0 = Policy{dummy_field: false};
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0).issuance_enabled, 13906835286740303879);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_cashier<Policy, State>(arg1) == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), 13906835291035402249);
        assert!(arg3 < arg4, 13906835295329976323);
        let v1 = Policy{dummy_field: false};
        let v2 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state_mut<Policy, State>(arg1, v1);
        v2.valid_from_ms = arg3;
        v2.valid_until_ms = arg4;
    }

    public fun window(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>) : (u64, u64) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state<Policy, State>(arg0, v0);
        (v1.valid_from_ms, v1.valid_until_ms)
    }

    // decompiled from Move bytecode v7
}

