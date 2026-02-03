module 0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::dca_config {
    struct DCA_CONFIG has drop {
        dummy_field: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct DCAConfig has store, key {
        id: 0x2::object::UID,
        oracle_valid_duration: u64,
        min_cycle_frequency: u64,
        min_cycle_count: u64,
        keeper_threshold: u64,
        whitelist_mode: u8,
        in_coin_whitelist: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        out_coin_whitelist: 0x2::table::Table<0x1::type_name::TypeName, bool>,
    }

    struct ProtocolFeeVault has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
    }

    struct SetMinCycleFrequencyEvent has copy, drop {
        new_min_cycle_frequency: u64,
        old_min_cycle_frequency: u64,
    }

    struct SetMinCycleCountEvent has copy, drop {
        new_min_cycle_count: u64,
        old_min_cycle_count: u64,
    }

    struct SetOracleValidDurationEvent has copy, drop {
        new_oracle_valid_duration: u64,
        old_oracle_valid_duration: u64,
    }

    struct SetKeeperThresholdEvent has copy, drop {
        new_keeper_threshold: u64,
        old_keeper_threshold: u64,
    }

    struct SetWhitelistModeEvent has copy, drop {
        new_whitelist_mode: u8,
        old_whitelist_mode: u8,
    }

    struct AddInCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct RemoveInCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct AddOutCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct RemoveOutCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct MintOperatorCapEvent has copy, drop {
        operator_cap_id: 0x2::object::ID,
        to: address,
    }

    struct ClaimProtocolFeeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun add_in_coin_type<T0>(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg1.in_coin_whitelist, v0, true);
        let v1 = AddInCoinTypeEvent{coin_type: v0};
        0x2::event::emit<AddInCoinTypeEvent>(v1);
    }

    public fun add_out_coin_type<T0>(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg1.out_coin_whitelist, v0, true);
        let v1 = AddOutCoinTypeEvent{coin_type: v0};
        0x2::event::emit<AddOutCoinTypeEvent>(v1);
    }

    public fun checked_keeper(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: address) {
        assert!(0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::has_role(arg0, arg1, 2), 1);
    }

    fun checked_operator(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: address) {
        assert!(0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::has_role(arg0, arg1, 3), 2);
    }

    public fun checked_oracle(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: address) {
        assert!(0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::has_role(arg0, arg1, 4), 3);
    }

    public fun claim_fee<T0>(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut ProtocolFeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(claim_fee_internal<T0>(arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    fun claim_fee_internal<T0>(arg0: &mut ProtocolFeeVault) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0), 4);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = ClaimProtocolFeeEvent{
            coin_type : v0,
            amount    : v2,
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v3);
        0x2::balance::split<T0>(v1, v2)
    }

    public fun claim_fee_with_cap<T0>(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut ProtocolFeeVault, arg2: &OperatorCap) : 0x2::balance::Balance<T0> {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        assert!(0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::has_role(arg0, 0x2::object::id_address<OperatorCap>(arg2), 5), 5);
        claim_fee_internal<T0>(arg1)
    }

    fun init(arg0: DCA_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DCAConfig{
            id                    : 0x2::object::new(arg1),
            oracle_valid_duration : 300,
            min_cycle_frequency   : 60,
            min_cycle_count       : 2,
            keeper_threshold      : 1,
            whitelist_mode        : 0,
            in_coin_whitelist     : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            out_coin_whitelist    : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
        };
        let v1 = ProtocolFeeVault{
            id    : 0x2::object::new(arg1),
            vault : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<DCAConfig>(v0);
        0x2::transfer::share_object<ProtocolFeeVault>(v1);
    }

    public fun is_coin_allow<T0, T1>(arg0: &DCAConfig) : bool {
        if (arg0.whitelist_mode == 0) {
            return true
        };
        let v0 = arg0.whitelist_mode & 1 == 0 || 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.in_coin_whitelist, 0x1::type_name::get<T0>());
        let v1 = arg0.whitelist_mode & 2 == 0 || 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.out_coin_whitelist, 0x1::type_name::get<T1>());
        v0 && v1
    }

    public fun keeper_threshold(arg0: &DCAConfig) : u64 {
        arg0.keeper_threshold
    }

    public fun min_cycle_count(arg0: &DCAConfig) : u64 {
        arg0.min_cycle_count
    }

    public fun min_cycle_frequency(arg0: &DCAConfig) : u64 {
        arg0.min_cycle_frequency
    }

    public fun mint_operator_cap(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        let v1 = MintOperatorCapEvent{
            operator_cap_id : 0x2::object::id<OperatorCap>(&v0),
            to              : arg1,
        };
        0x2::event::emit<MintOperatorCapEvent>(v1);
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    public fun oracle_valid_duration(arg0: &DCAConfig) : u64 {
        arg0.oracle_valid_duration
    }

    public fun receive_fee<T0>(arg0: &mut ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, arg1);
        };
    }

    public fun remove_in_coin_type<T0>(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg1.in_coin_whitelist, v0);
        let v1 = RemoveInCoinTypeEvent{coin_type: v0};
        0x2::event::emit<RemoveInCoinTypeEvent>(v1);
    }

    public fun remove_out_coin_type<T0>(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg1.out_coin_whitelist, v0);
        let v1 = RemoveOutCoinTypeEvent{coin_type: v0};
        0x2::event::emit<RemoveOutCoinTypeEvent>(v1);
    }

    public fun set_keeper_threshold(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg3));
        arg1.keeper_threshold = arg2;
        let v0 = SetKeeperThresholdEvent{
            new_keeper_threshold : arg2,
            old_keeper_threshold : arg1.keeper_threshold,
        };
        0x2::event::emit<SetKeeperThresholdEvent>(v0);
    }

    public fun set_min_cycle_count(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg3));
        arg1.min_cycle_count = arg2;
        let v0 = SetMinCycleCountEvent{
            new_min_cycle_count : arg2,
            old_min_cycle_count : arg1.min_cycle_count,
        };
        0x2::event::emit<SetMinCycleCountEvent>(v0);
    }

    public fun set_min_cycle_frequency(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg3));
        arg1.min_cycle_frequency = arg2;
        let v0 = SetMinCycleFrequencyEvent{
            new_min_cycle_frequency : arg2,
            old_min_cycle_frequency : arg1.min_cycle_frequency,
        };
        0x2::event::emit<SetMinCycleFrequencyEvent>(v0);
    }

    public fun set_oracle_valid_duration(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg3));
        arg1.oracle_valid_duration = arg2;
        let v0 = SetOracleValidDurationEvent{
            new_oracle_valid_duration : arg2,
            old_oracle_valid_duration : arg1.oracle_valid_duration,
        };
        0x2::event::emit<SetOracleValidDurationEvent>(v0);
    }

    public fun set_whitelist_mode(arg0: &0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::BaseConfig, arg1: &mut DCAConfig, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0xc4490f9701709caa8f25e69aee0901c776d0307123d229b0de81aba7ebb18fba::base_config::checked_package_version(arg0);
        checked_operator(arg0, 0x2::tx_context::sender(arg3));
        arg1.whitelist_mode = arg2;
        let v0 = SetWhitelistModeEvent{
            new_whitelist_mode : arg2,
            old_whitelist_mode : arg1.whitelist_mode,
        };
        0x2::event::emit<SetWhitelistModeEvent>(v0);
    }

    public fun whitelist_mode(arg0: &DCAConfig) : u8 {
        arg0.whitelist_mode
    }

    // decompiled from Move bytecode v6
}

