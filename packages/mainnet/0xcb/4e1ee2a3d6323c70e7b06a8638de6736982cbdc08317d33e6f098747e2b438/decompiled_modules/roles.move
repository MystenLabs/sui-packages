module 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles {
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

    struct SequencerCreationEvent has copy, drop {
        id: 0x2::object::ID,
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

    struct CapabilitiesSafeV2 has key {
        id: 0x2::object::UID,
        version: u64,
        guardian: 0x2::object::ID,
        deleveraging: 0x2::object::ID,
        fundingRateOperator: 0x2::object::ID,
        publicSettlementCap: 0x2::object::ID,
        settlementOperators: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SubAccountsV2 has key {
        id: 0x2::object::UID,
        version: u64,
        map: 0x2::table::Table<address, 0x2::vec_set::VecSet<address>>,
    }

    struct Sequencer has key {
        id: 0x2::object::UID,
        version: u64,
        counter: u128,
        map: 0x2::table::Table<vector<u8>, bool>,
    }

    public fun check_delevearging_operator_validity(arg0: &CapabilitiesSafe, arg1: &DeleveragingCap) {
        assert!(arg0.deleveraging == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_deleveraging_operator());
    }

    public fun check_delevearging_operator_validity_v2(arg0: &CapabilitiesSafeV2, arg1: &DeleveragingCap) {
        assert!(arg0.deleveraging == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_deleveraging_operator());
    }

    public fun check_funding_rate_operator_validity(arg0: &CapabilitiesSafe, arg1: &FundingRateCap) {
        assert!(arg0.fundingRateOperator == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_funding_rate_operator());
    }

    public fun check_funding_rate_operator_validity_v2(arg0: &CapabilitiesSafeV2, arg1: &FundingRateCap) {
        assert!(arg0.fundingRateOperator == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_funding_rate_operator());
    }

    public fun check_guardian_validity(arg0: &CapabilitiesSafe, arg1: &ExchangeGuardianCap) {
        assert!(arg0.guardian == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_guardian());
    }

    public fun check_guardian_validity_v2(arg0: &CapabilitiesSafeV2, arg1: &ExchangeGuardianCap) {
        assert!(arg0.guardian == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_guardian());
    }

    public fun check_public_settlement_cap_validity(arg0: &CapabilitiesSafe, arg1: &SettlementCap) {
        assert!(arg0.publicSettlementCap == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::not_a_public_settlement_cap());
    }

    public fun check_public_settlement_cap_validity_v2(arg0: &CapabilitiesSafeV2, arg1: &SettlementCap) {
        assert!(arg0.publicSettlementCap == 0x2::object::uid_to_inner(&arg1.id), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::not_a_public_settlement_cap());
    }

    public fun check_settlement_operator_validity(arg0: &CapabilitiesSafe, arg1: &SettlementCap) {
        let v0 = 0x2::object::id<SettlementCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.settlementOperators, &v0), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_settlement_operator());
    }

    public fun check_settlement_operator_validity_v2(arg0: &CapabilitiesSafeV2, arg1: &SettlementCap) {
        let v0 = 0x2::object::id<SettlementCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.settlementOperators, &v0), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_settlement_operator());
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

    entry fun create_sequencer(arg0: &ExchangeAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Sequencer{
            id      : 0x2::object::new(arg1),
            version : get_version(),
            counter : 0,
            map     : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        let v1 = SequencerCreationEvent{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<SequencerCreationEvent>(v1);
        0x2::transfer::share_object<Sequencer>(v0);
    }

    entry fun create_settlement_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafeV2, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validate_safe_version(arg1);
        let v0 = SettlementCap{id: 0x2::object::new(arg3)};
        let v1 = SettlementOperatorCreationEvent{
            id      : 0x2::object::uid_to_inner(&v0.id),
            account : arg2,
        };
        0x2::event::emit<SettlementOperatorCreationEvent>(v1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.settlementOperators, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::transfer<SettlementCap>(v0, arg2);
    }

    public fun get_version() : u64 {
        3
    }

    entry fun increment_counter(arg0: &ExchangeAdminCap, arg1: &mut SubAccountsV2) {
        arg1.version = arg1.version + 1;
    }

    entry fun increment_safe_version(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafeV2) {
        arg1.version = arg1.version + 1;
    }

    entry fun increment_sequencer_version(arg0: &ExchangeAdminCap, arg1: &mut Sequencer) {
        arg1.version = arg1.version + 1;
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
        let v8 = CapabilitiesSafeV2{
            id                  : 0x2::object::new(arg0),
            version             : get_version(),
            guardian            : v1,
            deleveraging        : v3,
            fundingRateOperator : v5,
            publicSettlementCap : 0x2::object::uid_to_inner(&v6),
            settlementOperators : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<CapabilitiesSafeV2>(v8);
        let v9 = SubAccountsV2{
            id      : 0x2::object::new(arg0),
            version : get_version(),
            map     : 0x2::table::new<address, 0x2::vec_set::VecSet<address>>(arg0),
        };
        0x2::transfer::share_object<SubAccountsV2>(v9);
        let v10 = Sequencer{
            id      : 0x2::object::new(arg0),
            version : get_version(),
            counter : 0,
            map     : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<Sequencer>(v10);
    }

    public fun is_sub_account(arg0: &SubAccounts, arg1: address, arg2: address) : bool {
        let v0 = &arg0.map;
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v0, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(v0, arg1), &arg2)
    }

    public fun is_sub_account_v2(arg0: &SubAccountsV2, arg1: address, arg2: address) : bool {
        let v0 = &arg0.map;
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v0, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(v0, arg1), &arg2)
    }

    entry fun migrate_safe(arg0: &ExchangeAdminCap, arg1: &CapabilitiesSafe, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CapabilitiesSafeV2{
            id                  : 0x2::object::new(arg2),
            version             : get_version(),
            guardian            : arg1.guardian,
            deleveraging        : arg1.deleveraging,
            fundingRateOperator : arg1.fundingRateOperator,
            publicSettlementCap : arg1.publicSettlementCap,
            settlementOperators : arg1.settlementOperators,
        };
        0x2::transfer::share_object<CapabilitiesSafeV2>(v0);
    }

    entry fun migrate_sub_accounts(arg0: &ExchangeAdminCap, arg1: &SubAccounts, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg1.map;
        let v1 = SubAccountsV2{
            id      : 0x2::object::new(arg3),
            version : get_version(),
            map     : 0x2::table::new<address, 0x2::vec_set::VecSet<address>>(arg3),
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            0x2::table::add<address, 0x2::vec_set::VecSet<address>>(&mut v1.map, v3, *0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(v0, v3));
            v2 = v2 + 1;
        };
        0x2::transfer::share_object<SubAccountsV2>(v1);
    }

    entry fun remove_settlement_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafeV2, arg2: 0x2::object::ID) {
        validate_safe_version(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.settlementOperators, &arg2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::operator_already_removed());
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.settlementOperators, &arg2);
        let v0 = SettlementOperatorRemovalEvent{id: arg2};
        0x2::event::emit<SettlementOperatorRemovalEvent>(v0);
    }

    public entry fun set_deleveraging_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun set_deleveraging_operator_v2(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafeV2, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validate_safe_version(arg1);
        arg1.deleveraging = create_deleveraging_operator(arg2, arg3);
    }

    entry fun set_exchange_admin(arg0: ExchangeAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::new_address_can_not_be_same_as_current_one());
        0x2::transfer::transfer<ExchangeAdminCap>(arg0, arg1);
        let v0 = ExchangeAdminUpdateEvent{account: arg1};
        0x2::event::emit<ExchangeAdminUpdateEvent>(v0);
    }

    entry fun set_exchange_guardian(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafeV2, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validate_safe_version(arg1);
        arg1.guardian = create_exchange_guardian(arg2, arg3);
    }

    public entry fun set_funding_rate_operator(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafe, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun set_funding_rate_operator_v2(arg0: &ExchangeAdminCap, arg1: &mut CapabilitiesSafeV2, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validate_safe_version(arg1);
        arg1.fundingRateOperator = create_funding_rate_operator(arg2, arg3);
    }

    entry fun set_sub_account(arg0: &mut SubAccountsV2, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validate_sub_accounts_version(arg0);
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

    public fun validate_safe_version(arg0: &CapabilitiesSafeV2) {
        assert!(arg0.version == get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
    }

    public fun validate_sequencer_version(arg0: &Sequencer) {
        assert!(arg0.version == get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
    }

    public fun validate_sub_accounts_version(arg0: &SubAccountsV2) {
        assert!(arg0.version == get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
    }

    public fun validate_unique_tx(arg0: &mut Sequencer, arg1: vector<u8>) : u128 {
        validate_sequencer_version(arg0);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.map, arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::transaction_replay());
        0x2::table::add<vector<u8>, bool>(&mut arg0.map, arg1, true);
        arg0.counter = arg0.counter + 1;
        arg0.counter
    }

    // decompiled from Move bytecode v6
}

