module 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::roles {
    struct ExchangeAdminUpdateEvent has copy, drop {
        account: address,
    }

    struct ExchangeGuardianUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct SettlementOperatorCreationEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct SettlementOperatorRemovalEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct DelevergingOperatorUpdate has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct FundingRateOperatorUpdate has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct SubAccountUpdateEvent has copy, drop {
        account: address,
        subAccount: address,
        status: bool,
    }

    struct ExchangeAdminCap has key {
        id: 0x2::object::UID,
    }

    struct ExchangeGuardianCap has key {
        id: 0x2::object::UID,
    }

    struct SettlementCap has key {
        id: 0x2::object::UID,
    }

    struct DeleveragingCap has key {
        id: 0x2::object::UID,
    }

    struct FundingRateCap has key {
        id: 0x2::object::UID,
    }

    struct CapabilitiesSafe has key {
        id: 0x2::object::UID,
        guardian: 0x2::object::ID,
        deleveraging: 0x2::object::ID,
        fundingRateOperator: 0x2::object::ID,
        publicSettlementCap: 0x2::object::ID,
        settlementOperators: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SubAccounts has key {
        id: 0x2::object::UID,
        map: 0x2::table::Table<address, 0x2::vec_set::VecSet<address>>,
    }

    public fun check_delevearging_operator_validity(arg0: &CapabilitiesSafe, arg1: &DeleveragingCap) {
        assert!(arg0.deleveraging == 0x2::object::uid_to_inner(&arg1.id), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::error::invalid_deleveraging_operator());
    }

    public fun check_funding_rate_operator_validity(arg0: &CapabilitiesSafe, arg1: &FundingRateCap) {
        assert!(arg0.fundingRateOperator == 0x2::object::uid_to_inner(&arg1.id), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::error::invalid_funding_rate_operator());
    }

    public fun check_guardian_validity(arg0: &CapabilitiesSafe, arg1: &ExchangeGuardianCap) {
        assert!(arg0.guardian == 0x2::object::uid_to_inner(&arg1.id), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::error::invalid_guardian());
    }

    public fun check_public_settlement_cap_validity(arg0: &CapabilitiesSafe, arg1: &SettlementCap) {
        assert!(arg0.publicSettlementCap == 0x2::object::uid_to_inner(&arg1.id), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::error::not_a_public_settlement_cap());
    }

    public fun check_settlement_operator_validity(arg0: &CapabilitiesSafe, arg1: &SettlementCap) {
        let v0 = 0x2::object::id<SettlementCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.settlementOperators, &v0), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::error::invalid_settlement_operator());
    }

    fun create_deleveraging_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = DeleveragingCap{id: v0};
        0x2::transfer::transfer<DeleveragingCap>(v2, arg0);
        let v3 = DelevergingOperatorUpdate{
            id      : v1,
            account : arg0,
        };
        0x2::event::emit<DelevergingOperatorUpdate>(v3);
        v1
    }

    fun create_exchange_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ExchangeAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ExchangeAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ExchangeAdminUpdateEvent{account: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<ExchangeAdminUpdateEvent>(v1);
    }

    fun create_exchange_guardian(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ExchangeGuardianCap{id: v0};
        0x2::transfer::transfer<ExchangeGuardianCap>(v2, arg0);
        let v3 = ExchangeGuardianUpdateEvent{
            id      : v1,
            account : arg0,
        };
        0x2::event::emit<ExchangeGuardianUpdateEvent>(v3);
        v1
    }

    fun create_funding_rate_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = FundingRateCap{id: v0};
        0x2::transfer::transfer<FundingRateCap>(v2, arg0);
        let v3 = FundingRateOperatorUpdate{
            id      : v1,
            account : arg0,
        };
        0x2::event::emit<FundingRateOperatorUpdate>(v3);
        v1
    }

    entry fun create_settlement_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SettlementCap{id: 0x2::object::new(arg3)};
        let v1 = SettlementOperatorCreationEvent{
            id      : 0x2::object::uid_to_inner(&v0.id),
            account : arg2,
        };
        0x2::event::emit<SettlementOperatorCreationEvent>(v1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.settlementOperators, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::transfer<SettlementCap>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_exchange_admin(arg0);
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = create_exchange_guardian(v0, arg0);
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = create_deleveraging_operator(v2, arg0);
        let v4 = 0x2::tx_context::sender(arg0);
        let v5 = create_funding_rate_operator(v4, arg0);
        let v6 = 0x2::object::new(arg0);
        let v7 = SettlementCap{id: v6};
        0x2::transfer::share_object<SettlementCap>(v7);
        let v8 = CapabilitiesSafe{
            id                  : 0x2::object::new(arg0),
            guardian            : v1,
            deleveraging        : v3,
            fundingRateOperator : v5,
            publicSettlementCap : 0x2::object::uid_to_inner(&v6),
            settlementOperators : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<CapabilitiesSafe>(v8);
        let v9 = SubAccounts{
            id  : 0x2::object::new(arg0),
            map : 0x2::table::new<address, 0x2::vec_set::VecSet<address>>(arg0),
        };
        0x2::transfer::share_object<SubAccounts>(v9);
    }

    public fun is_sub_account(arg0: &SubAccounts, arg1: address, arg2: address) : bool {
        let v0 = &arg0.map;
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v0, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(v0, arg1), &arg2)
    }

    entry fun remove_settlement_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafe, arg2: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.settlementOperators, &arg2), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::error::operator_already_removed());
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.settlementOperators, &arg2);
        let v0 = SettlementOperatorRemovalEvent{id: arg2};
        0x2::event::emit<SettlementOperatorRemovalEvent>(v0);
    }

    public entry fun set_deleveraging_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.deleveraging = create_deleveraging_operator(arg2, arg3);
    }

    entry fun set_exchange_admin(arg0: ExchangeAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::error::new_address_can_not_be_same_as_current_one());
        0x2::transfer::transfer<ExchangeAdminCap>(arg0, arg1);
        let v0 = ExchangeAdminUpdateEvent{account: arg1};
        0x2::event::emit<ExchangeAdminUpdateEvent>(v0);
    }

    entry fun set_exchange_guardian(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.guardian = create_exchange_guardian(arg2, arg3);
    }

    public entry fun set_funding_rate_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fundingRateOperator = create_funding_rate_operator(arg2, arg3);
    }

    entry fun set_sub_account(arg0: &mut SubAccounts, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = &mut arg0.map;
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v1, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<address>>(v1, v0, 0x2::vec_set::empty<address>());
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<address>>(v1, v0);
        if (arg2) {
            if (!0x2::vec_set::contains<address>(v2, &arg1)) {
                0x2::vec_set::insert<address>(v2, arg1);
            };
        } else if (0x2::vec_set::contains<address>(v2, &arg1)) {
            0x2::vec_set::remove<address>(v2, &arg1);
        };
        let v3 = SubAccountUpdateEvent{
            account    : v0,
            subAccount : arg1,
            status     : arg2,
        };
        0x2::event::emit<SubAccountUpdateEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

