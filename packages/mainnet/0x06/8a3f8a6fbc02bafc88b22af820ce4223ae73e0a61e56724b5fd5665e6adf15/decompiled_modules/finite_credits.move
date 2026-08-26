module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::finite_credits {
    struct Policy has drop {
        dummy_field: bool,
    }

    struct Config has store {
        issuance_enabled: bool,
        price_per_credit: u64,
        minimum_credits: u64,
        maximum_credits: u64,
    }

    struct State has store {
        remaining: u64,
    }

    struct CreditReserve has store {
        dummy_field: bool,
    }

    struct CreditsCreatedEvent has copy, drop {
        tool: 0x2::object::ID,
        cashier: 0x2::object::ID,
        credits: 0x2::object::ID,
        beneficiary: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind,
        remaining: u64,
    }

    struct CreditOfferChangedEvent has copy, drop {
        cashier: 0x2::object::ID,
        issuance_enabled: bool,
        price_per_credit: u64,
        minimum_credits: u64,
        maximum_credits: u64,
    }

    fun assert_valid_terms(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 13906835870855856135);
        assert!(arg1 > 0 && arg1 <= arg2, 13906835875150692357);
    }

    public fun buy(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = buy_(arg0, arg1, arg2, arg3, arg4);
        share(v0);
        v1
    }

    fun buy_(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, 0x2::object::ID) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        assert!(v1.issuance_enabled, 13906834694034948105);
        assert!(arg3 >= v1.minimum_credits && arg3 <= v1.maximum_credits, 13906834706919456771);
        let v2 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::send_deposit(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), checked_multiply(v1.price_per_credit, arg3)), arg4);
        (new_credits(arg0, arg2, arg3, arg4), v2)
    }

    public fun buy_more(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        assert!(v1.issuance_enabled, 13906834827178934281);
        assert!(arg3 >= v1.minimum_credits && arg3 <= v1.maximum_credits, 13906834844358410243);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_cashier<Policy, State>(arg1) == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), 13906834852948213761);
        let v2 = Policy{dummy_field: false};
        let v3 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state_mut<Policy, State>(arg1, v2);
        assert!(v3.remaining <= 18446744073709551615 - arg3, 13906834870128869389);
        v3.remaining = v3.remaining + arg3;
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::send_deposit(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), checked_multiply(v1.price_per_credit, arg3)), arg4)
    }

    fun checked_multiply(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 == 0 || arg0 <= 18446744073709551615 / arg1, 13906835892331085837);
        arg0 * arg1
    }

    public fun close_issuance(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config_mut<Policy, Config>(arg0, arg1, v0);
        v1.issuance_enabled = false;
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), v1);
    }

    public fun collect(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: vector<0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>>) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = Policy{dummy_field: false};
        let (v1, v2) = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::collect_with_reserve<Policy, CreditReserve>(arg0, arg1, v0, arg2);
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<CreditReserve>(&v3)) {
            let CreditReserve {  } = 0x1::vector::pop_back<CreditReserve>(&mut v3);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<CreditReserve>(v3);
        v1
    }

    public fun derive_id(arg0: 0x2::object::ID, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind) : 0x2::object::ID {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::derive_policy_account_id<Policy>(arg0, arg1)
    }

    fun emit_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg3: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>) {
        let v0 = Policy{dummy_field: false};
        let v1 = CreditsCreatedEvent{
            tool        : arg0,
            cashier     : arg1,
            credits     : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_id<Policy, State>(arg3),
            beneficiary : arg2,
            remaining   : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state<Policy, State>(arg3, v0).remaining,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<CreditsCreatedEvent>(v1);
    }

    fun emit_offer(arg0: 0x2::object::ID, arg1: &Config) {
        let v0 = CreditOfferChangedEvent{
            cashier          : arg0,
            issuance_enabled : arg1.issuance_enabled,
            price_per_credit : arg1.price_per_credit,
            minimum_credits  : arg1.minimum_credits,
            maximum_credits  : arg1.maximum_credits,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<CreditOfferChangedEvent>(v0);
    }

    public fun enable(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: u64, arg3: u64, arg4: u64) {
        assert_valid_terms(arg2, arg3, arg4);
        let v0 = Config{
            issuance_enabled : true,
            price_per_credit : arg2,
            minimum_credits  : arg3,
            maximum_credits  : arg4,
        };
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), &v0);
        let v1 = Policy{dummy_field: false};
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::add_policy_with_config<Policy, Config>(arg0, arg1, v1, v0);
    }

    public fun get_invocation(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationRequest, arg3: &mut 0x2::tx_context::TxContext) : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation {
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_cashier<Policy, State>(arg1) == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0) && 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_beneficiary<Policy, State>(arg1) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::invocation_request_source(&arg2), 13906835333984550913);
        let v0 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_id<Policy, State>(arg1);
        let v1 = Policy{dummy_field: false};
        let v2 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state_mut<Policy, State>(arg1, v1);
        assert!(v2.remaining > 0, 13906835346870108171);
        v2.remaining = v2.remaining - 1;
        let v3 = Policy{dummy_field: false};
        let v4 = CreditReserve{dummy_field: false};
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v5, v0);
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::new_invocation_with_reserve<Policy, CreditReserve>(arg0, arg2, v3, v4, 0x2::object::id_to_address(&v0), v5, 0, arg3)
    }

    public fun issue(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State> {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::assert_owner(arg0, arg1);
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        assert!(v1.issuance_enabled, 13906835149301481481);
        assert!(arg3 >= v1.minimum_credits && arg3 <= v1.maximum_credits, 13906835162185990147);
        new_credits(arg0, arg2, arg3, arg4)
    }

    public fun issue_more(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg2: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg3: u64) {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::assert_owner(arg0, arg2);
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        assert!(v1.issuance_enabled, 13906835222315925513);
        assert!(arg3 >= v1.minimum_credits && arg3 <= v1.maximum_credits, 13906835239495401475);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_cashier<Policy, State>(arg1) == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), 13906835248085204993);
        let v2 = Policy{dummy_field: false};
        let v3 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state_mut<Policy, State>(arg1, v2);
        assert!(v3.remaining <= 18446744073709551615 - arg3, 13906835256675926029);
        v3.remaining = v3.remaining + arg3;
    }

    fun new_credits(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State> {
        let v0 = Policy{dummy_field: false};
        let v1 = State{remaining: arg2};
        let v2 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::new_policy_account<Policy, State>(arg0, arg1, v0, v1);
        emit_created(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool(arg0), 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), arg1, &v2);
        v2
    }

    public fun offer(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier) : (bool, u64, u64, u64) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config<Policy, Config>(arg0, v0);
        (v1.issuance_enabled, v1.price_per_credit, v1.minimum_credits, v1.maximum_credits)
    }

    public fun open_issuance(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config_mut<Policy, Config>(arg0, arg1, v0);
        v1.issuance_enabled = true;
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), v1);
    }

    public fun remaining(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>) : u64 {
        let v0 = Policy{dummy_field: false};
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state<Policy, State>(arg0, v0).remaining
    }

    public fun restore_refund(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg1: 0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>) {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::receive_refund(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_uid_mut<Policy, State>(arg0, v0), arg1);
        restore_refund_inner(arg0, v1);
    }

    fun restore_refund_inner(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>, arg1: 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation) {
        let v0 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_id<Policy, State>(arg0);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::refund_address(&arg1) == 0x2::object::id_to_address(&v0), 13906835471423504385);
        let v1 = Policy{dummy_field: false};
        let CreditReserve {  } = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::claim_refund<Policy, CreditReserve>(arg1, v1);
        let v2 = Policy{dummy_field: false};
        let v3 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_account_state_mut<Policy, State>(arg0, v2);
        assert!(v3.remaining < 18446744073709551615, 13906835484309192717);
        v3.remaining = v3.remaining + 1;
    }

    public fun share(arg0: 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::PolicyAccount<Policy, State>) {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::share_policy_account<Policy, State>(arg0);
    }

    public fun update_terms(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: u64, arg3: u64, arg4: u64) {
        assert_valid_terms(arg2, arg3, arg4);
        let v0 = Policy{dummy_field: false};
        let v1 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::policy_config_mut<Policy, Config>(arg0, arg1, v0);
        v1.price_per_credit = arg2;
        v1.minimum_credits = arg3;
        v1.maximum_credits = arg4;
        emit_offer(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::id(arg0), v1);
    }

    // decompiled from Move bytecode v7
}

