module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse {
    struct SweetHouseType has copy, drop, store {
        dummy_field: bool,
    }

    struct SweetHouse has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct HouseKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct DollarTypesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DollarTypes has store, key {
        id: 0x2::object::UID,
        type_names: vector<0x1::type_name::TypeName>,
    }

    struct OperatorKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct OperatorConfig has store, key {
        id: 0x2::object::UID,
        enabled: bool,
    }

    struct OperatorStakeConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        daily_loss_limit: u64,
        current_epoch_loss_count: u64,
        current_epoch_loss_credit_total: u128,
        current_epoch_loss_debit_total: u128,
        last_epoch_reset: u64,
        max_house_stake_per_bet: u64,
        fixed_private_pool_participation: u64,
    }

    struct PipeKey<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        pond_id: 0x2::object::ID,
    }

    struct RedeemRequestKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct RedeemRequest<phantom T0> has store, key {
        id: 0x2::object::UID,
        staked_balance: 0x2::balance::Balance<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::StakedCoin<T0>>,
        created_at: u64,
        sender: address,
    }

    struct HouseTakeDepositFeeEvent has copy, drop {
        deposit_fee_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        staker: address,
    }

    struct PrivatePoolWithdrawEvent has copy, drop {
        withdrawer: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        restricted: bool,
        withdraw_all: bool,
    }

    struct WhitelistPoolWithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        withdrawer: address,
        pool_owner: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        withdraw_all: bool,
    }

    struct RedeemRequestCreatedEvent has copy, drop {
        request_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        staked_amount: u64,
        created_at_ms: u64,
    }

    struct RedeemRequestFulfilledEvent has copy, drop {
        request_id: 0x2::object::ID,
        player: address,
        actor: address,
        coin_type: 0x1::type_name::TypeName,
        staked_amount: u64,
        payout_amount: u64,
        created_at_ms: u64,
        fulfilled_by_request_owner_after_delay: bool,
    }

    struct OperatorConfigAddedEvent has copy, drop {
        operator_type: 0x1::type_name::TypeName,
    }

    struct OperatorConfigRemovedEvent has copy, drop {
        operator_type: 0x1::type_name::TypeName,
    }

    struct OperatorConfigEnabledEvent has copy, drop {
        operator_type: 0x1::type_name::TypeName,
    }

    struct OperatorConfigDisabledEvent has copy, drop {
        operator_type: 0x1::type_name::TypeName,
    }

    struct OperatorStakeConfigAddedEvent has copy, drop {
        operator_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
    }

    struct OperatorStakeConfigRemovedEvent has copy, drop {
        operator_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
    }

    struct OperatorStakeConfigEditedEvent has copy, drop {
        operator_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        daily_loss_limit: u64,
        current_epoch_loss_count: u64,
        last_epoch_reset: u64,
        max_house_stake_per_bet: u64,
        fixed_private_pool_participation: u64,
    }

    struct DollarTypeEditedEvent has copy, drop {
        actor: address,
        previous_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        new_coin_type: 0x1::type_name::TypeName,
    }

    struct HouseCreatedEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        coin_decimals: u8,
    }

    struct HouseCoinDecimalsEditedEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        previous_coin_decimals: u8,
        new_coin_decimals: u8,
    }

    struct PublicPoolMaxCapacityEditedEvent<phantom T0> has copy, drop {
        previous_max_capacity: u64,
        new_max_capacity: u64,
    }

    struct WhitelistPoolCreatedEvent<phantom T0> has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
    }

    struct WhitelistPoolMaxCapacityEditedEvent<phantom T0> has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        previous_max_capacity: u64,
        new_max_capacity: u64,
    }

    struct WhitelistPoolWeightEditedEvent<phantom T0> has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        previous_weight: u64,
        new_weight: u64,
    }

    struct PipeCreatedEvent<phantom T0, phantom T1: drop> has copy, drop {
        pool_id: 0x2::object::ID,
        pond_id: 0x2::object::ID,
    }

    struct PipeDeletedEvent<phantom T0, phantom T1: drop> has copy, drop {
        pool_id: 0x2::object::ID,
        pond_id: 0x2::object::ID,
    }

    struct PrivatePoolDepositEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct RakebackPoolDepositEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct RakebackPoolWithdrawEvent<phantom T0, phantom T1: drop> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct SweetHouseVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct PrivatePoolDailyWithdrawalLimitEditedEvent<phantom T0> has copy, drop {
        previous_daily_withdrawal_limit: u64,
        new_daily_withdrawal_limit: u64,
    }

    struct HouseDistributionModeEditedEvent<phantom T0> has copy, drop {
        previous_distribution_mode: u8,
        new_distribution_mode: u8,
    }

    struct HouseDistributionWeightsEditedEvent<phantom T0> has copy, drop {
        previous_private_weight: u64,
        previous_whitelist_weight: u64,
        previous_public_weight: u64,
        new_private_weight: u64,
        new_whitelist_weight: u64,
        new_public_weight: u64,
    }

    struct PublicPoolDepositFeeEditedEvent<phantom T0> has copy, drop {
        previous_public_deposit_fee: u64,
        new_public_deposit_fee: u64,
    }

    struct RakebackPoolFundedEvent<phantom T0, phantom T1> has copy, drop {
        game_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WhitelistPoolValuesLog has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        balance_value: u64,
        debt_value: u64,
        total_value: u64,
    }

    struct LogPoolsValuesEvent<phantom T0> has copy, drop {
        private_pool_id: 0x2::object::ID,
        private_pool_balance_value: u64,
        private_pool_debt_value: u64,
        private_pool_total_value: u64,
        public_pool_id: 0x2::object::ID,
        public_pool_balance_value: u64,
        public_pool_debt_value: u64,
        public_pool_total_value: u64,
        rakeback_pool_id: 0x2::object::ID,
        rakeback_pool_balance_value: u64,
        rakeback_pool_debt_value: u64,
        rakeback_pool_total_value: u64,
        whitelist_pools: vector<WhitelistPoolValuesLog>,
    }

    struct PipeLiquidityBorrowedEvent<phantom T0, phantom T1: drop> has copy, drop {
        pool_id: 0x2::object::ID,
        pond_id: 0x2::object::ID,
        liquidity_amount: u64,
        debt_issued_amount: u64,
        pool_balance_value_after: u64,
        pool_debt_value_after: u64,
        pool_total_value_after: u64,
        pipe_debt_value_after: u64,
    }

    struct PipeLiquidityReturnedEvent<phantom T0, phantom T1: drop> has copy, drop {
        pool_id: 0x2::object::ID,
        pond_id: 0x2::object::ID,
        liquidity_amount: u64,
        debt_repaid_amount: u64,
        pool_balance_value_after: u64,
        pool_debt_value_after: u64,
        pool_total_value_after: u64,
        pipe_debt_value_after: u64,
    }

    public fun get_coin_decimals<T0>(arg0: &SweetHouse) : u8 {
        assert_valid_version(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_coin_decimals<T0>(borrow_house<T0>(arg0))
    }

    public fun put_rakeback_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::balance::Balance<T0>) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_rakeback_pool<T0>(v0, arg1);
        emit_rakeback_pool_deposit_event<T0>(arg0, 0x2::balance::value<T0>(&arg1));
    }

    public fun total_rakeback_pool_balance<T0>(arg0: &SweetHouse) : u64 {
        assert_valid_version(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_rakeback_pool_balance<T0>(borrow_house<T0>(arg0))
    }

    fun add_operator_stake_config_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189268063944711);
        let v1 = 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13841537318393610283);
        let v3 = OperatorStakeConfig<T0>{
            id                               : 0x2::object::new(arg1),
            daily_loss_limit                 : 0,
            current_epoch_loss_count         : 0,
            current_epoch_loss_credit_total  : 0,
            current_epoch_loss_debit_total   : 0,
            last_epoch_reset                 : 0,
            max_house_stake_per_bet          : 0,
            fixed_private_pool_participation : 0,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, OperatorStakeConfig<T0>>(&mut v1.id, v2, v3);
        let v4 = OperatorStakeConfigAddedEvent{
            operator_type : 0x1::type_name::with_defining_ids<T1>(),
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<OperatorStakeConfigAddedEvent>(v4);
    }

    public fun admin_add_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 13842381339597209649);
        let v1 = OperatorKey{pos0: v0};
        assert!(!0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v1), 13835625948743073795);
        let v2 = OperatorConfig{
            id      : 0x2::object::new(arg2),
            enabled : true,
        };
        0x2::dynamic_object_field::add<OperatorKey, OperatorConfig>(&mut arg0.id, v1, v2);
        let v3 = OperatorConfigAddedEvent{operator_type: v0};
        0x2::event::emit<OperatorConfigAddedEvent>(v3);
    }

    public fun admin_add_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        add_operator_stake_config_internal<T0, T1>(arg0, arg2);
    }

    public fun admin_add_version(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.version_set, arg2);
            let v0 = SweetHouseVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<SweetHouseVersionChangedEvent>(v0);
        };
    }

    public fun admin_create_house<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        create_house_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_create_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        create_pipe_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun admin_create_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        create_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_delete_empty_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        delete_empty_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_delete_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::object::ID, arg3: &0x2::object::ID) {
        delete_pipe_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun admin_delete_whitelist_pool_and_refund<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        delete_whitelist_pool_and_refund_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_disable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap) {
        disable_operator_config_internal<T0>(arg0);
    }

    public fun admin_edit_dollar_type<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        edit_dollar_type_internal<T0>(arg0, arg2);
    }

    public fun admin_edit_house_coin_decimals<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8) {
        edit_house_coin_decimals_internal<T0>(arg0, arg2);
    }

    public fun admin_edit_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        edit_operator_stake_config_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun admin_edit_public_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        edit_public_pool_max_capacity_internal<T0>(arg0, arg2);
    }

    public fun admin_edit_whitelist_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: u64) {
        edit_whitelist_pool_max_capacity_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_enable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap) {
        enable_operator_config_internal<T0>(arg0);
    }

    public fun admin_fulfill_redeem_request<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        fulfill_redeem_request<T0>(arg0, arg2, v0, false, arg3);
    }

    public fun admin_remove_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap) {
        remove_operator_config_internal<T0>(arg0);
    }

    public fun admin_remove_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap) {
        remove_operator_stake_config_internal<T0, T1>(arg0);
    }

    public fun admin_remove_version(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        remove_version_internal(arg0, arg2);
    }

    public fun admin_reset_daily_loss_count<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::tx_context::TxContext) {
        reset_daily_loss_count_internal<T0, T1>(arg0, arg2);
    }

    public fun admin_set_daily_withdrawal_limit<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::set_private_pool_daily_withdrawal_limit<T0>(v0, arg2);
        let v1 = PrivatePoolDailyWithdrawalLimitEditedEvent<T0>{
            previous_daily_withdrawal_limit : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_private_pool_daily_withdrawal_limit<T0>(v0),
            new_daily_withdrawal_limit      : arg2,
        };
        0x2::event::emit<PrivatePoolDailyWithdrawalLimitEditedEvent<T0>>(v1);
    }

    public fun admin_set_house_distribution_mode<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u8) {
        set_house_distribution_mode<T0>(arg0, arg2);
    }

    public fun admin_set_house_distribution_weights<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        set_house_distribution_weights<T0>(arg0, arg2, arg3, arg4);
    }

    public fun admin_set_house_public_deposit_fee<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        set_house_public_pool_deposit_fee<T0>(arg0, arg2);
    }

    public fun admin_set_whitelist_pool_weight<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: u64) {
        set_whitelist_pool_weight_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_withdraw_all_private_pool<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::withdraw_all_private_pool<T0>(v0), arg2);
        emit_private_pool_withdraw_event<T0>(0x2::tx_context::sender(arg2), &v1, 0x1::type_name::with_defining_ids<T0>(), false, true);
        emit_log_pools_values_event<T0>(arg0);
        v1
    }

    public fun admin_withdraw_private_pool<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        withdraw_private_pool_internal<T0>(arg0, arg2, arg3)
    }

    public fun admin_withdraw_private_pool_with_restrictions<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        withdraw_private_pool_with_restrictions_internal<T0>(arg0, arg2, arg3, arg4)
    }

    fun assert_can_claim_own_redeem_request_after_delay<T0>(arg0: &SweetHouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: address) {
        let v0 = RedeemRequestKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists_<RedeemRequestKey>(&arg0.id, v0), 13838163874984099859);
        let v1 = 0x2::dynamic_object_field::borrow<RedeemRequestKey, RedeemRequest<T0>>(&arg0.id, v0);
        assert!(v1.sender == arg3, 13842948958180343861);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v1.created_at, 13842667491793436723);
        assert!(v2 - v1.created_at >= 604800000, 13842667496088404019);
    }

    fun assert_nonzero_number_of_operations(arg0: u64) {
        assert!(arg0 > 0, 13841815357396615213);
    }

    public fun assert_operator_config_enabled<T0: drop>(arg0: &SweetHouse) {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 13842381253697863729);
        let v1 = OperatorKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v1), 13836188812797411335);
        assert!(0x2::dynamic_object_field::borrow<OperatorKey, OperatorConfig>(&arg0.id, v1).enabled, 13839847996086157343);
    }

    public fun assert_operator_config_exists<T0: drop>(arg0: &SweetHouse) {
        assert!(operator_config_exists<T0>(arg0), 13836188778437672967);
    }

    public fun assert_operator_stake_config_exists<T0, T1: drop>(arg0: &SweetHouse) {
        assert_operator_config_enabled<T1>(arg0);
        assert!(operator_stake_config_exists<T0, T1>(arg0), 13840129492537835553);
    }

    fun assert_valid_version(arg0: &SweetHouse) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13839563540402012189);
    }

    fun borrow_house<T0>(arg0: &SweetHouse) : &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::House<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = HouseKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<HouseKey>(&arg0.id, v1), 13835905040013066245);
        let v2 = HouseKey{pos0: v0};
        0x2::dynamic_object_field::borrow<HouseKey, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::House<T0>>(&arg0.id, v2)
    }

    fun borrow_house_mut<T0>(arg0: &mut SweetHouse) : &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::House<T0> {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = HouseKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<HouseKey>(&arg0.id, v1), 13835905074372804613);
        let v2 = HouseKey{pos0: v0};
        0x2::dynamic_object_field::borrow_mut<HouseKey, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::House<T0>>(&mut arg0.id, v2)
    }

    public fun borrow_operator_df<T0: drop, T1: copy + drop + store, T2: store>(arg0: &SweetHouse, arg1: T1) : &T2 {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_field::borrow<T1, T2>(&arg0.id, arg1)
    }

    public fun borrow_operator_dof<T0: drop, T1: copy + drop + store, T2: store + key>(arg0: &SweetHouse, arg1: T1) : &T2 {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_object_field::borrow<T1, T2>(&arg0.id, arg1)
    }

    fun borrow_operator_stake_config_mut<T0, T1: drop>(arg0: &mut SweetHouse) : &mut OperatorStakeConfig<T0> {
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        let v1 = 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13840130278516850721);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, OperatorStakeConfig<T0>>(&mut v1.id, v2)
    }

    fun borrow_pipe<T0, T1: drop>(arg0: &SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) : &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::Pipe<T0, T1> {
        let v0 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<PipeKey<T0, T1>>(&arg0.id, v0), 13837876361283239953);
        0x2::dynamic_object_field::borrow<PipeKey<T0, T1>, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::Pipe<T0, T1>>(&arg0.id, v0)
    }

    fun borrow_pipe_mut<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) : &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::Pipe<T0, T1> {
        let v0 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<PipeKey<T0, T1>>(&arg0.id, v0), 13837876387053043729);
        0x2::dynamic_object_field::borrow_mut<PipeKey<T0, T1>, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::Pipe<T0, T1>>(&mut arg0.id, v0)
    }

    public fun claim_own_redeem_request_after_delay<T0>(arg0: &mut SweetHouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_can_claim_own_redeem_request_after_delay<T0>(arg0, arg1, arg2, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::tx_context::sender(arg3);
        fulfill_redeem_request<T0>(arg0, arg1, v0, true, arg3);
    }

    fun create_house_internal<T0>(arg0: &mut SweetHouse, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 19, 13843223840382386231);
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!house_exists<T0>(arg0), 13835342553915850753);
        let v1 = HouseKey{pos0: v0};
        0x2::dynamic_object_field::add<HouseKey, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::House<T0>>(&mut arg0.id, v1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::new<T0>(arg1, arg2));
        let v2 = HouseCreatedEvent{
            coin_type     : v0,
            coin_decimals : arg1,
        };
        0x2::event::emit<HouseCreatedEvent>(v2);
    }

    fun create_pipe_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::borrow_pool_from_id<T0>(v0, arg1);
        let v2 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        assert!(!0x2::dynamic_object_field::exists_<PipeKey<T0, T1>>(&arg0.id, v2), 13840972667632877607);
        0x2::dynamic_object_field::add<PipeKey<T0, T1>, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::Pipe<T0, T1>>(&mut arg0.id, v2, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::new_pipe<T0, T1>(v1, arg3));
        emit_pipe_created_event<T0, T1>(arg1, arg2);
    }

    fun create_whitelist_pool_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::create_whitelist_pool<T0>(v0, arg1, arg2);
        let (v1, _, _, _, _) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::whitelist_pool_values_at<T0>(v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::whitelist_pools_len<T0>(v0) - 1);
        let v6 = WhitelistPoolCreatedEvent<T0>{
            owner   : arg1,
            pool_id : v1,
        };
        0x2::event::emit<WhitelistPoolCreatedEvent<T0>>(v6);
    }

    fun credit_current_epoch_loss<T0>(arg0: &mut OperatorStakeConfig<T0>, arg1: u64) {
        arg0.current_epoch_loss_credit_total = arg0.current_epoch_loss_credit_total + (arg1 as u128);
        sync_current_epoch_loss_count_from_totals<T0>(arg0);
    }

    fun debit_current_epoch_loss<T0>(arg0: &mut OperatorStakeConfig<T0>, arg1: u64) {
        arg0.current_epoch_loss_debit_total = arg0.current_epoch_loss_debit_total + (arg1 as u128);
        sync_current_epoch_loss_count_from_totals<T0>(arg0);
        assert!(arg0.current_epoch_loss_debit_total <= arg0.current_epoch_loss_credit_total || arg0.current_epoch_loss_debit_total - arg0.current_epoch_loss_credit_total <= (arg0.daily_loss_limit as u128), 13840411903817547811);
    }

    fun debit_current_epoch_loss_for_operator<T0, T1: drop>(arg0: &mut SweetHouse, arg1: u64) {
        let v0 = borrow_operator_stake_config_mut<T0, T1>(arg0);
        debit_current_epoch_loss<T0>(v0, arg1);
    }

    fun delete_empty_whitelist_pool_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::delete_empty_whitelist_pool<T0>(borrow_house_mut<T0>(arg0), arg1, arg2);
    }

    fun delete_pipe_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) {
        assert_valid_version(arg0);
        let v0 = borrow_pipe_mut<T0, T1>(arg0, arg1, arg2);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::get_balance_value<T0, T1>(v0) == 0, 13838439521690320917);
        let v1 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        emit_pipe_deleted_event<T0, T1>(arg1, arg2);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::destroy<T0, T1>(0x2::dynamic_object_field::remove<PipeKey<T0, T1>, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::Pipe<T0, T1>>(&mut arg0.id, v1));
    }

    fun delete_whitelist_pool_and_refund_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_house_mut<T0>(arg0);
        delete_empty_whitelist_pool_internal<T0>(arg0, arg1, arg2);
        let v2 = 0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::withdraw_all_whitelist_pool<T0>(v1, arg1), arg2);
        let v3 = WhitelistPoolWithdrawEvent{
            pool_id      : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_pool_id<T0>(v1, arg1),
            withdrawer   : v0,
            pool_owner   : arg1,
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            amount       : 0x2::coin::value<T0>(&v2),
            withdraw_all : true,
        };
        0x2::event::emit<WhitelistPoolWithdrawEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg1);
        emit_log_pools_values_event<T0>(arg0);
    }

    public fun deposit_private_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_private_pool<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
        emit_private_pool_deposit_event<T0>(arg0, 0x2::coin::value<T0>(&arg1));
        emit_log_pools_values_event<T0>(arg0);
    }

    public fun deposit_public_pool_and_mint_staked_coins<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::StakedCoin<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = borrow_house_mut<T0>(arg0);
        let v2 = (((0x2::balance::value<T0>(&v0) as u128) * (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_public_deposit_fee<T0>(v1) as u128) / 100000) as u64);
        if (v2 > 0) {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_private_pool<T0>(v1, 0x2::balance::split<T0>(&mut v0, v2));
            let v3 = HouseTakeDepositFeeEvent{
                deposit_fee_amount : v2,
                coin_type          : 0x1::type_name::with_defining_ids<T0>(),
                staker             : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<HouseTakeDepositFeeEvent>(v3);
        };
        emit_log_pools_values_event<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::deposit_public_pool<T0>(v1, v0, arg2)
    }

    public fun deposit_rakeback_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>) {
        put_rakeback_pool<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_self_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::deposit_whitelist_pool<T0>(borrow_house_mut<T0>(arg0), v0, v0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_with_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::deposit_whitelist_pool<T0>(borrow_house_mut<T0>(arg0), 0x2::tx_context::sender(arg3), arg2, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun df_exists<T0: copy + drop + store>(arg0: &SweetHouse, arg1: T0) : bool {
        assert_valid_version(arg0);
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun df_exists_with_type<T0: drop, T1: copy + drop + store, T2: store>(arg0: &SweetHouse, arg1: T0, arg2: T1) : bool {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_field::exists_with_type<T1, T2>(&arg0.id, arg2)
    }

    fun disable_operator_config_internal<T0: drop>(arg0: &mut SweetHouse) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189079085383687);
        0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0).enabled = false;
        let v1 = OperatorConfigDisabledEvent{operator_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<OperatorConfigDisabledEvent>(v1);
    }

    public fun dof_exists<T0: copy + drop + store>(arg0: &SweetHouse, arg1: T0) : bool {
        assert_valid_version(arg0);
        0x2::dynamic_object_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun dof_exists_with_type<T0: drop, T1: copy + drop + store, T2: store + key>(arg0: &SweetHouse, arg1: T0, arg2: T1) : bool {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_object_field::exists_with_type<T1, T2>(&arg0.id, arg2)
    }

    fun edit_dollar_type_internal<T0>(arg0: &mut SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert!(house_exists<T0>(arg0), 13835905284826202117);
        let v0 = DollarTypesKey{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = if (!0x2::dynamic_object_field::exists_<DollarTypesKey>(&arg0.id, v0)) {
            0x1::option::none<0x1::type_name::TypeName>()
        } else {
            let v3 = 0x2::dynamic_object_field::borrow_mut<DollarTypesKey, DollarTypes>(&mut arg0.id, v0);
            let v4 = if (0x1::vector::length<0x1::type_name::TypeName>(&v3.type_names) > 0) {
                0x1::option::some<0x1::type_name::TypeName>(*0x1::vector::borrow<0x1::type_name::TypeName>(&v3.type_names, 0))
            } else {
                0x1::option::none<0x1::type_name::TypeName>()
            };
            let v5 = 0x1::vector::empty<0x1::type_name::TypeName>();
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v5, v1);
            v3.type_names = v5;
            v4
        };
        if (!0x2::dynamic_object_field::exists_<DollarTypesKey>(&arg0.id, v0)) {
            let v6 = 0x1::vector::empty<0x1::type_name::TypeName>();
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v6, v1);
            let v7 = DollarTypes{
                id         : 0x2::object::new(arg1),
                type_names : v6,
            };
            0x2::dynamic_object_field::add<DollarTypesKey, DollarTypes>(&mut arg0.id, v0, v7);
        };
        let v8 = DollarTypeEditedEvent{
            actor              : 0x2::tx_context::sender(arg1),
            previous_coin_type : v2,
            new_coin_type      : v1,
        };
        0x2::event::emit<DollarTypeEditedEvent>(v8);
    }

    fun edit_house_coin_decimals_internal<T0>(arg0: &mut SweetHouse, arg1: u8) {
        assert!(arg1 <= 19, 13843224029360947255);
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::edit_coin_decimals<T0>(v0, arg1);
        let v1 = HouseCoinDecimalsEditedEvent{
            coin_type              : 0x1::type_name::with_defining_ids<T0>(),
            previous_coin_decimals : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_coin_decimals<T0>(v0),
            new_coin_decimals      : arg1,
        };
        0x2::event::emit<HouseCoinDecimalsEditedEvent>(v1);
    }

    fun edit_operator_stake_config_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: u64, arg2: u64, arg3: u64) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189925193940999);
        let v1 = 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13840130596344430625);
        assert!(arg3 <= 100, 13842100938362191919);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, OperatorStakeConfig<T0>>(&mut v1.id, v2);
        v3.daily_loss_limit = arg1;
        v3.max_house_stake_per_bet = arg2;
        v3.fixed_private_pool_participation = arg3;
        sync_current_epoch_loss_count_from_totals<T0>(v3);
        let v4 = OperatorStakeConfigEditedEvent{
            operator_type                    : 0x1::type_name::with_defining_ids<T1>(),
            coin_type                        : 0x1::type_name::with_defining_ids<T0>(),
            daily_loss_limit                 : arg1,
            current_epoch_loss_count         : v3.current_epoch_loss_count,
            last_epoch_reset                 : v3.last_epoch_reset,
            max_house_stake_per_bet          : arg2,
            fixed_private_pool_participation : arg3,
        };
        0x2::event::emit<OperatorStakeConfigEditedEvent>(v4);
    }

    fun edit_public_pool_max_capacity_internal<T0>(arg0: &mut SweetHouse, arg1: u64) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::edit_public_pool_max_capacity<T0>(v0, arg1);
        let v1 = PublicPoolMaxCapacityEditedEvent<T0>{
            previous_max_capacity : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_public_pool_max_capacity<T0>(v0),
            new_max_capacity      : arg1,
        };
        0x2::event::emit<PublicPoolMaxCapacityEditedEvent<T0>>(v1);
    }

    fun edit_whitelist_pool_max_capacity_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: u64) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::edit_whitelist_pool_max_capacity<T0>(v0, arg1, arg2);
        let v1 = WhitelistPoolMaxCapacityEditedEvent<T0>{
            owner                 : arg1,
            pool_id               : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_pool_id<T0>(v0, arg1),
            previous_max_capacity : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_pool_max_capacity<T0>(v0, arg1),
            new_max_capacity      : arg2,
        };
        0x2::event::emit<WhitelistPoolMaxCapacityEditedEvent<T0>>(v1);
    }

    public fun emit_log_pools_values_event<T0>(arg0: &SweetHouse) {
        assert_valid_version(arg0);
        let v0 = borrow_house<T0>(arg0);
        let (v1, v2, v3, v4) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::private_pool_values<T0>(v0);
        let (v5, v6, v7, v8) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::public_pool_values<T0>(v0);
        let (v9, v10, v11, v12) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::rakeback_pool_values<T0>(v0);
        let v13 = 0x1::vector::empty<WhitelistPoolValuesLog>();
        let v14 = 0;
        while (v14 < 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::whitelist_pools_len<T0>(v0)) {
            let (v15, v16, v17, v18, v19) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::whitelist_pool_values_at<T0>(v0, v14);
            let v20 = WhitelistPoolValuesLog{
                pool_id       : v15,
                owner         : v16,
                balance_value : v17,
                debt_value    : v18,
                total_value   : v19,
            };
            0x1::vector::push_back<WhitelistPoolValuesLog>(&mut v13, v20);
            v14 = v14 + 1;
        };
        let v21 = LogPoolsValuesEvent<T0>{
            private_pool_id             : v1,
            private_pool_balance_value  : v2,
            private_pool_debt_value     : v3,
            private_pool_total_value    : v4,
            public_pool_id              : v5,
            public_pool_balance_value   : v6,
            public_pool_debt_value      : v7,
            public_pool_total_value     : v8,
            rakeback_pool_id            : v9,
            rakeback_pool_balance_value : v10,
            rakeback_pool_debt_value    : v11,
            rakeback_pool_total_value   : v12,
            whitelist_pools             : v13,
        };
        0x2::event::emit<LogPoolsValuesEvent<T0>>(v21);
    }

    fun emit_pipe_created_event<T0, T1: drop>(arg0: &0x2::object::ID, arg1: &0x2::object::ID) {
        let v0 = PipeCreatedEvent<T0, T1>{
            pool_id : *arg0,
            pond_id : *arg1,
        };
        0x2::event::emit<PipeCreatedEvent<T0, T1>>(v0);
    }

    fun emit_pipe_deleted_event<T0, T1: drop>(arg0: &0x2::object::ID, arg1: &0x2::object::ID) {
        let v0 = PipeDeletedEvent<T0, T1>{
            pool_id : *arg0,
            pond_id : *arg1,
        };
        0x2::event::emit<PipeDeletedEvent<T0, T1>>(v0);
    }

    fun emit_pipe_liquidity_borrowed_event<T0, T1: drop>(arg0: &SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let (_, v1, v2, v3) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::pool_values<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::borrow_pool_from_id<T0>(borrow_house<T0>(arg0), arg1));
        let v4 = PipeLiquidityBorrowedEvent<T0, T1>{
            pool_id                  : *arg1,
            pond_id                  : *arg2,
            liquidity_amount         : arg3,
            debt_issued_amount       : arg4,
            pool_balance_value_after : v1,
            pool_debt_value_after    : v2,
            pool_total_value_after   : v3,
            pipe_debt_value_after    : arg5,
        };
        0x2::event::emit<PipeLiquidityBorrowedEvent<T0, T1>>(v4);
    }

    fun emit_pipe_liquidity_returned_event<T0, T1: drop>(arg0: &SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let (_, v1, v2, v3) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::pool_values<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::borrow_pool_from_id<T0>(borrow_house<T0>(arg0), arg1));
        let v4 = PipeLiquidityReturnedEvent<T0, T1>{
            pool_id                  : *arg1,
            pond_id                  : *arg2,
            liquidity_amount         : arg3,
            debt_repaid_amount       : arg4,
            pool_balance_value_after : v1,
            pool_debt_value_after    : v2,
            pool_total_value_after   : v3,
            pipe_debt_value_after    : arg5,
        };
        0x2::event::emit<PipeLiquidityReturnedEvent<T0, T1>>(v4);
    }

    fun emit_private_pool_deposit_event<T0>(arg0: &SweetHouse, arg1: u64) {
        let (v0, _, _, _) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::private_pool_values<T0>(borrow_house<T0>(arg0));
        let v4 = PrivatePoolDepositEvent<T0>{
            pool_id : v0,
            amount  : arg1,
        };
        0x2::event::emit<PrivatePoolDepositEvent<T0>>(v4);
    }

    fun emit_private_pool_withdraw_event<T0>(arg0: address, arg1: &0x2::coin::Coin<T0>, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: bool) {
        let v0 = PrivatePoolWithdrawEvent{
            withdrawer   : arg0,
            coin_type    : arg2,
            amount       : 0x2::coin::value<T0>(arg1),
            restricted   : arg3,
            withdraw_all : arg4,
        };
        0x2::event::emit<PrivatePoolWithdrawEvent>(v0);
    }

    fun emit_rakeback_pool_deposit_event<T0>(arg0: &SweetHouse, arg1: u64) {
        let (v0, _, _, _) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::rakeback_pool_values<T0>(borrow_house<T0>(arg0));
        let v4 = RakebackPoolDepositEvent<T0>{
            pool_id : v0,
            amount  : arg1,
        };
        0x2::event::emit<RakebackPoolDepositEvent<T0>>(v4);
    }

    fun emit_rakeback_pool_withdraw_event<T0, T1: drop>(arg0: &SweetHouse, arg1: u64) {
        let (v0, _, _, _) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::rakeback_pool_values<T0>(borrow_house<T0>(arg0));
        let v4 = RakebackPoolWithdrawEvent<T0, T1>{
            pool_id : v0,
            amount  : arg1,
        };
        0x2::event::emit<RakebackPoolWithdrawEvent<T0, T1>>(v4);
    }

    fun enable_operator_config_internal<T0: drop>(arg0: &mut SweetHouse) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189173574664199);
        0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0).enabled = true;
        let v1 = OperatorConfigEnabledEvent{operator_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<OperatorConfigEnabledEvent>(v1);
    }

    fun fulfill_redeem_request<T0>(arg0: &mut SweetHouse, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = RedeemRequestKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists_<RedeemRequestKey>(&arg0.id, v0), 13838163716070309907);
        let RedeemRequest {
            id             : v1,
            staked_balance : v2,
            created_at     : v3,
            sender         : v4,
        } = 0x2::dynamic_object_field::remove<RedeemRequestKey, RedeemRequest<T0>>(&mut arg0.id, v0);
        let v5 = v2;
        0x2::object::delete(v1);
        let v6 = borrow_house_mut<T0>(arg0);
        let v7 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::redeem_public_pool<T0>(v6, v5, v4);
        let v8 = RedeemRequestFulfilledEvent{
            request_id                             : arg1,
            player                                 : v4,
            actor                                  : arg2,
            coin_type                              : 0x1::type_name::with_defining_ids<T0>(),
            staked_amount                          : 0x2::balance::value<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::StakedCoin<T0>>(&v5),
            payout_amount                          : 0x2::balance::value<T0>(&v7),
            created_at_ms                          : v3,
            fulfilled_by_request_owner_after_delay : arg3,
        };
        0x2::event::emit<RedeemRequestFulfilledEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), v4);
        emit_log_pools_values_event<T0>(arg0);
    }

    public fun get_dollar_coin_type(arg0: &SweetHouse) : 0x1::type_name::TypeName {
        assert_valid_version(arg0);
        let v0 = DollarTypesKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<DollarTypesKey>(&arg0.id, v0), 13841253472594821161);
        *0x1::vector::borrow<0x1::type_name::TypeName>(&0x2::dynamic_object_field::borrow<DollarTypesKey, DollarTypes>(&arg0.id, v0).type_names, 0)
    }

    public fun house_exists<T0>(arg0: &SweetHouse) : bool {
        assert_valid_version(arg0);
        let v0 = HouseKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_object_field::exists_<HouseKey>(&arg0.id, v0)
    }

    public fun house_exists_by_type(arg0: &SweetHouse, arg1: 0x1::type_name::TypeName) : bool {
        assert_valid_version(arg0);
        let v0 = HouseKey{pos0: arg1};
        0x2::dynamic_object_field::exists_<HouseKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SweetHouse{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u64>(0),
        };
        0x2::transfer::share_object<SweetHouse>(v0);
    }

    public fun manager_add_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        add_operator_stake_config_internal<T0, T1>(arg0, arg2);
    }

    public fun manager_create_house<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        create_house_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_create_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        create_pipe_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun manager_create_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        create_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_delete_empty_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        delete_empty_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_delete_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        delete_pipe_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun manager_delete_whitelist_pool_and_refund<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        delete_whitelist_pool_and_refund_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_disable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        disable_operator_config_internal<T0>(arg0);
    }

    public fun manager_edit_dollar_type<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        edit_dollar_type_internal<T0>(arg0, arg2);
    }

    public fun manager_edit_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg5));
        edit_operator_stake_config_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun manager_edit_public_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        edit_public_pool_max_capacity_internal<T0>(arg0, arg2);
    }

    public fun manager_edit_whitelist_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        edit_whitelist_pool_max_capacity_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_enable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        enable_operator_config_internal<T0>(arg0);
    }

    public fun manager_fulfill_redeem_request<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::tx_context::sender(arg3);
        fulfill_redeem_request<T0>(arg0, arg2, v0, false, arg3);
    }

    public fun manager_remove_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        remove_operator_config_internal<T0>(arg0);
    }

    public fun manager_remove_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        remove_operator_stake_config_internal<T0, T1>(arg0);
    }

    public fun manager_remove_version(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        remove_version_internal(arg0, arg2);
    }

    public fun manager_reset_daily_loss_count<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        reset_daily_loss_count_internal<T0, T1>(arg0, arg2);
    }

    public fun manager_set_house_distribution_mode<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        set_house_distribution_mode<T0>(arg0, arg2);
    }

    public fun manager_set_house_public_deposit_fee<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        set_house_public_pool_deposit_fee<T0>(arg0, arg2);
    }

    public fun manager_withdraw_private_pool_with_restrictions<T0>(arg0: &mut SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        withdraw_private_pool_with_restrictions_internal<T0>(arg0, arg2, arg3, arg4)
    }

    public fun operator_add_operator_df<T0: drop, T1: copy + drop + store, T2: store>(arg0: &mut SweetHouse, arg1: T0, arg2: T1, arg3: T2) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        assert!(!0x2::dynamic_field::exists_<T1>(&arg0.id, arg2), 13839008750886191129);
        0x2::dynamic_field::add<T1, T2>(&mut arg0.id, arg2, arg3);
    }

    public fun operator_add_operator_dof<T0: drop, T1: copy + drop + store, T2: store + key>(arg0: &mut SweetHouse, arg1: T0, arg2: T1, arg3: T2) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        assert!(!0x2::dynamic_object_field::exists_<T1>(&arg0.id, arg2), 13838727220074774551);
        0x2::dynamic_object_field::add<T1, T2>(&mut arg0.id, arg2, arg3);
    }

    public fun operator_borrow_operator_df_mut<T0: drop, T1: copy + drop + store, T2: store>(arg0: &mut SweetHouse, arg1: T0, arg2: T1) : &mut T2 {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_field::borrow_mut<T1, T2>(&mut arg0.id, arg2)
    }

    public fun operator_borrow_operator_dof_mut<T0: drop, T1: copy + drop + store, T2: store + key>(arg0: &mut SweetHouse, arg1: T0, arg2: T1) : &mut T2 {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_object_field::borrow_mut<T1, T2>(&mut arg0.id, arg2)
    }

    public fun operator_config_enabled<T0: drop>(arg0: &SweetHouse) : bool {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        if (!0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0)) {
            return false
        };
        0x2::dynamic_object_field::borrow<OperatorKey, OperatorConfig>(&arg0.id, v0).enabled
    }

    public fun operator_config_exists<T0: drop>(arg0: &SweetHouse) : bool {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0)
    }

    public fun operator_fund_rakeback_pool_using_stake_ticket_sources<T0, T1: drop, T2: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T2>, arg3: u64) {
        let v0 = operator_take_using_stake_ticket_sources<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_rakeback_pool<T0>(borrow_house_mut<T0>(arg0), v0);
        let v1 = RakebackPoolFundedEvent<T0, T1>{
            game_type : 0x1::type_name::with_defining_ids<T2>(),
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<RakebackPoolFundedEvent<T0, T1>>(v1);
    }

    public fun operator_put_and_get_stake_ticket<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1> {
        put_and_get_stake_ticket_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun operator_put_into_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &T1, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: 0x2::balance::Balance<T0>) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = borrow_pipe_mut<T0, T1>(arg0, arg2, arg3);
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::get_balance_value<T0, T1>(v1);
        let v3 = if (v0 > v2) {
            v2
        } else {
            v0
        };
        let v4 = if (v3 == 0) {
            0x2::balance::zero<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>()
        } else {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::take_debt<T0, T1>(v1, v3)
        };
        let v5 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::get_balance_value<T0, T1>(v1);
        let v6 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_into_pool_for_pipe<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::borrow_pool_mut_from_id<T0>(v6, arg2), arg4, v4);
        emit_pipe_liquidity_returned_event<T0, T1>(arg0, arg2, arg3, v0, v3, v5);
    }

    public fun operator_put_private_pool_and_get_stake_ticket<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        put_private_pool_and_get_stake_ticket_internal<T0, T1>(arg0, arg2, 0x2::coin::value<T0>(&arg2), arg3, arg4, arg5, arg6)
    }

    public fun operator_put_private_pool_and_get_stake_ticket_with_stake_amount<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        put_private_pool_and_get_stake_ticket_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun operator_put_rakeback_pool<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::balance::Balance<T0>) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        put_rakeback_pool<T0>(arg0, arg2);
    }

    public fun operator_remove_operator_df<T0: drop, T1: copy + drop + store, T2: store>(arg0: &mut SweetHouse, arg1: T0, arg2: T1) : T2 {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_field::remove<T1, T2>(&mut arg0.id, arg2)
    }

    public fun operator_remove_operator_dof<T0: drop, T1: copy + drop + store, T2: store + key>(arg0: &mut SweetHouse, arg1: T0, arg2: T1) : T2 {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        0x2::dynamic_object_field::remove<T1, T2>(&mut arg0.id, arg2)
    }

    public fun operator_stake_config_exists<T0, T1: drop>(arg0: &SweetHouse) : bool {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        if (!0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0)) {
            return false
        };
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&0x2::dynamic_object_field::borrow<OperatorKey, OperatorConfig>(&arg0.id, v0).id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun operator_take_and_destroy_stake_ticket<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::take_using_stake_ticket_sources<T0, T1>(v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::utils::sum(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_outcome_amounts<T0, T1>(&arg2)), &arg2);
        assert_operator_config_enabled<T1>(arg0);
        debit_current_epoch_loss_for_operator<T0, T1>(arg0, 0x2::balance::value<T0>(&v1));
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::destroy_stake_ticket<T0, T1>(arg2, arg3, arg4);
        emit_log_pools_values_event<T0>(arg0);
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    public fun operator_take_from_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &T1, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: u64) : 0x2::balance::Balance<T0> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let (v1, v2) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::take_from_pool_for_pipe<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::borrow_pool_mut_from_id<T0>(v0, arg2), arg4);
        let v3 = borrow_pipe_mut<T0, T1>(arg0, arg2, arg3);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::put_debt<T0, T1>(v3, v2);
        emit_pipe_liquidity_borrowed_event<T0, T1>(arg0, arg2, arg3, arg4, arg4, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::get_balance_value<T0, T1>(v3));
        v1
    }

    public fun operator_take_from_rakeback_pool<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        emit_rakeback_pool_withdraw_event<T0, T1>(arg0, arg2);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::take_rakeback_pool<T0>(v0, arg2)
    }

    public fun operator_take_using_stake_ticket_sources<T0, T1: drop, T2: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T2>, arg3: u64) : 0x2::balance::Balance<T0> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::take_using_stake_ticket_sources<T0, T2>(borrow_house_mut<T0>(arg0), arg3, arg2)
    }

    fun package_version() : u64 {
        0
    }

    public fun pipe_debt_value<T0, T1: drop>(arg0: &SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) : u64 {
        assert_valid_version(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe::get_balance_value<T0, T1>(borrow_pipe<T0, T1>(arg0, arg1, arg2))
    }

    fun put_and_get_stake_ticket_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        assert_nonzero_number_of_operations(arg2);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (v2, v3) = reset_and_credit_current_epoch_loss_for_operator<T0, T1>(arg0, v1, arg5);
        let v4 = borrow_house_mut<T0>(arg0);
        let v5 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_distribution_type<T0>(v4);
        let v6 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_distribution_weights<T0>(v4);
        if (v5 == 0) {
            abort 13836755168660029449
        };
        let (v7, v8, v9) = if (v5 == 1) {
            let v10 = &mut v0;
            let (v11, v12, v13) = split_distribution_weighted_by_pool<T0>(v10, v1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_private_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_public_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_private_pool_balance<T0>(v4), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_public_pool_balance<T0>(v4), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_routable_whitelist_pools_balance<T0>(v4));
            let v8 = v13;
            let v7 = v11;
            (v7, v8, v12)
        } else if (v5 == 2) {
            let v14 = &mut v0;
            let (v15, v16, v17) = split_distribution_private_cap_per_bet<T0>(v14, v1, arg2, v1 / arg2, v2, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_private_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_public_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_private_pool_balance<T0>(v4), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_public_pool_balance<T0>(v4), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_routable_whitelist_pools_balance<T0>(v4));
            let v8 = v17;
            let v7 = v15;
            (v7, v8, v16)
        } else {
            assert!(v5 == 3, 13837036854090268683);
            let v18 = &mut v0;
            let (v19, v20, v21) = split_distribution_fixed_private_share<T0>(v18, v1, v3, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_public_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_weight(&v6), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_public_pool_balance<T0>(v4), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::total_routable_whitelist_pools_balance<T0>(v4));
            let v8 = v21;
            let v7 = v19;
            (v7, v8, v20)
        };
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_private_pool<T0>(v4, v7);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_public_pool<T0>(v4, v8);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::join_private_pool<T0>(v4, v0);
        let v22 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::create_stake_ticket<T0, T1>(v1, arg4, arg2, arg3);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::set_source_provenance<T0, T1>(&mut v22, 0x2::balance::value<T0>(&v7) + 0x2::balance::value<T0>(&v0), 0x2::balance::value<T0>(&v8), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_whitelist_pools<T0>(v4, v9));
        v22
    }

    fun put_private_pool_and_get_stake_ticket_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::tx_context::TxContext) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1> {
        assert_nonzero_number_of_operations(arg3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (_, _) = reset_and_credit_current_epoch_loss_for_operator<T0, T1>(arg0, v0, arg6);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::put_private_pool<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::create_stake_ticket<T0, T1>(arg2, arg5, arg3, arg4);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::set_source_provenance<T0, T1>(&mut v3, v0, 0, 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::WhitelistPoolSourceShare>());
        v3
    }

    public fun redeem_request<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::StakedCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg0);
        let v0 = 0x2::coin::value<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::StakedCoin<T0>>(&arg1);
        assert!(v0 > 0, 13837600632972640271);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = RedeemRequest<T0>{
            id             : v1,
            staked_balance : 0x2::coin::into_balance<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::StakedCoin<T0>>(arg1),
            created_at     : v3,
            sender         : 0x2::tx_context::sender(arg3),
        };
        let v5 = RedeemRequestKey{id: v2};
        0x2::dynamic_object_field::add<RedeemRequestKey, RedeemRequest<T0>>(&mut arg0.id, v5, v4);
        let v6 = RedeemRequestCreatedEvent{
            request_id    : v2,
            player        : 0x2::tx_context::sender(arg3),
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            staked_amount : v0,
            created_at_ms : v3,
        };
        0x2::event::emit<RedeemRequestCreatedEvent>(v6);
        v2
    }

    fun remove_operator_config_internal<T0: drop>(arg0: &mut SweetHouse) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836188984596103175);
        let OperatorConfig {
            id      : v1,
            enabled : _,
        } = 0x2::dynamic_object_field::remove<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        0x2::object::delete(v1);
        let v3 = OperatorConfigRemovedEvent{operator_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<OperatorConfigRemovedEvent>(v3);
    }

    fun remove_operator_stake_config_internal<T0, T1: drop>(arg0: &mut SweetHouse) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189435567669255);
        let OperatorStakeConfig {
            id                               : v1,
            daily_loss_limit                 : _,
            current_epoch_loss_count         : _,
            current_epoch_loss_credit_total  : _,
            current_epoch_loss_debit_total   : _,
            last_epoch_reset                 : _,
            max_house_stake_per_bet          : _,
            fixed_private_pool_participation : _,
        } = 0x2::dynamic_object_field::remove<0x1::type_name::TypeName, OperatorStakeConfig<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0).id, 0x1::type_name::with_defining_ids<T0>());
        0x2::object::delete(v1);
        let v9 = OperatorStakeConfigRemovedEvent{
            operator_type : 0x1::type_name::with_defining_ids<T1>(),
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<OperatorStakeConfigRemovedEvent>(v9);
    }

    fun remove_version_internal(arg0: &mut SweetHouse, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13839282894353858587);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = SweetHouseVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<SweetHouseVersionChangedEvent>(v0);
    }

    fun reset_and_credit_current_epoch_loss_for_operator<T0, T1: drop>(arg0: &mut SweetHouse, arg1: u64, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = borrow_operator_stake_config_mut<T0, T1>(arg0);
        reset_current_epoch_loss_tracking_if_needed<T0>(v0, arg2);
        credit_current_epoch_loss<T0>(v0, arg1);
        (v0.max_house_stake_per_bet, v0.fixed_private_pool_participation)
    }

    fun reset_current_epoch_loss_tracking_if_needed<T0>(arg0: &mut OperatorStakeConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        if (arg0.last_epoch_reset < 0x2::tx_context::epoch(arg1)) {
            arg0.current_epoch_loss_credit_total = 0;
            arg0.current_epoch_loss_debit_total = 0;
            arg0.current_epoch_loss_count = 0;
            arg0.last_epoch_reset = 0x2::tx_context::epoch(arg1);
        };
    }

    fun reset_daily_loss_count_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836190101287600135);
        let v1 = 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13840130772438089761);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, OperatorStakeConfig<T0>>(&mut v1.id, v2);
        v3.current_epoch_loss_count = 0;
        v3.current_epoch_loss_credit_total = 0;
        v3.current_epoch_loss_debit_total = 0;
        v3.last_epoch_reset = 0x2::tx_context::epoch(arg1);
    }

    fun set_house_distribution_mode<T0>(arg0: &mut SweetHouse, arg1: u8) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::set_distribution_mode<T0>(v0, arg1);
        let v1 = HouseDistributionModeEditedEvent<T0>{
            previous_distribution_mode : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_distribution_type<T0>(v0),
            new_distribution_mode      : arg1,
        };
        0x2::event::emit<HouseDistributionModeEditedEvent<T0>>(v1);
    }

    fun set_house_distribution_weights<T0>(arg0: &mut SweetHouse, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_distribution_weights<T0>(v0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::set_distribution_weights<T0>(v0, arg1, arg2, arg3);
        let v2 = HouseDistributionWeightsEditedEvent<T0>{
            previous_private_weight   : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_private_weight(&v1),
            previous_whitelist_weight : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_weight(&v1),
            previous_public_weight    : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_public_weight(&v1),
            new_private_weight        : arg1,
            new_whitelist_weight      : arg2,
            new_public_weight         : arg3,
        };
        0x2::event::emit<HouseDistributionWeightsEditedEvent<T0>>(v2);
    }

    fun set_house_public_pool_deposit_fee<T0>(arg0: &mut SweetHouse, arg1: u64) {
        assert!(arg1 <= 10000, 13837316864483262477);
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::set_public_deposit_fee<T0>(v0, arg1);
        let v1 = PublicPoolDepositFeeEditedEvent<T0>{
            previous_public_deposit_fee : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_public_deposit_fee<T0>(v0),
            new_public_deposit_fee      : arg1,
        };
        0x2::event::emit<PublicPoolDepositFeeEditedEvent<T0>>(v1);
    }

    fun set_whitelist_pool_weight_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: u64) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::set_whitelist_pool_weight<T0>(v0, arg1, arg2);
        let v1 = WhitelistPoolWeightEditedEvent<T0>{
            owner           : arg1,
            pool_id         : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_pool_id<T0>(v0, arg1),
            previous_weight : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_pool_weight<T0>(v0, arg1),
            new_weight      : arg2,
        };
        0x2::event::emit<WhitelistPoolWeightEditedEvent<T0>>(v1);
    }

    fun split_distribution_fixed_private_share<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(arg2 <= 100, 13842102832442769455);
        let v0 = (((arg1 as u128) * (arg2 as u128) / 100) as u64);
        let v1 = arg1 - v0;
        if (v1 == 0) {
            (0x2::balance::split<T0>(arg0, v0), 0x2::balance::zero<T0>(), 0x2::balance::zero<T0>())
        } else {
            if (arg5 == 0 && arg6 == 0) {
                return (0x2::balance::split<T0>(arg0, arg1), 0x2::balance::zero<T0>(), 0x2::balance::zero<T0>())
            };
            let v5 = 0x1::vector::empty<u128>();
            0x1::vector::push_back<u128>(&mut v5, (arg4 as u128) * (arg6 as u128));
            0x1::vector::push_back<u128>(&mut v5, (arg3 as u128) * (arg5 as u128));
            let v6 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::allocate_amount_by_effective_weights(v1, &v5);
            (0x2::balance::split<T0>(arg0, v0), 0x2::balance::split<T0>(arg0, *0x1::vector::borrow<u64>(&v6, 0)), 0x2::balance::split<T0>(arg0, *0x1::vector::borrow<u64>(&v6, 1)))
        }
    }

    fun split_distribution_private_cap_per_bet<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        if (arg3 <= arg4) {
            (0x2::balance::split<T0>(arg0, arg1), 0x2::balance::zero<T0>(), 0x2::balance::zero<T0>())
        } else {
            let v3 = arg4 * arg2;
            if (arg9 == 0 && arg10 == 0) {
                return (0x2::balance::split<T0>(arg0, arg1), 0x2::balance::zero<T0>(), 0x2::balance::zero<T0>())
            };
            let v4 = 0x1::vector::empty<u128>();
            0x1::vector::push_back<u128>(&mut v4, (arg7 as u128) * (arg10 as u128));
            0x1::vector::push_back<u128>(&mut v4, (arg6 as u128) * (arg9 as u128));
            let v5 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::allocate_amount_by_effective_weights(arg1 - v3, &v4);
            (0x2::balance::split<T0>(arg0, v3), 0x2::balance::split<T0>(arg0, *0x1::vector::borrow<u64>(&v5, 0)), 0x2::balance::split<T0>(arg0, *0x1::vector::borrow<u64>(&v5, 1)))
        }
    }

    fun split_distribution_weighted_by_pool<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, (arg2 as u128) * (arg5 as u128));
        0x1::vector::push_back<u128>(&mut v0, (arg4 as u128) * (arg7 as u128));
        0x1::vector::push_back<u128>(&mut v0, (arg3 as u128) * (arg6 as u128));
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::allocate_amount_by_effective_weights(arg1, &v0);
        (0x2::balance::split<T0>(arg0, *0x1::vector::borrow<u64>(&v1, 0)), 0x2::balance::split<T0>(arg0, *0x1::vector::borrow<u64>(&v1, 1)), 0x2::balance::split<T0>(arg0, *0x1::vector::borrow<u64>(&v1, 2)))
    }

    fun sync_current_epoch_loss_count_from_totals<T0>(arg0: &mut OperatorStakeConfig<T0>) {
        let v0 = if (arg0.current_epoch_loss_debit_total > arg0.current_epoch_loss_credit_total) {
            arg0.current_epoch_loss_debit_total - arg0.current_epoch_loss_credit_total
        } else {
            0
        };
        let v1 = if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        };
        arg0.current_epoch_loss_count = v1;
    }

    fun withdraw_private_pool_internal<T0>(arg0: &mut SweetHouse, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::withdraw_private_pool<T0>(v0, arg1), arg2);
        emit_private_pool_withdraw_event<T0>(0x2::tx_context::sender(arg2), &v1, 0x1::type_name::with_defining_ids<T0>(), false, false);
        emit_log_pools_values_event<T0>(arg0);
        v1
    }

    fun withdraw_private_pool_with_restrictions_internal<T0>(arg0: &mut SweetHouse, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::withdraw_private_pool_with_daily_withdrawal_limit<T0>(v0, arg1, arg2), arg3);
        emit_private_pool_withdraw_event<T0>(0x2::tx_context::sender(arg3), &v1, 0x1::type_name::with_defining_ids<T0>(), true, false);
        emit_log_pools_values_event<T0>(arg0);
        v1
    }

    public fun withdraw_self_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_house_mut<T0>(arg0);
        let v2 = 0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::withdraw_whitelist_pool<T0>(v1, v0, arg1), arg2);
        let v3 = WhitelistPoolWithdrawEvent{
            pool_id      : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_whitelist_pool_id<T0>(v1, v0),
            withdrawer   : v0,
            pool_owner   : v0,
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            amount       : 0x2::coin::value<T0>(&v2),
            withdraw_all : false,
        };
        0x2::event::emit<WhitelistPoolWithdrawEvent>(v3);
        emit_log_pools_values_event<T0>(arg0);
        v2
    }

    // decompiled from Move bytecode v6
}

