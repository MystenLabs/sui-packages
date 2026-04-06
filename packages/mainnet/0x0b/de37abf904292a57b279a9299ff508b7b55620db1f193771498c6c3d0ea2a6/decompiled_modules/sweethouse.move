module 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse {
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
        staked_balance: 0x2::balance::Balance<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::StakedCoin<T0>>,
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
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_coin_decimals<T0>(borrow_house<T0>(arg0))
    }

    public fun put_rakeback_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::balance::Balance<T0>) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_rakeback_pool<T0>(v0, arg1);
        emit_rakeback_pool_deposit_event<T0>(arg0, 0x2::balance::value<T0>(&arg1));
    }

    public fun total_rakeback_pool_balance<T0>(arg0: &SweetHouse) : u64 {
        assert_valid_version(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_rakeback_pool_balance<T0>(borrow_house<T0>(arg0))
    }

    fun add_operator_stake_config_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189126330023943);
        let v1 = 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13841537176659689515);
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

    public fun admin_add_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 13842381197863288881);
        let v1 = OperatorKey{pos0: v0};
        assert!(!0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v1), 13835625807009153027);
        let v2 = OperatorConfig{
            id      : 0x2::object::new(arg2),
            enabled : true,
        };
        0x2::dynamic_object_field::add<OperatorKey, OperatorConfig>(&mut arg0.id, v1, v2);
        let v3 = OperatorConfigAddedEvent{operator_type: v0};
        0x2::event::emit<OperatorConfigAddedEvent>(v3);
    }

    public fun admin_add_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        add_operator_stake_config_internal<T0, T1>(arg0, arg2);
    }

    public fun admin_add_version(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.version_set, arg2);
            let v0 = SweetHouseVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<SweetHouseVersionChangedEvent>(v0);
        };
    }

    public fun admin_create_house<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        create_house_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_create_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        create_pipe_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun admin_create_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        create_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_delete_empty_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        delete_empty_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_delete_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &0x2::object::ID, arg3: &0x2::object::ID) {
        delete_pipe_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun admin_delete_whitelist_pool_and_refund<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        delete_whitelist_pool_and_refund_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_disable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap) {
        disable_operator_config_internal<T0>(arg0);
    }

    public fun admin_edit_dollar_type<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        edit_dollar_type_internal<T0>(arg0, arg2);
    }

    public fun admin_edit_house_coin_decimals<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u8) {
        edit_house_coin_decimals_internal<T0>(arg0, arg2);
    }

    public fun admin_edit_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        edit_operator_stake_config_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun admin_edit_public_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        edit_public_pool_max_capacity_internal<T0>(arg0, arg2);
    }

    public fun admin_edit_whitelist_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: u64) {
        edit_whitelist_pool_max_capacity_internal<T0>(arg0, arg2, arg3);
    }

    public fun admin_enable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap) {
        enable_operator_config_internal<T0>(arg0);
    }

    public fun admin_fulfill_redeem_request<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        fulfill_redeem_request<T0>(arg0, arg2, v0, false, arg3);
    }

    public fun admin_remove_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap) {
        remove_operator_config_internal<T0>(arg0);
    }

    public fun admin_remove_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap) {
        remove_operator_stake_config_internal<T0, T1>(arg0);
    }

    public fun admin_remove_version(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        remove_version_internal(arg0, arg2);
    }

    public fun admin_reset_daily_loss_count<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &0x2::tx_context::TxContext) {
        reset_daily_loss_count_internal<T0, T1>(arg0, arg2);
    }

    public fun admin_set_daily_withdrawal_limit<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::set_private_pool_daily_withdrawal_limit<T0>(v0, arg2);
        let v1 = PrivatePoolDailyWithdrawalLimitEditedEvent<T0>{
            previous_daily_withdrawal_limit : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_private_pool_daily_withdrawal_limit<T0>(v0),
            new_daily_withdrawal_limit      : arg2,
        };
        0x2::event::emit<PrivatePoolDailyWithdrawalLimitEditedEvent<T0>>(v1);
    }

    public fun admin_set_house_distribution_mode<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u8) {
        set_house_distribution_mode<T0>(arg0, arg2);
    }

    public fun admin_set_house_public_deposit_fee<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        set_house_public_pool_deposit_fee<T0>(arg0, arg2);
    }

    public fun admin_withdraw_all_private_pool<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::withdraw_all_private_pool<T0>(v0), arg2);
        emit_private_pool_withdraw_event<T0>(0x2::tx_context::sender(arg2), &v1, 0x1::type_name::with_defining_ids<T0>(), false, true);
        emit_log_pools_values_event<T0>(arg0);
        v1
    }

    public fun admin_withdraw_private_pool<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        withdraw_private_pool_internal<T0>(arg0, arg2, arg3)
    }

    public fun admin_withdraw_private_pool_with_restrictions<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        withdraw_private_pool_with_restrictions_internal<T0>(arg0, arg2, arg3, arg4)
    }

    fun assert_can_claim_own_redeem_request_after_delay<T0>(arg0: &SweetHouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: address) {
        let v0 = RedeemRequestKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists_<RedeemRequestKey>(&arg0.id, v0), 13838163355293057043);
        let v1 = 0x2::dynamic_object_field::borrow<RedeemRequestKey, RedeemRequest<T0>>(&arg0.id, v0);
        assert!(v1.sender == arg3, 13842948438489301045);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v1.created_at, 13842666972102393907);
        assert!(v2 - v1.created_at >= 604800000, 13842666976397361203);
    }

    fun assert_nonzero_number_of_operations(arg0: u64) {
        assert!(arg0 > 0, 13841815288677138477);
    }

    public fun assert_operator_config_enabled<T0: drop>(arg0: &SweetHouse) {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 13842381111963942961);
        let v1 = OperatorKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v1), 13836188671063490567);
        assert!(0x2::dynamic_object_field::borrow<OperatorKey, OperatorConfig>(&arg0.id, v1).enabled, 13839847854352236575);
    }

    public fun assert_operator_config_exists<T0: drop>(arg0: &SweetHouse) {
        assert!(operator_config_exists<T0>(arg0), 13836188636703752199);
    }

    public fun assert_operator_stake_config_exists<T0, T1: drop>(arg0: &SweetHouse) {
        assert_operator_config_enabled<T1>(arg0);
        assert!(operator_stake_config_exists<T0, T1>(arg0), 13840129350803914785);
    }

    fun assert_valid_version(arg0: &SweetHouse) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13839563471682535453);
    }

    fun borrow_house<T0>(arg0: &SweetHouse) : &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::House<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = HouseKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<HouseKey>(&arg0.id, v1), 13835904971293589509);
        let v2 = HouseKey{pos0: v0};
        0x2::dynamic_object_field::borrow<HouseKey, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::House<T0>>(&arg0.id, v2)
    }

    fun borrow_house_mut<T0>(arg0: &mut SweetHouse) : &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::House<T0> {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = HouseKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<HouseKey>(&arg0.id, v1), 13835905005653327877);
        let v2 = HouseKey{pos0: v0};
        0x2::dynamic_object_field::borrow_mut<HouseKey, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::House<T0>>(&mut arg0.id, v2)
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
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13840130136782929953);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, OperatorStakeConfig<T0>>(&mut v1.id, v2)
    }

    fun borrow_pipe<T0, T1: drop>(arg0: &SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) : &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::Pipe<T0, T1> {
        let v0 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<PipeKey<T0, T1>>(&arg0.id, v0), 13837876219549319185);
        0x2::dynamic_object_field::borrow<PipeKey<T0, T1>, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::Pipe<T0, T1>>(&arg0.id, v0)
    }

    fun borrow_pipe_mut<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) : &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::Pipe<T0, T1> {
        let v0 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<PipeKey<T0, T1>>(&arg0.id, v0), 13837876245319122961);
        0x2::dynamic_object_field::borrow_mut<PipeKey<T0, T1>, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::Pipe<T0, T1>>(&mut arg0.id, v0)
    }

    public fun claim_own_redeem_request_after_delay<T0>(arg0: &mut SweetHouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_can_claim_own_redeem_request_after_delay<T0>(arg0, arg1, arg2, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::tx_context::sender(arg3);
        fulfill_redeem_request<T0>(arg0, arg1, v0, true, arg3);
    }

    fun create_house_internal<T0>(arg0: &mut SweetHouse, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 19, 13843223771662909495);
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!house_exists<T0>(arg0), 13835342485196374017);
        let v1 = HouseKey{pos0: v0};
        0x2::dynamic_object_field::add<HouseKey, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::House<T0>>(&mut arg0.id, v1, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::new<T0>(arg1, arg2));
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
        let v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::borrow_pool_from_id<T0>(v0, arg1);
        let v2 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        assert!(!0x2::dynamic_object_field::exists_<PipeKey<T0, T1>>(&arg0.id, v2), 13840972525898956839);
        0x2::dynamic_object_field::add<PipeKey<T0, T1>, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::Pipe<T0, T1>>(&mut arg0.id, v2, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::new_pipe<T0, T1>(v1, arg3));
        emit_pipe_created_event<T0, T1>(arg1, arg2);
    }

    fun create_whitelist_pool_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::create_whitelist_pool<T0>(v0, arg1, arg2);
        let (v1, _, _, _, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::whitelist_pool_values_at<T0>(v0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::whitelist_pools_len<T0>(v0) - 1);
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
        assert!(arg0.current_epoch_loss_debit_total <= arg0.current_epoch_loss_credit_total || arg0.current_epoch_loss_debit_total - arg0.current_epoch_loss_credit_total <= (arg0.daily_loss_limit as u128), 13840411762083627043);
    }

    fun debit_current_epoch_loss_for_operator<T0, T1: drop>(arg0: &mut SweetHouse, arg1: u64) {
        let v0 = borrow_operator_stake_config_mut<T0, T1>(arg0);
        debit_current_epoch_loss<T0>(v0, arg1);
    }

    fun delete_empty_whitelist_pool_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::delete_empty_whitelist_pool<T0>(borrow_house_mut<T0>(arg0), arg1, arg2);
    }

    fun delete_pipe_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) {
        assert_valid_version(arg0);
        let v0 = borrow_pipe_mut<T0, T1>(arg0, arg1, arg2);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::get_balance_value<T0, T1>(v0) == 0, 13838439379956400149);
        let v1 = PipeKey<T0, T1>{
            pool_id : *arg1,
            pond_id : *arg2,
        };
        emit_pipe_deleted_event<T0, T1>(arg1, arg2);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::destroy<T0, T1>(0x2::dynamic_object_field::remove<PipeKey<T0, T1>, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::Pipe<T0, T1>>(&mut arg0.id, v1));
    }

    fun delete_whitelist_pool_and_refund_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_house_mut<T0>(arg0);
        delete_empty_whitelist_pool_internal<T0>(arg0, arg1, arg2);
        let v2 = 0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::withdraw_all_whitelist_pool<T0>(v1, arg1), arg2);
        let v3 = WhitelistPoolWithdrawEvent{
            pool_id      : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_whitelist_pool_id<T0>(v1, arg1),
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
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_private_pool<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
        emit_private_pool_deposit_event<T0>(arg0, 0x2::coin::value<T0>(&arg1));
    }

    public fun deposit_public_pool_and_mint_staked_coins<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::StakedCoin<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = borrow_house_mut<T0>(arg0);
        let v2 = (((0x2::balance::value<T0>(&v0) as u128) * (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_public_deposit_fee<T0>(v1) as u128) / 100000) as u64);
        if (v2 > 0) {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_private_pool<T0>(v1, 0x2::balance::split<T0>(&mut v0, v2));
            let v3 = HouseTakeDepositFeeEvent{
                deposit_fee_amount : v2,
                coin_type          : 0x1::type_name::with_defining_ids<T0>(),
                staker             : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<HouseTakeDepositFeeEvent>(v3);
        };
        emit_log_pools_values_event<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::deposit_public_pool<T0>(v1, v0, arg2)
    }

    public fun deposit_rakeback_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>) {
        put_rakeback_pool<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_self_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::deposit_whitelist_pool<T0>(borrow_house_mut<T0>(arg0), v0, v0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_with_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::deposit_whitelist_pool<T0>(borrow_house_mut<T0>(arg0), 0x2::tx_context::sender(arg3), arg2, 0x2::coin::into_balance<T0>(arg1));
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
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836188937351462919);
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
        assert!(house_exists<T0>(arg0), 13835905216106725381);
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
        assert!(arg1 <= 19, 13843223960641470519);
        let v0 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::edit_coin_decimals<T0>(v0, arg1);
        let v1 = HouseCoinDecimalsEditedEvent{
            coin_type              : 0x1::type_name::with_defining_ids<T0>(),
            previous_coin_decimals : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_coin_decimals<T0>(v0),
            new_coin_decimals      : arg1,
        };
        0x2::event::emit<HouseCoinDecimalsEditedEvent>(v1);
    }

    fun edit_operator_stake_config_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: u64, arg2: u64, arg3: u64) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189783460020231);
        let v1 = 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13840130454610509857);
        assert!(arg3 <= 100, 13842100796628271151);
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
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::edit_public_pool_max_capacity<T0>(v0, arg1);
        let v1 = PublicPoolMaxCapacityEditedEvent<T0>{
            previous_max_capacity : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_public_pool_max_capacity<T0>(v0),
            new_max_capacity      : arg1,
        };
        0x2::event::emit<PublicPoolMaxCapacityEditedEvent<T0>>(v1);
    }

    fun edit_whitelist_pool_max_capacity_internal<T0>(arg0: &mut SweetHouse, arg1: address, arg2: u64) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::edit_whitelist_pool_max_capacity<T0>(v0, arg1, arg2);
        let v1 = WhitelistPoolMaxCapacityEditedEvent<T0>{
            owner                 : arg1,
            pool_id               : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_whitelist_pool_id<T0>(v0, arg1),
            previous_max_capacity : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_whitelist_pool_max_capacity<T0>(v0, arg1),
            new_max_capacity      : arg2,
        };
        0x2::event::emit<WhitelistPoolMaxCapacityEditedEvent<T0>>(v1);
    }

    public fun emit_log_pools_values_event<T0>(arg0: &SweetHouse) {
        assert_valid_version(arg0);
        let v0 = borrow_house<T0>(arg0);
        let (v1, v2, v3, v4) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::private_pool_values<T0>(v0);
        let (v5, v6, v7, v8) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::public_pool_values<T0>(v0);
        let (v9, v10, v11, v12) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::rakeback_pool_values<T0>(v0);
        let v13 = 0x1::vector::empty<WhitelistPoolValuesLog>();
        let v14 = 0;
        while (v14 < 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::whitelist_pools_len<T0>(v0)) {
            let (v15, v16, v17, v18, v19) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::whitelist_pool_values_at<T0>(v0, v14);
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
        let (_, v1, v2, v3) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::pool_values<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::borrow_pool_from_id<T0>(borrow_house<T0>(arg0), arg1));
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
        let (_, v1, v2, v3) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::pool_values<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::borrow_pool_from_id<T0>(borrow_house<T0>(arg0), arg1));
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
        let (v0, _, _, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::private_pool_values<T0>(borrow_house<T0>(arg0));
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
        let (v0, _, _, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::rakeback_pool_values<T0>(borrow_house<T0>(arg0));
        let v4 = RakebackPoolDepositEvent<T0>{
            pool_id : v0,
            amount  : arg1,
        };
        0x2::event::emit<RakebackPoolDepositEvent<T0>>(v4);
    }

    fun emit_rakeback_pool_withdraw_event<T0, T1: drop>(arg0: &SweetHouse, arg1: u64) {
        let (v0, _, _, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::rakeback_pool_values<T0>(borrow_house<T0>(arg0));
        let v4 = RakebackPoolWithdrawEvent<T0, T1>{
            pool_id : v0,
            amount  : arg1,
        };
        0x2::event::emit<RakebackPoolWithdrawEvent<T0, T1>>(v4);
    }

    fun enable_operator_config_internal<T0: drop>(arg0: &mut SweetHouse) {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189031840743431);
        0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0).enabled = true;
        let v1 = OperatorConfigEnabledEvent{operator_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<OperatorConfigEnabledEvent>(v1);
    }

    fun fulfill_redeem_request<T0>(arg0: &mut SweetHouse, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = RedeemRequestKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists_<RedeemRequestKey>(&arg0.id, v0), 13838163196379267091);
        let RedeemRequest {
            id             : v1,
            staked_balance : v2,
            created_at     : v3,
            sender         : v4,
        } = 0x2::dynamic_object_field::remove<RedeemRequestKey, RedeemRequest<T0>>(&mut arg0.id, v0);
        let v5 = v2;
        0x2::object::delete(v1);
        let v6 = borrow_house_mut<T0>(arg0);
        let v7 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::redeem_public_pool<T0>(v6, v5, v4);
        let v8 = RedeemRequestFulfilledEvent{
            request_id                             : arg1,
            player                                 : v4,
            actor                                  : arg2,
            coin_type                              : 0x1::type_name::with_defining_ids<T0>(),
            staked_amount                          : 0x2::balance::value<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::StakedCoin<T0>>(&v5),
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
        assert!(0x2::dynamic_object_field::exists_<DollarTypesKey>(&arg0.id, v0), 13841253403875344425);
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

    public fun manager_add_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        add_operator_stake_config_internal<T0, T1>(arg0, arg2);
    }

    public fun manager_create_house<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        create_house_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_create_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        create_pipe_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun manager_create_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        create_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_delete_empty_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        delete_empty_whitelist_pool_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_delete_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        delete_pipe_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun manager_delete_whitelist_pool_and_refund<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        delete_whitelist_pool_and_refund_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_disable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        disable_operator_config_internal<T0>(arg0);
    }

    public fun manager_edit_dollar_type<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        edit_dollar_type_internal<T0>(arg0, arg2);
    }

    public fun manager_edit_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg5));
        edit_operator_stake_config_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun manager_edit_public_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        edit_public_pool_max_capacity_internal<T0>(arg0, arg2);
    }

    public fun manager_edit_whitelist_pool_max_capacity<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        edit_whitelist_pool_max_capacity_internal<T0>(arg0, arg2, arg3);
    }

    public fun manager_enable_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        enable_operator_config_internal<T0>(arg0);
    }

    public fun manager_fulfill_redeem_request<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::tx_context::sender(arg3);
        fulfill_redeem_request<T0>(arg0, arg2, v0, false, arg3);
    }

    public fun manager_remove_operator_config<T0: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        remove_operator_config_internal<T0>(arg0);
    }

    public fun manager_remove_operator_stake_config<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        remove_operator_stake_config_internal<T0, T1>(arg0);
    }

    public fun manager_remove_version(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        remove_version_internal(arg0, arg2);
    }

    public fun manager_reset_daily_loss_count<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg2));
        reset_daily_loss_count_internal<T0, T1>(arg0, arg2);
    }

    public fun manager_set_house_distribution_mode<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        set_house_distribution_mode<T0>(arg0, arg2);
    }

    public fun manager_set_house_public_deposit_fee<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg3));
        set_house_public_pool_deposit_fee<T0>(arg0, arg2);
    }

    public fun manager_withdraw_private_pool_with_restrictions<T0>(arg0: &mut SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<SweetHouseType>(arg1, 0x2::tx_context::sender(arg4));
        withdraw_private_pool_with_restrictions_internal<T0>(arg0, arg2, arg3, arg4)
    }

    public fun operator_add_operator_df<T0: drop, T1: copy + drop + store, T2: store>(arg0: &mut SweetHouse, arg1: T0, arg2: T1, arg3: T2) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        assert!(!0x2::dynamic_field::exists_<T1>(&arg0.id, arg2), 13839008231195148313);
        0x2::dynamic_field::add<T1, T2>(&mut arg0.id, arg2, arg3);
    }

    public fun operator_add_operator_dof<T0: drop, T1: copy + drop + store, T2: store + key>(arg0: &mut SweetHouse, arg1: T0, arg2: T1, arg3: T2) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T0>(arg0);
        assert!(!0x2::dynamic_object_field::exists_<T1>(&arg0.id, arg2), 13838726700383731735);
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

    public fun operator_fund_rakeback_pool_using_stake_ticket_sources<T0, T1: drop, T2: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T2>, arg3: u64) {
        let v0 = operator_take_using_stake_ticket_sources<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_rakeback_pool<T0>(borrow_house_mut<T0>(arg0), v0);
        let v1 = RakebackPoolFundedEvent<T0, T1>{
            game_type : 0x1::type_name::with_defining_ids<T2>(),
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<RakebackPoolFundedEvent<T0, T1>>(v1);
    }

    public fun operator_put_and_get_stake_ticket<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1> {
        put_and_get_stake_ticket_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    public fun operator_put_into_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &T1, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: 0x2::balance::Balance<T0>) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = borrow_pipe_mut<T0, T1>(arg0, arg2, arg3);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::get_balance_value<T0, T1>(v1);
        let v3 = if (v0 > v2) {
            v2
        } else {
            v0
        };
        let v4 = if (v3 == 0) {
            0x2::balance::zero<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::PoolDebt<T0>>()
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::take_debt<T0, T1>(v1, v3)
        };
        let v5 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::get_balance_value<T0, T1>(v1);
        let v6 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_into_pool_for_pipe<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::borrow_pool_mut_from_id<T0>(v6, arg2), arg4, v4);
        emit_pipe_liquidity_returned_event<T0, T1>(arg0, arg2, arg3, v0, v3, v5);
    }

    public fun operator_put_private_pool_and_get_stake_ticket<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        put_private_pool_and_get_stake_ticket_internal<T0, T1>(arg0, arg2, 0x2::coin::value<T0>(&arg2), arg3, arg4, arg5)
    }

    public fun operator_put_private_pool_and_get_stake_ticket_with_stake_amount<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        put_private_pool_and_get_stake_ticket_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun operator_put_rakeback_pool<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0x2::balance::Balance<T0>) {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        put_rakeback_pool<T0>(arg0, arg2);
    }

    public fun operator_stake_config_exists<T0, T1: drop>(arg0: &SweetHouse) : bool {
        assert_valid_version(arg0);
        let v0 = OperatorKey{pos0: 0x1::type_name::with_defining_ids<T1>()};
        if (!0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0)) {
            return false
        };
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&0x2::dynamic_object_field::borrow<OperatorKey, OperatorConfig>(&arg0.id, v0).id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun operator_take_and_destroy_stake_ticket<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::take_using_stake_ticket_sources<T0, T1>(v0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::utils::sum(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_outcome_amounts<T0, T1>(&arg2)), &arg2);
        assert_operator_config_enabled<T1>(arg0);
        debit_current_epoch_loss_for_operator<T0, T1>(arg0, 0x2::balance::value<T0>(&v1));
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::destroy_stake_ticket<T0, T1>(arg2, arg3, arg4);
        emit_log_pools_values_event<T0>(arg0);
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    public fun operator_take_from_pipe<T0, T1: drop>(arg0: &mut SweetHouse, arg1: &T1, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: u64) : 0x2::balance::Balance<T0> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let (v1, v2) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::take_from_pool_for_pipe<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::borrow_pool_mut_from_id<T0>(v0, arg2), arg4);
        let v3 = borrow_pipe_mut<T0, T1>(arg0, arg2, arg3);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::put_debt<T0, T1>(v3, v2);
        emit_pipe_liquidity_borrowed_event<T0, T1>(arg0, arg2, arg3, arg4, arg4, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::get_balance_value<T0, T1>(v3));
        v1
    }

    public fun operator_take_from_rakeback_pool<T0, T1: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        emit_rakeback_pool_withdraw_event<T0, T1>(arg0, arg2);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::take_rakeback_pool<T0>(v0, arg2)
    }

    public fun operator_take_using_stake_ticket_sources<T0, T1: drop, T2: drop>(arg0: &mut SweetHouse, arg1: T1, arg2: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T2>, arg3: u64) : 0x2::balance::Balance<T0> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::take_using_stake_ticket_sources<T0, T2>(borrow_house_mut<T0>(arg0), arg3, arg2)
    }

    fun package_version() : u64 {
        0
    }

    public fun pipe_debt_value<T0, T1: drop>(arg0: &SweetHouse, arg1: &0x2::object::ID, arg2: &0x2::object::ID) : u64 {
        assert_valid_version(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::pipe::get_balance_value<T0, T1>(borrow_pipe<T0, T1>(arg0, arg1, arg2))
    }

    fun put_and_get_stake_ticket_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1> {
        assert_valid_version(arg0);
        assert_operator_config_enabled<T1>(arg0);
        assert_nonzero_number_of_operations(arg2);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (v2, v3) = reset_and_credit_current_epoch_loss_for_operator<T0, T1>(arg0, v1, arg4);
        let v4 = borrow_house_mut<T0>(arg0);
        let v5 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_distribution_type<T0>(v4);
        let v6 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_distribution_weights<T0>(v4);
        if (v5 == 0) {
            abort 13836754687623692297
        };
        let (v7, v8, v9) = if (v5 == 1) {
            let v10 = &mut v0;
            let (v11, v12, v13) = split_distribution_weighted_by_pool<T0>(v10, v1, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_private_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_public_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_whitelist_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_private_pool_balance<T0>(v4), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_public_pool_balance<T0>(v4), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_whitelist_pools_balance<T0>(v4));
            let v8 = v13;
            let v7 = v11;
            (v7, v8, v12)
        } else if (v5 == 2) {
            let v14 = &mut v0;
            let (v15, v16, v17) = split_distribution_private_cap_per_bet<T0>(v14, v1, arg2, v1 / arg2, v2, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_private_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_public_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_whitelist_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_private_pool_balance<T0>(v4), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_public_pool_balance<T0>(v4), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_whitelist_pools_balance<T0>(v4));
            let v8 = v17;
            let v7 = v15;
            (v7, v8, v16)
        } else {
            assert!(v5 == 3, 13837036373053931531);
            let v18 = &mut v0;
            let (v19, v20, v21) = split_distribution_fixed_private_share<T0>(v18, v1, v3, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_public_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_whitelist_weight(&v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_public_pool_balance<T0>(v4), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::total_whitelist_pools_balance<T0>(v4));
            let v8 = v21;
            let v7 = v19;
            (v7, v8, v20)
        };
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_private_pool<T0>(v4, v7);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_public_pool<T0>(v4, v8);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::join_private_pool<T0>(v4, v0);
        let v22 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::create_stake_ticket<T0, T1>(v1, arg3, arg2);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::set_source_provenance<T0, T1>(&mut v22, 0x2::balance::value<T0>(&v7) + 0x2::balance::value<T0>(&v0), 0x2::balance::value<T0>(&v8), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_whitelist_pools<T0>(v4, v9));
        v22
    }

    fun put_private_pool_and_get_stake_ticket_internal<T0, T1: drop>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1> {
        assert_nonzero_number_of_operations(arg3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (_, _) = reset_and_credit_current_epoch_loss_for_operator<T0, T1>(arg0, v0, arg5);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::put_private_pool<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::create_stake_ticket<T0, T1>(arg2, arg4, arg3);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::set_source_provenance<T0, T1>(&mut v3, v0, 0, 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::WhitelistPoolSourceShare>());
        v3
    }

    public fun redeem_request<T0>(arg0: &mut SweetHouse, arg1: 0x2::coin::Coin<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::StakedCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg0);
        let v0 = 0x2::coin::value<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::StakedCoin<T0>>(&arg1);
        assert!(v0 > 0, 13837600113281597455);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = RedeemRequest<T0>{
            id             : v1,
            staked_balance : 0x2::coin::into_balance<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::StakedCoin<T0>>(arg1),
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
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836188842862182407);
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
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189293833748487);
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
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13839282825634381851);
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
        assert!(0x2::dynamic_object_field::exists_<OperatorKey>(&arg0.id, v0), 13836189959553679367);
        let v1 = 0x2::dynamic_object_field::borrow_mut<OperatorKey, OperatorConfig>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&v1.id, v2), 13840130630704168993);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, OperatorStakeConfig<T0>>(&mut v1.id, v2);
        v3.current_epoch_loss_count = 0;
        v3.current_epoch_loss_credit_total = 0;
        v3.current_epoch_loss_debit_total = 0;
        v3.last_epoch_reset = 0x2::tx_context::epoch(arg1);
    }

    fun set_house_distribution_mode<T0>(arg0: &mut SweetHouse, arg1: u8) {
        let v0 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::set_distribution_mode<T0>(v0, arg1);
        let v1 = HouseDistributionModeEditedEvent<T0>{
            previous_distribution_mode : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_distribution_type<T0>(v0),
            new_distribution_mode      : arg1,
        };
        0x2::event::emit<HouseDistributionModeEditedEvent<T0>>(v1);
    }

    fun set_house_public_pool_deposit_fee<T0>(arg0: &mut SweetHouse, arg1: u64) {
        assert!(arg1 <= 10000, 13837316512295944205);
        let v0 = borrow_house_mut<T0>(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::set_public_deposit_fee<T0>(v0, arg1);
        let v1 = PublicPoolDepositFeeEditedEvent<T0>{
            previous_public_deposit_fee : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_public_deposit_fee<T0>(v0),
            new_public_deposit_fee      : arg1,
        };
        0x2::event::emit<PublicPoolDepositFeeEditedEvent<T0>>(v1);
    }

    fun split_distribution_fixed_private_share<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(arg2 <= 100, 13842102398651072559);
        let v0 = (((arg1 as u128) * (arg2 as u128) / 100) as u64);
        let v1 = arg1 - v0;
        if (v1 == 0) {
            (0x2::balance::split<T0>(arg0, v0), 0x2::balance::zero<T0>(), 0x2::balance::zero<T0>())
        } else {
            let v5 = (arg4 as u128) * (arg6 as u128) + (arg3 as u128) * (arg5 as u128);
            assert!(v5 > 0, 13840695088191373349);
            let v6 = (((v1 as u128) * (arg6 as u128) * (arg4 as u128) / v5) as u64);
            (0x2::balance::split<T0>(arg0, v0), 0x2::balance::split<T0>(arg0, v6), 0x2::balance::split<T0>(arg0, arg1 - v0 - v6))
        }
    }

    fun split_distribution_private_cap_per_bet<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        if (arg3 <= arg4) {
            (0x2::balance::split<T0>(arg0, arg1), 0x2::balance::zero<T0>(), 0x2::balance::zero<T0>())
        } else {
            let v3 = arg4 * arg2;
            let v4 = arg1 - v3;
            let v5 = (arg7 as u128) * (arg10 as u128) + (arg6 as u128) * (arg9 as u128);
            assert!(v5 > 0, 13840694912097714213);
            let v6 = (((v4 as u128) * (arg10 as u128) * (arg7 as u128) / v5) as u64);
            (0x2::balance::split<T0>(arg0, v3), 0x2::balance::split<T0>(arg0, v6), 0x2::balance::split<T0>(arg0, v4 - v6))
        }
    }

    fun split_distribution_weighted_by_pool<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let v0 = (arg2 as u128) * (arg5 as u128) + (arg3 as u128) * (arg6 as u128) + (arg4 as u128) * (arg7 as u128);
        assert!(v0 > 0, 13840694727414120485);
        let v1 = (((arg1 as u128) * (arg2 as u128) * (arg5 as u128) / v0) as u64);
        let v2 = (((arg1 as u128) * (arg4 as u128) * (arg7 as u128) / v0) as u64);
        (0x2::balance::split<T0>(arg0, v1), 0x2::balance::split<T0>(arg0, v2), 0x2::balance::split<T0>(arg0, arg1 - v1 - v2))
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
        let v1 = 0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::withdraw_private_pool<T0>(v0, arg1), arg2);
        emit_private_pool_withdraw_event<T0>(0x2::tx_context::sender(arg2), &v1, 0x1::type_name::with_defining_ids<T0>(), false, false);
        emit_log_pools_values_event<T0>(arg0);
        v1
    }

    fun withdraw_private_pool_with_restrictions_internal<T0>(arg0: &mut SweetHouse, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = borrow_house_mut<T0>(arg0);
        let v1 = 0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::withdraw_private_pool_with_daily_withdrawal_limit<T0>(v0, arg1, arg2), arg3);
        emit_private_pool_withdraw_event<T0>(0x2::tx_context::sender(arg3), &v1, 0x1::type_name::with_defining_ids<T0>(), true, false);
        emit_log_pools_values_event<T0>(arg0);
        v1
    }

    public fun withdraw_self_whitelist_pool<T0>(arg0: &mut SweetHouse, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_house_mut<T0>(arg0);
        let v2 = 0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::withdraw_whitelist_pool<T0>(v1, v0, arg1), arg2);
        let v3 = WhitelistPoolWithdrawEvent{
            pool_id      : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house::get_whitelist_pool_id<T0>(v1, v0),
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

