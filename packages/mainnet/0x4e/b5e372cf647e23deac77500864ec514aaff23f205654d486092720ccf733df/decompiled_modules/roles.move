module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles {
    struct ExchangeAdminUpdateEvent has copy, drop {
        account: address,
    }

    struct ExchangeAdminPauseEvent has copy, drop {
        admin: address,
    }

    struct ExchangeAdminResumeEvent has copy, drop {
        admin: address,
    }

    struct ExchangeManagerUpdateEvent has copy, drop {
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

    struct SettlementOperatorAddressAddedEvent has copy, drop {
        account: address,
    }

    struct SettlementOperatorAddressRemovedEvent has copy, drop {
        account: address,
    }

    struct DelevergingOperatorUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct FundingRateOperatorUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct InsuranceOperatorUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct ExchangeAdminCap has key {
        id: 0x2::object::UID,
    }

    struct ExchangeManagerCap has key {
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

    struct InsuranceOperatorCap has key {
        id: 0x2::object::UID,
    }

    entry fun add_settlement_operator_address(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert_nonzero_address(arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::add_settlement_operator_address(arg1, arg2);
        let v0 = SettlementOperatorAddressAddedEvent{account: arg2};
        0x2::event::emit<SettlementOperatorAddressAddedEvent>(v0);
    }

    entry fun remove_settlement_operator_address(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address) {
        assert_manager(arg1, arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::remove_settlement_operator_address(arg1, arg2);
        let v0 = SettlementOperatorAddressRemovedEvent{account: arg2};
        0x2::event::emit<SettlementOperatorAddressRemovedEvent>(v0);
    }

    entry fun set_action_gas_fee(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: 0x1::string::String, arg3: u128) {
        assert_manager(arg1, arg0);
        let v0 = arg3 / 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_uint();
        assert!(v0 <= 500000000, 3001);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_action_gas_fee(arg1, arg2, v0);
    }

    public(friend) fun set_gas_relayer(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address) {
        assert_manager(arg1, arg0);
        assert_nonzero_address(arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_gas_relayer(arg1, arg2);
    }

    entry fun set_maker_gas_fee(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: u128) {
        assert_manager(arg1, arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_maker_gas_fee(arg1, arg2 / 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_uint());
    }

    entry fun set_taker_gas_fee(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: u128) {
        assert_manager(arg1, arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_taker_gas_fee(arg1, arg2 / 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_uint());
    }

    entry fun set_trial_fund_operator(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address) {
        assert_manager(arg1, arg0);
        assert_nonzero_address(arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_trial_fund_operator(arg1, arg2);
    }

    entry fun upgrade(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::upgrade(arg1);
    }

    entry fun add_privileged_addresses(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: vector<address>) {
        mutate_privileged_addresses(arg0, arg1, arg2, true);
    }

    fun assert_cap_id<T0: key>(arg0: 0x2::object::ID, arg1: &T0, arg2: u64) {
        assert!(arg0 == 0x2::object::id<T0>(arg1), arg2);
    }

    fun assert_manager(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &ExchangeManagerCap) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        check_manager_validity(arg0, arg1);
    }

    fun assert_nonzero_address(arg0: address) {
        assert!(arg0 != @0x0, 105);
    }

    public(friend) fun check_deleveraging_operator_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &DeleveragingCap) {
        assert_cap_id<DeleveragingCap>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::deleveraging_cap_id(arg0), arg1, 113);
    }

    public(friend) fun check_funding_rate_operator_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &FundingRateCap) {
        assert_cap_id<FundingRateCap>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::funding_rate_cap_id(arg0), arg1, 101);
    }

    public(friend) fun check_insurance_operator_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &InsuranceOperatorCap) {
        assert_cap_id<InsuranceOperatorCap>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::insurance_operator_cap_id(arg0), arg1, 119);
    }

    public fun check_manager_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &ExchangeManagerCap) {
        assert_cap_id<ExchangeManagerCap>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::manager_cap_id(arg0), arg1, 111);
    }

    public(friend) fun check_settlement_sender_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: address) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::settlement_operator_address_exists(arg0, arg1), 110);
    }

    public(friend) fun check_trial_fund_operator_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: address) {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::trial_fund_operator(arg0);
        assert!(v0 != @0x0 && v0 == arg1, 120);
    }

    fun mutate_privileged_addresses(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: vector<address>, arg3: bool) {
        assert_manager(arg1, arg0);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 109);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses_mut(arg1);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            if (arg3) {
                0x2::vec_set::insert<address>(v1, v3);
            } else {
                0x2::vec_set::remove<address>(v1, &v3);
            };
            v2 = v2 + 1;
        };
    }

    entry fun pause(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_version(arg1);
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::is_paused(arg1), 100000);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_is_paused(arg1, true);
        let v0 = ExchangeAdminPauseEvent{admin: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<ExchangeAdminPauseEvent>(v0);
    }

    entry fun remove_privileged_addresses(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: vector<address>) {
        mutate_privileged_addresses(arg0, arg1, arg2, false);
    }

    public fun remove_settlement_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: 0x2::object::ID) {
        abort 999
    }

    entry fun resume(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_version(arg1);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::is_paused(arg1), 100001);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_is_paused(arg1, false);
        let v0 = ExchangeAdminResumeEvent{admin: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<ExchangeAdminResumeEvent>(v0);
    }

    entry fun set_deleveraging_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert_nonzero_address(arg2);
        let v0 = DeleveragingCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<DeleveragingCap>(&v0);
        0x2::transfer::transfer<DeleveragingCap>(v0, arg2);
        let v2 = DelevergingOperatorUpdateEvent{
            id      : v1,
            account : arg2,
        };
        0x2::event::emit<DelevergingOperatorUpdateEvent>(v2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_deleveraging_cap_id(arg1, v1);
    }

    entry fun set_exchange_admin(arg0: ExchangeAdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_nonzero_address(arg1);
        assert!(arg1 != 0x2::tx_context::sender(arg2), 900);
        0x2::transfer::transfer<ExchangeAdminCap>(arg0, arg1);
        let v0 = ExchangeAdminUpdateEvent{account: arg1};
        0x2::event::emit<ExchangeAdminUpdateEvent>(v0);
    }

    entry fun set_exchange_manager(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert_nonzero_address(arg2);
        let v0 = ExchangeManagerCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<ExchangeManagerCap>(&v0);
        0x2::transfer::transfer<ExchangeManagerCap>(v0, arg2);
        let v2 = ExchangeManagerUpdateEvent{
            id      : v1,
            account : arg2,
        };
        0x2::event::emit<ExchangeManagerUpdateEvent>(v2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_manager_cap_id(arg1, v1);
    }

    entry fun set_funding_rate_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert_nonzero_address(arg2);
        let v0 = FundingRateCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<FundingRateCap>(&v0);
        0x2::transfer::transfer<FundingRateCap>(v0, arg2);
        let v2 = FundingRateOperatorUpdateEvent{
            id      : v1,
            account : arg2,
        };
        0x2::event::emit<FundingRateOperatorUpdateEvent>(v2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_funding_rate_cap_id(arg1, v1);
    }

    entry fun set_insurance_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert_nonzero_address(arg2);
        let v0 = InsuranceOperatorCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<InsuranceOperatorCap>(&v0);
        0x2::transfer::transfer<InsuranceOperatorCap>(v0, arg2);
        let v2 = InsuranceOperatorUpdateEvent{
            id      : v1,
            account : arg2,
        };
        0x2::event::emit<InsuranceOperatorUpdateEvent>(v2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_insurance_operator_cap_id(arg1, v1);
    }

    entry fun set_price_feeder(arg0: &ExchangeManagerCap, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg3: address) {
        assert_manager(arg1, arg0);
        assert_nonzero_address(arg3);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::set_feeder(arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

