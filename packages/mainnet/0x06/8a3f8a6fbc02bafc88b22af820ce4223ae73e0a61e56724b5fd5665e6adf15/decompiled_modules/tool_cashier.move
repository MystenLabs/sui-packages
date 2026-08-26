module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier {
    struct ToolCashier has key {
        id: 0x2::object::UID,
    }

    struct ToolCashierInnerV1 has store {
        tool: 0x2::object::ID,
        tool_fqn: 0x1::ascii::String,
        policies: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct OverToolCashier has drop {
        dummy_field: bool,
    }

    struct ToolCashierKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PolicyKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct PolicyAccountKey<phantom T0: drop> has copy, drop, store {
        pos0: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind,
    }

    struct PolicyAccount<phantom T0: drop, T1: store> has key {
        id: 0x2::object::UID,
        cashier: 0x2::object::ID,
        beneficiary: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind,
        state: T1,
    }

    struct CashierDeposit has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CashierDepositCreatedEvent has copy, drop {
        cashier: 0x2::object::ID,
        deposit: 0x2::object::ID,
        amount: u64,
    }

    struct PolicyAddedEvent has copy, drop {
        cashier: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
    }

    struct PolicyRemovedEvent has copy, drop {
        cashier: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
    }

    public fun id(arg0: &ToolCashier) : 0x2::object::ID {
        0x2::object::id<ToolCashier>(arg0)
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : (ToolCashier, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>) {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::assert_witness<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::era::V1>(arg0);
        let v0 = ToolCashierKey{dummy_field: false};
        let v1 = ToolCashier{id: 0x2::derived_object::claim<ToolCashierKey>(arg0, v0)};
        let v2 = ToolCashierInnerV1{
            tool     : 0x2::object::uid_to_inner(arg0),
            tool_fqn : arg1,
            policies : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::add<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::era::V1, ToolCashierInnerV1>(&mut v1.id, 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::era::v1(), v2);
        let v3 = OverToolCashier{dummy_field: false};
        (v1, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::new_cloneable_drop<OverToolCashier>(v3, arg0, arg2))
    }

    public fun add_policy<T0: drop>(arg0: &mut ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>, arg2: T0) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&load_v1(arg0).policies, &v0), 13906834736984358917);
        let v1 = load_v1_mut(arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v1.policies, v0);
        let v2 = PolicyAddedEvent{
            cashier : 0x2::object::id<ToolCashier>(arg0),
            policy  : v0,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<PolicyAddedEvent>(v2);
    }

    public fun add_policy_with_config<T0: drop, T1: store>(arg0: &mut ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>, arg2: T0, arg3: T1) {
        add_policy<T0>(arg0, arg1, arg2);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<PolicyKey<T0>, T1>(&mut arg0.id, v0, arg3);
    }

    public fun assert_owner(arg0: &ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>) {
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::is_for_id<OverToolCashier>(arg1, load_v1(arg0).tool), 13906835690466967555);
    }

    public fun collect_deposits(arg0: &mut ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>, arg2: vector<0x2::transfer::Receiving<CashierDeposit>>) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_owner(arg0, arg1);
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<CashierDeposit>>(&arg2)) {
            let CashierDeposit {
                id    : v2,
                funds : v3,
            } = 0x2::transfer::receive<CashierDeposit>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<CashierDeposit>>(&mut arg2));
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v3);
            0x2::object::delete(v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<CashierDeposit>>(arg2);
        v0
    }

    public fun derive_id(arg0: 0x2::object::ID) : 0x2::object::ID {
        let v0 = ToolCashierKey{dummy_field: false};
        0x2::object::id_from_address(0x2::derived_object::derive_address<ToolCashierKey>(arg0, v0))
    }

    public fun derive_policy_account_id<T0: drop>(arg0: 0x2::object::ID, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind) : 0x2::object::ID {
        let v0 = PolicyAccountKey<T0>{pos0: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<PolicyAccountKey<T0>>(arg0, v0))
    }

    public fun has_policy<T0: drop>(arg0: &ToolCashier) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&load_v1(arg0).policies, &v0)
    }

    fun load_v1(arg0: &ToolCashier) : &ToolCashierInnerV1 {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner<ToolCashierInnerV1>(&arg0.id)
    }

    fun load_v1_mut(arg0: &mut ToolCashier) : &mut ToolCashierInnerV1 {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner_mut<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::era::V1, ToolCashierInnerV1>(&mut arg0.id)
    }

    public(friend) fun new_admin(arg0: &0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier> {
        let v0 = OverToolCashier{dummy_field: false};
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::new_cloneable_drop<OverToolCashier>(v0, arg0, arg1)
    }

    public fun new_policy_account<T0: drop, T1: store>(arg0: &mut ToolCashier, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind, arg2: T0, arg3: T1) : PolicyAccount<T0, T1> {
        assert!(has_policy<T0>(arg0), 13906835119236579335);
        let v0 = PolicyAccountKey<T0>{pos0: arg1};
        PolicyAccount<T0, T1>{
            id          : 0x2::derived_object::claim<PolicyAccountKey<T0>>(&mut arg0.id, v0),
            cashier     : 0x2::object::id<ToolCashier>(arg0),
            beneficiary : arg1,
            state       : arg3,
        }
    }

    public fun policies(arg0: &ToolCashier) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &load_v1(arg0).policies
    }

    public fun policy_account_beneficiary<T0: drop, T1: store>(arg0: &PolicyAccount<T0, T1>) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind {
        arg0.beneficiary
    }

    public fun policy_account_cashier<T0: drop, T1: store>(arg0: &PolicyAccount<T0, T1>) : 0x2::object::ID {
        arg0.cashier
    }

    public fun policy_account_id<T0: drop, T1: store>(arg0: &PolicyAccount<T0, T1>) : 0x2::object::ID {
        0x2::object::id<PolicyAccount<T0, T1>>(arg0)
    }

    public fun policy_account_state<T0: drop, T1: store>(arg0: &PolicyAccount<T0, T1>, arg1: T0) : &T1 {
        &arg0.state
    }

    public fun policy_account_state_mut<T0: drop, T1: store>(arg0: &mut PolicyAccount<T0, T1>, arg1: T0) : &mut T1 {
        &mut arg0.state
    }

    public fun policy_account_uid_mut<T0: drop, T1: store>(arg0: &mut PolicyAccount<T0, T1>, arg1: T0) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun policy_config<T0: drop, T1: store>(arg0: &ToolCashier, arg1: T0) : &T1 {
        assert!(has_policy<T0>(arg0), 13906834951732854791);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<PolicyKey<T0>, T1>(&arg0.id, v0)
    }

    public fun policy_config_mut<T0: drop, T1: store>(arg0: &mut ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>, arg2: T0) : &mut T1 {
        assert_owner(arg0, arg1);
        assert!(has_policy<T0>(arg0), 13906834998977495047);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PolicyKey<T0>, T1>(&mut arg0.id, v0)
    }

    public fun remove_policy<T0: drop>(arg0: &mut ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>, arg2: T0) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&load_v1(arg0).policies, &v0), 13906834865833508871);
        let v1 = load_v1_mut(arg0);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v1.policies, &v0);
        let v2 = PolicyRemovedEvent{
            cashier : 0x2::object::id<ToolCashier>(arg0),
            policy  : v0,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<PolicyRemovedEvent>(v2);
    }

    public fun remove_policy_with_config<T0: drop, T1: store>(arg0: &mut ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverToolCashier>, arg2: T0) : T1 {
        remove_policy<T0>(arg0, arg1, arg2);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<PolicyKey<T0>, T1>(&mut arg0.id, v0)
    }

    public fun send_deposit(arg0: &ToolCashier, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 13906835428473831425);
        let v1 = 0x2::object::id<ToolCashier>(arg0);
        let v2 = CashierDeposit{
            id    : 0x2::object::new(arg2),
            funds : arg1,
        };
        let v3 = 0x2::object::id<CashierDeposit>(&v2);
        let v4 = CashierDepositCreatedEvent{
            cashier : v1,
            deposit : v3,
            amount  : v0,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<CashierDepositCreatedEvent>(v4);
        0x2::transfer::transfer<CashierDeposit>(v2, 0x2::object::id_to_address(&v1));
        v3
    }

    public(friend) fun share(arg0: ToolCashier) {
        0x2::transfer::share_object<ToolCashier>(arg0);
    }

    public fun share_policy_account<T0: drop, T1: store>(arg0: PolicyAccount<T0, T1>) {
        0x2::transfer::share_object<PolicyAccount<T0, T1>>(arg0);
    }

    public fun tool(arg0: &ToolCashier) : 0x2::object::ID {
        load_v1(arg0).tool
    }

    public fun tool_fqn(arg0: &ToolCashier) : 0x1::ascii::String {
        load_v1(arg0).tool_fqn
    }

    public(friend) fun uid_mut(arg0: &mut ToolCashier) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

