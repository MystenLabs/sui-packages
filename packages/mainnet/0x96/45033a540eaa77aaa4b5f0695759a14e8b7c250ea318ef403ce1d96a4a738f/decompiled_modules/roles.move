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

    struct DelevergingOperatorUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct FundingRateOperatorUpdateEvent has copy, drop {
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

    entry fun set_maker_gas_fee(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        check_manager_validity(arg1, arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_maker_gas_fee(arg1, arg2 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    entry fun set_taker_gas_fee(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        check_manager_validity(arg1, arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_taker_gas_fee(arg1, arg2 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    entry fun upgrade(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::upgrade(arg1);
    }

    entry fun add_privileged_addresses(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: vector<address>) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        check_manager_validity(arg1, arg0);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_accounts_length());
        let v1 = 0;
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses_mut(arg1);
        while (v1 < v0) {
            0x2::vec_set::insert<address>(v2, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    public(friend) fun check_deleveraging_operator_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &DeleveragingCap) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::deleveraging_cap_id(arg0) == 0x2::object::uid_to_inner(&arg1.id), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_deleveraging_operator());
    }

    public(friend) fun check_funding_rate_operator_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &FundingRateCap) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::funding_rate_cap_id(arg0) == 0x2::object::uid_to_inner(&arg1.id), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_funding_rate_operator());
    }

    public(friend) fun check_manager_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &ExchangeManagerCap) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::manager_cap_id(arg0) == 0x2::object::uid_to_inner(&arg1.id), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_manager());
    }

    public(friend) fun check_settlement_operator_validity(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &SettlementCap) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::vec_set::contains<0x2::object::ID>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::settlement_cap_ids(arg0), &v0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_settlement_operator());
    }

    fun create_deleveraging_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = DeleveragingCap{id: v0};
        0x2::transfer::transfer<DeleveragingCap>(v2, arg0);
        let v3 = DelevergingOperatorUpdateEvent{
            id      : v1,
            account : arg0,
        };
        0x2::event::emit<DelevergingOperatorUpdateEvent>(v3);
        v1
    }

    fun create_exchange_admin_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ExchangeAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ExchangeAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ExchangeAdminUpdateEvent{account: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<ExchangeAdminUpdateEvent>(v1);
    }

    fun create_exchange_manager_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ExchangeManagerCap{id: v0};
        0x2::transfer::transfer<ExchangeManagerCap>(v2, arg0);
        let v3 = ExchangeManagerUpdateEvent{
            id      : v1,
            account : arg0,
        };
        0x2::event::emit<ExchangeManagerUpdateEvent>(v3);
        v1
    }

    fun create_funding_rate_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = FundingRateCap{id: v0};
        0x2::transfer::transfer<FundingRateCap>(v2, arg0);
        let v3 = FundingRateOperatorUpdateEvent{
            id      : v1,
            account : arg0,
        };
        0x2::event::emit<FundingRateOperatorUpdateEvent>(v3);
        v1
    }

    entry fun create_settlement_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert!(arg2 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        let v0 = SettlementCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::add_settlement_cap_id(arg1, v1);
        0x2::transfer::transfer<SettlementCap>(v0, arg2);
        let v2 = SettlementOperatorCreationEvent{
            id      : v1,
            account : arg2,
        };
        0x2::event::emit<SettlementOperatorCreationEvent>(v2);
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        create_exchange_admin_cap(arg0);
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = create_exchange_manager_cap(v0, arg0);
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = create_deleveraging_cap(v2, arg0);
        let v4 = 0x2::tx_context::sender(arg0);
        (v1, v3, create_funding_rate_cap(v4, arg0))
    }

    entry fun pause(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_version(arg1);
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::is_paused(arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::exchange_already_paused());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_is_paused(arg1, true);
        let v0 = ExchangeAdminPauseEvent{admin: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<ExchangeAdminPauseEvent>(v0);
    }

    entry fun remove_privileged_addresses(arg0: &ExchangeManagerCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: vector<address>) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        check_manager_validity(arg1, arg0);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_accounts_length());
        let v1 = 0;
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses_mut(arg1);
        while (v1 < v0) {
            0x2::vec_set::remove<address>(v2, 0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    public fun remove_settlement_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: 0x2::object::ID) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::settlement_cap_ids(arg1), &arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::operator_already_removed());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::remove_settlement_cap_id(arg1, arg2);
        let v0 = SettlementOperatorRemovalEvent{id: arg2};
        0x2::event::emit<SettlementOperatorRemovalEvent>(v0);
    }

    entry fun resume(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_version(arg1);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::is_paused(arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::exchange_already_resumed());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_is_paused(arg1, false);
        let v0 = ExchangeAdminResumeEvent{admin: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<ExchangeAdminResumeEvent>(v0);
    }

    entry fun set_deleveraging_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert!(arg2 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_deleveraging_cap_id(arg1, create_deleveraging_cap(arg2, arg3));
    }

    entry fun set_exchange_admin(arg0: ExchangeAdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        assert!(arg1 != 0x2::tx_context::sender(arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::new_address_can_not_be_same_as_current_one());
        0x2::transfer::transfer<ExchangeAdminCap>(arg0, arg1);
        let v0 = ExchangeAdminUpdateEvent{account: arg1};
        0x2::event::emit<ExchangeAdminUpdateEvent>(v0);
    }

    entry fun set_exchange_manager(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert!(arg2 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_manager_cap_id(arg1, create_exchange_manager_cap(arg2, arg3));
    }

    entry fun set_funding_rate_operator(arg0: &ExchangeAdminCap, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert!(arg2 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::set_funding_rate_cap_id(arg1, create_funding_rate_cap(arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

