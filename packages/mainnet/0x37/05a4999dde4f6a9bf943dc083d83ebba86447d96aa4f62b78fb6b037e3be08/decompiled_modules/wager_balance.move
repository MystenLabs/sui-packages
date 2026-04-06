module 0x3705a4999dde4f6a9bf943dc083d83ebba86447d96aa4f62b78fb6b037e3be08::wager_balance {
    struct WagerBalance has copy, drop, store {
        dummy_field: bool,
    }

    struct WagerBalanceGiveBalancePermission has copy, drop, store {
        dummy_field: bool,
    }

    struct WagerBalanceRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NewUserBonusConfig has copy, drop, store {
        wager_trigger_usd: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct WagerBalanceRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_enabled: bool,
        is_new_user_bonus_enabled: bool,
        new_user_bonus_configs: vector<NewUserBonusConfig>,
        daily_usd_wager_usd_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        daily_usd_wager_coin_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        daily_coin_wager_coin_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        daily_coin_wager_usd_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        current_epoch_usd_wager_usd_ratio_count: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        current_epoch_usd_wager_coin_ratio_count: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        current_epoch_coin_wager_coin_ratio_count: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        current_epoch_coin_wager_usd_ratio_count: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        last_epoch_reset: u64,
        stakers_contribution_to_rakeback_pool: u64,
    }

    struct UserWagerBalanceKey has copy, drop, store {
        pos0: address,
    }

    struct UserWagerBalanceData has store, key {
        id: 0x2::object::UID,
        has_claimed_new_user_bonus: bool,
        usd_wager_usd_balances: vector<USDWagerUSDBalance>,
    }

    struct CoinBalanceData<phantom T0> has store, key {
        id: 0x2::object::UID,
        usd_wager_coin_balances: vector<USDWagerCoinBalance<T0>>,
        coin_wager_coin_balances: vector<CoinWagerCoinBalance<T0>>,
        coin_wager_usd_balances: vector<CoinWagerUSDBalance<T0>>,
    }

    struct CoinBalanceKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct USDWagerUSDBalance has store, key {
        id: 0x2::object::UID,
        is_claimable: bool,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_balance: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct USDWagerCoinBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_claimable: bool,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        coin_balance: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerCoinBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_claimable: bool,
        wager_trigger: u64,
        total_wager: u128,
        coin_balance: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerUSDBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_claimable: bool,
        wager_trigger: u64,
        total_wager: u128,
        usd_balance: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct WagerBalanceRegistryEditedEvent has copy, drop {
        is_enabled: bool,
        is_new_user_bonus_enabled: bool,
        daily_usd_wager_usd_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        daily_usd_wager_coin_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        daily_coin_wager_coin_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        daily_coin_wager_usd_ratio_limit: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        stakers_contribution_to_rakeback_pool: u64,
    }

    struct WagerBalanceRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        is_enabled: bool,
        is_new_user_bonus_enabled: bool,
        stakers_contribution_to_rakeback_pool: u64,
    }

    struct WagerBalanceRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct GiveBalanceRatioCountersResetEvent has copy, drop {
        registry_id: 0x2::object::ID,
        epoch: u64,
    }

    struct NewUserBonusConfigUpsertedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        bonus_index: u64,
        wager_trigger_usd: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        is_new: bool,
    }

    struct NewUserBonusConfigRemovedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        bonus_index: u64,
        wager_trigger_usd: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct USDWagerUSDBalanceCreatedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct USDWagerCoinBalanceCreatedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        coin_reward: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerCoinBalanceCreatedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        wager_trigger: u64,
        coin_reward: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerUSDBalanceCreatedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        wager_trigger: u64,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct USDWagerUSDBalanceProgressEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        new_total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        old_total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct USDWagerCoinBalanceProgressEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        new_total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        old_total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct CoinWagerCoinBalanceProgressEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        new_total_wager: u128,
        old_total_wager: u128,
    }

    struct CoinWagerUSDBalanceProgressEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        new_total_wager: u128,
        old_total_wager: u128,
    }

    struct USDWagerUSDBalanceCompletedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct USDWagerCoinBalanceCompletedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        coin_reward: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerCoinBalanceCompletedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        wager_trigger: u64,
        coin_reward: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerUSDBalanceCompletedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        wager_trigger: u64,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct USDWagerUSDBalanceClaimedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        dollar_coin_payout: u64,
        dollar_coin_type_name: 0x1::type_name::TypeName,
        dollar_coin_decimals: u8,
        stablecoin_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        stablecoin_confidence: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        payout_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct USDWagerCoinBalanceClaimedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        coin_reward: u64,
    }

    struct CoinWagerCoinBalanceClaimedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        coin_reward: u64,
    }

    struct CoinWagerUSDBalanceClaimedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        dollar_coin_payout: u64,
        dollar_coin_type_name: 0x1::type_name::TypeName,
        dollar_coin_decimals: u8,
        stablecoin_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        stablecoin_confidence: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        payout_price: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct NewUserBonusClaimedEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        bonus_index: u64,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct USDWagerUSDBalanceExpiredEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct USDWagerCoinBalanceExpiredEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        wager_trigger: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        total_wager: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        coin_reward: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerCoinBalanceExpiredEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        wager_trigger: u64,
        total_wager: u128,
        coin_reward: u64,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CoinWagerUSDBalanceExpiredEvent has copy, drop {
        balance_id: 0x2::object::ID,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        wager_trigger: u64,
        total_wager: u128,
        usd_reward: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        deadline_timestamp_ms: 0x1::option::Option<u64>,
    }

    fun add_new_user_bonus_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) {
        assert_valid_new_user_bonus_config(&arg1, &arg2);
        let v0 = borrow_wager_balance_registry_mut(arg0);
        let v1 = NewUserBonusConfig{
            wager_trigger_usd : arg1,
            usd_reward        : arg2,
        };
        0x1::vector::push_back<NewUserBonusConfig>(&mut v0.new_user_bonus_configs, v1);
        emit_new_user_bonus_config_upserted_event(v0, 0x1::vector::length<NewUserBonusConfig>(&v0.new_user_bonus_configs), arg1, arg2, true);
    }

    public fun admin_add_new_user_bonus(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) {
        add_new_user_bonus_internal(arg0, arg2, arg3);
    }

    public fun admin_add_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_wager_balance_registry_mut_unchecked(arg0);
        if (!0x2::vec_set::contains<u64>(&v0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v0.version_set, arg2);
            let v1 = WagerBalanceRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<WagerBalanceRegistryVersionChangedEvent>(v1);
        };
    }

    public fun admin_create_coin_wager_coin_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_coin_wager_coin_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun admin_create_coin_wager_usd_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: u64, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_coin_wager_usd_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun admin_create_usd_wager_coin_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_usd_wager_coin_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun admin_create_usd_wager_usd_balance(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_usd_wager_usd_balance_internal(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun admin_create_wager_balance_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_wager_balance_registry_internal(arg0, arg2);
    }

    public fun admin_edit_new_user_bonus(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) {
        edit_new_user_bonus_internal(arg0, arg2, arg3, arg4);
    }

    public fun admin_edit_wager_balance_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: bool, arg3: bool, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg6: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg7: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg8: u64) {
        edit_wager_balance_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun admin_remove_new_user_bonus(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        remove_new_user_bonus_internal(arg0, arg2);
    }

    public fun admin_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_wager_balance_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun admin_reset_give_balance_ratio_counters(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &0x2::tx_context::TxContext) {
        reset_give_balance_ratio_counters_internal(arg0, arg2);
    }

    fun assert_balance_type_limit_not_reached<T0>(arg0: &vector<T0>) {
        assert!(0x1::vector::length<T0>(arg0) < 100, 13844630777179406393);
    }

    fun assert_valid_new_user_bonus_config(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive(arg0), 13842378900055261225);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(arg1), 13842378908645195817);
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(*arg1, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(100));
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::lt(&v0, arg0), 13842097450848223271);
    }

    fun assert_valid_new_user_bonus_index(arg0: &WagerBalanceRegistry, arg1: u64) {
        let v0 = 0x1::vector::length<NewUserBonusConfig>(&arg0.new_user_bonus_configs);
        assert!(v0 > 0, 13844067797160951861);
        assert!(arg1 < v0, 13844349276432760887);
    }

    fun assert_valid_version(arg0: &WagerBalanceRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13843504314631323697);
    }

    fun borrow_coin_balance_data_mut<T0>(arg0: &mut UserWagerBalanceData) : &mut CoinBalanceData<T0> {
        0x2::dynamic_object_field::borrow_mut<CoinBalanceKey, CoinBalanceData<T0>>(&mut arg0.id, coin_balance_key<T0>())
    }

    public fun borrow_user_wager_balance_data(arg0: &WagerBalanceRegistry, arg1: address) : &UserWagerBalanceData {
        assert_valid_version(arg0);
        let v0 = UserWagerBalanceKey{pos0: arg1};
        0x2::dynamic_object_field::borrow<UserWagerBalanceKey, UserWagerBalanceData>(&arg0.id, v0)
    }

    fun borrow_user_wager_balance_data_mut(arg0: &mut WagerBalanceRegistry, arg1: address) : &mut UserWagerBalanceData {
        let v0 = UserWagerBalanceKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<UserWagerBalanceKey, UserWagerBalanceData>(&mut arg0.id, v0)
    }

    public fun borrow_wager_balance_registry(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &WagerBalanceRegistry {
        let v0 = borrow_wager_balance_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_wager_balance_registry_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut WagerBalanceRegistry {
        let v0 = borrow_wager_balance_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_wager_balance_registry_mut_unchecked(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut WagerBalanceRegistry {
        let v0 = WagerBalance{dummy_field: false};
        let v1 = WagerBalanceRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<WagerBalance, WagerBalanceRegistryKey, WagerBalanceRegistry>(arg0, v0, v1)
    }

    fun borrow_wager_balance_registry_unchecked(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &WagerBalanceRegistry {
        let v0 = WagerBalanceRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<WagerBalance, WagerBalanceRegistryKey, WagerBalanceRegistry>(arg0, v0)
    }

    public fun claim_coin_wager_coin_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_wager_balance_registry_mut(arg0);
        assert!(v1.is_enabled, 13836191050475241477);
        let v2 = UserWagerBalanceKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<UserWagerBalanceKey>(&v1.id, v2), 13837035488290537481);
        let v3 = borrow_user_wager_balance_data_mut(v1, v0);
        assert!(coin_balance_data_exists<T0>(v3), 13837316976152281099);
        let v4 = borrow_coin_balance_data_mut<T0>(v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<CoinWagerCoinBalance<T0>>(&v4.coin_wager_coin_balances)) {
            if (0x2::object::uid_to_inner(&0x1::vector::borrow<CoinWagerCoinBalance<T0>>(&v4.coin_wager_coin_balances, v5).id) == arg1) {
                break
            };
            v5 = v5 + 1;
        };
        assert!(v5 < 0x1::vector::length<CoinWagerCoinBalance<T0>>(&v4.coin_wager_coin_balances), 13839287361119322131);
        let v6 = 0x1::vector::borrow<CoinWagerCoinBalance<T0>>(&v4.coin_wager_coin_balances, v5);
        let v7 = v6.coin_balance;
        assert!(v6.is_claimable, 13835909691462516739);
        let v8 = WagerBalance{dummy_field: false};
        let v9 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, WagerBalance>(arg0, v8, v7);
        let v10 = CoinWagerCoinBalanceClaimedEvent{
            balance_id  : 0x2::object::uid_to_inner(&v6.id),
            player      : v0,
            coin_type   : 0x1::type_name::with_defining_ids<T0>(),
            coin_reward : v7,
        };
        0x2::event::emit<CoinWagerCoinBalanceClaimedEvent>(v10);
        let v11 = borrow_wager_balance_registry_mut(arg0);
        let v12 = borrow_user_wager_balance_data_mut(v11, v0);
        destroy_empty_coin_wager_coin_balance<T0>(0x1::vector::remove<CoinWagerCoinBalance<T0>>(&mut borrow_coin_balance_data_mut<T0>(v12).coin_wager_coin_balances, v5));
        0x2::coin::from_balance<T0>(v9, arg2)
    }

    public fun claim_coin_wager_usd_balance<T0, T1>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x2::object::ID, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_coin_decimals<T0>(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0) == v2, 13836472804624957447);
        let v3 = borrow_wager_balance_registry_mut(arg0);
        assert!(v3.is_enabled, 13836191346827984901);
        let v4 = UserWagerBalanceKey{pos0: v1};
        assert!(0x2::dynamic_object_field::exists_<UserWagerBalanceKey>(&v3.id, v4), 13837035784643280905);
        let v5 = borrow_user_wager_balance_data_mut(v3, v1);
        assert!(coin_balance_data_exists<T1>(v5), 13837317272505024523);
        let v6 = borrow_coin_balance_data_mut<T1>(v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<CoinWagerUSDBalance<T1>>(&v6.coin_wager_usd_balances)) {
            if (0x2::object::uid_to_inner(&0x1::vector::borrow<CoinWagerUSDBalance<T1>>(&v6.coin_wager_usd_balances, v7).id) == arg1) {
                break
            };
            v7 = v7 + 1;
        };
        assert!(v7 < 0x1::vector::length<CoinWagerUSDBalance<T1>>(&v6.coin_wager_usd_balances), 13839569132448907285);
        let v8 = 0x1::vector::borrow<CoinWagerUSDBalance<T1>>(&v6.coin_wager_usd_balances, v7);
        let v9 = v8.usd_balance;
        assert!(v8.is_claimable, 13835909987815260163);
        let (v10, v11, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::get_checked_usd_price(arg0, v2, arg2, arg3);
        let v13 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::price_upper_bound(v10, v11);
        let v14 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::floor_to_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(v9, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::math::pow_u64(10, (v0 as u64)))), v13));
        let v15 = WagerBalance{dummy_field: false};
        let v16 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, WagerBalance>(arg0, v15, v14);
        let v17 = CoinWagerUSDBalanceClaimedEvent{
            balance_id            : 0x2::object::uid_to_inner(&v8.id),
            player                : v1,
            usd_reward            : v9,
            dollar_coin_payout    : v14,
            dollar_coin_type_name : v2,
            dollar_coin_decimals  : v0,
            stablecoin_price      : v10,
            stablecoin_confidence : v11,
            payout_price          : v13,
        };
        0x2::event::emit<CoinWagerUSDBalanceClaimedEvent>(v17);
        let v18 = borrow_wager_balance_registry_mut(arg0);
        let v19 = borrow_user_wager_balance_data_mut(v18, v1);
        destroy_empty_coin_wager_usd_balance<T1>(0x1::vector::remove<CoinWagerUSDBalance<T1>>(&mut borrow_coin_balance_data_mut<T1>(v19).coin_wager_usd_balances, v7));
        0x2::coin::from_balance<T0>(v16, arg4)
    }

    entry fun claim_new_user_bonus_wager_balance(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        claim_new_user_bonus_wager_balance_internal(arg0, arg1, arg2);
    }

    fun claim_new_user_bonus_wager_balance_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_wager_balance_registry_mut(arg0);
        assert!(v1.is_enabled, 13836191677540466693);
        assert!(v1.is_new_user_bonus_enabled, 13840976756441219103);
        assert_valid_new_user_bonus_index(v1, arg1);
        let v2 = 0x1::vector::borrow<NewUserBonusConfig>(&v1.new_user_bonus_configs, arg1);
        let v3 = v2.wager_trigger_usd;
        let v4 = v2.usd_reward;
        let v3 = v3;
        consume_usd_wager_usd_ratio_limit(v1, &v3, &v4, arg2);
        create_user_wager_balance_data_if_not_exists(v1, v0, arg2);
        let v5 = borrow_user_wager_balance_data_mut(v1, v0);
        assert!(!v5.has_claimed_new_user_bonus, 13835347308444647425);
        assert_balance_type_limit_not_reached<USDWagerUSDBalance>(&v5.usd_wager_usd_balances);
        let v6 = USDWagerUSDBalance{
            id                    : 0x2::object::new(arg2),
            is_claimable          : false,
            wager_trigger         : v3,
            total_wager           : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            usd_balance           : v4,
            deadline_timestamp_ms : 0x1::option::none<u64>(),
        };
        let v7 = NewUserBonusClaimedEvent{
            balance_id    : 0x2::object::uid_to_inner(&v6.id),
            player        : v0,
            bonus_index   : arg1,
            wager_trigger : v3,
            usd_reward    : v4,
        };
        0x2::event::emit<NewUserBonusClaimedEvent>(v7);
        0x1::vector::push_back<USDWagerUSDBalance>(&mut v5.usd_wager_usd_balances, v6);
        v5.has_claimed_new_user_bonus = true;
    }

    public fun claim_usd_wager_coin_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_wager_balance_registry_mut(arg0);
        assert!(v1.is_enabled, 13836190784187269125);
        let v2 = UserWagerBalanceKey{pos0: v0};
        assert!(0x2::dynamic_object_field::exists_<UserWagerBalanceKey>(&v1.id, v2), 13837035222002565129);
        let v3 = borrow_user_wager_balance_data_mut(v1, v0);
        assert!(coin_balance_data_exists<T0>(v3), 13837316709864308747);
        let v4 = borrow_coin_balance_data_mut<T0>(v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<USDWagerCoinBalance<T0>>(&v4.usd_wager_coin_balances)) {
            if (0x2::object::uid_to_inner(&0x1::vector::borrow<USDWagerCoinBalance<T0>>(&v4.usd_wager_coin_balances, v5).id) == arg1) {
                break
            };
            v5 = v5 + 1;
        };
        assert!(v5 < 0x1::vector::length<USDWagerCoinBalance<T0>>(&v4.usd_wager_coin_balances), 13839005619854508049);
        let v6 = 0x1::vector::borrow<USDWagerCoinBalance<T0>>(&v4.usd_wager_coin_balances, v5);
        let v7 = v6.coin_balance;
        assert!(v6.is_claimable, 13835909425174544387);
        let v8 = WagerBalance{dummy_field: false};
        let v9 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, WagerBalance>(arg0, v8, v7);
        let v10 = USDWagerCoinBalanceClaimedEvent{
            balance_id  : 0x2::object::uid_to_inner(&v6.id),
            player      : v0,
            coin_type   : 0x1::type_name::with_defining_ids<T0>(),
            coin_reward : v7,
        };
        0x2::event::emit<USDWagerCoinBalanceClaimedEvent>(v10);
        let v11 = borrow_wager_balance_registry_mut(arg0);
        let v12 = borrow_user_wager_balance_data_mut(v11, v0);
        destroy_empty_usd_wager_coin_balance<T0>(0x1::vector::remove<USDWagerCoinBalance<T0>>(&mut borrow_coin_balance_data_mut<T0>(v12).usd_wager_coin_balances, v5));
        0x2::coin::from_balance<T0>(v9, arg2)
    }

    public fun claim_usd_wager_usd_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x2::object::ID, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_coin_decimals<T0>(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0) == v2, 13836471842552283143);
        let v3 = borrow_wager_balance_registry_mut(arg0);
        assert!(v3.is_enabled, 13836190389050277893);
        let v4 = UserWagerBalanceKey{pos0: v1};
        assert!(0x2::dynamic_object_field::exists_<UserWagerBalanceKey>(&v3.id, v4), 13837034826865573897);
        let v5 = borrow_user_wager_balance_data_mut(v3, v1);
        let v6 = 0;
        while (v6 < 0x1::vector::length<USDWagerUSDBalance>(&v5.usd_wager_usd_balances)) {
            if (0x2::object::uid_to_inner(&0x1::vector::borrow<USDWagerUSDBalance>(&v5.usd_wager_usd_balances, v6).id) == arg1) {
                break
            };
            v6 = v6 + 1;
        };
        assert!(v6 < 0x1::vector::length<USDWagerUSDBalance>(&v5.usd_wager_usd_balances), 13838723736855773199);
        let v7 = 0x1::vector::borrow<USDWagerUSDBalance>(&v5.usd_wager_usd_balances, v6);
        let v8 = v7.usd_balance;
        assert!(v7.is_claimable, 13835909025742585859);
        let (v9, v10, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::get_checked_usd_price(arg0, v2, arg2, arg3);
        let v12 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::price_upper_bound(v9, v10);
        let v13 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::floor_to_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(v8, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::math::pow_u64(10, (v0 as u64)))), v12));
        let v14 = WagerBalance{dummy_field: false};
        let v15 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, WagerBalance>(arg0, v14, v13);
        let v16 = USDWagerUSDBalanceClaimedEvent{
            balance_id            : 0x2::object::uid_to_inner(&v7.id),
            player                : v1,
            usd_reward            : v8,
            dollar_coin_payout    : v13,
            dollar_coin_type_name : v2,
            dollar_coin_decimals  : v0,
            stablecoin_price      : v9,
            stablecoin_confidence : v10,
            payout_price          : v12,
        };
        0x2::event::emit<USDWagerUSDBalanceClaimedEvent>(v16);
        let v17 = borrow_wager_balance_registry_mut(arg0);
        let v18 = borrow_user_wager_balance_data_mut(v17, v1);
        let v19 = 0;
        while (v19 < 0x1::vector::length<USDWagerUSDBalance>(&v18.usd_wager_usd_balances)) {
            if (0x2::object::uid_to_inner(&0x1::vector::borrow<USDWagerUSDBalance>(&v18.usd_wager_usd_balances, v19).id) == arg1) {
                break
            };
            v19 = v19 + 1;
        };
        assert!(v19 < 0x1::vector::length<USDWagerUSDBalance>(&v18.usd_wager_usd_balances), 13838723981668909071);
        destroy_empty_usd_wager_usd_balance(0x1::vector::remove<USDWagerUSDBalance>(&mut v18.usd_wager_usd_balances, v19));
        0x2::coin::from_balance<T0>(v15, arg4)
    }

    fun coin_balance_data_exists<T0>(arg0: &UserWagerBalanceData) : bool {
        0x2::dynamic_object_field::exists_<CoinBalanceKey>(&arg0.id, coin_balance_key<T0>())
    }

    fun coin_balance_key<T0>() : CoinBalanceKey {
        CoinBalanceKey{pos0: 0x1::type_name::with_defining_ids<T0>()}
    }

    fun consume_ratio_limit(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg1: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) {
        if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_zero(&arg1)) {
            return
        };
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(&arg2), 13843223230496505903);
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(*arg0, arg2);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::lte(&v0, &arg1), 13841815864202231845);
        *arg0 = v0;
    }

    fun consume_usd_wager_usd_ratio_limit(arg0: &mut WagerBalanceRegistry, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg2: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: &0x2::tx_context::TxContext) {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive(arg1), 13841534432175063075);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(arg2), 13842941811354239021);
        maybe_reset_give_balance_ratio_counters(arg0, arg3);
        let v0 = &mut arg0.current_epoch_usd_wager_usd_ratio_count;
        consume_ratio_limit(v0, arg0.daily_usd_wager_usd_ratio_limit, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(*arg2, *arg1));
    }

    fun create_coin_wager_coin_balance_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = borrow_wager_balance_registry_mut(arg0);
        assert!(v0.is_enabled, 13836187601616502789);
        assert!(arg2 > 0, 13841535639060873251);
        maybe_reset_give_balance_ratio_counters(v0, arg5);
        let v1 = &mut v0.current_epoch_coin_wager_coin_ratio_count;
        consume_ratio_limit(v1, v0.daily_coin_wager_coin_ratio_limit, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(arg3), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(arg2)));
        create_user_wager_balance_data_if_not_exists(v0, arg1, arg5);
        let v2 = borrow_user_wager_balance_data_mut(v0, arg1);
        ensure_coin_balance_data_if_not_exists<T0>(v2, arg5);
        let v3 = borrow_coin_balance_data_mut<T0>(v2);
        let v4 = CoinWagerCoinBalance<T0>{
            id                    : 0x2::object::new(arg5),
            is_claimable          : false,
            wager_trigger         : arg2,
            total_wager           : 0,
            coin_balance          : arg3,
            deadline_timestamp_ms : arg4,
        };
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        assert_balance_type_limit_not_reached<CoinWagerCoinBalance<T0>>(&v3.coin_wager_coin_balances);
        0x1::vector::push_back<CoinWagerCoinBalance<T0>>(&mut v3.coin_wager_coin_balances, v4);
        let v6 = CoinWagerCoinBalanceCreatedEvent{
            balance_id            : v5,
            player                : arg1,
            coin_type             : 0x1::type_name::with_defining_ids<T0>(),
            wager_trigger         : arg2,
            coin_reward           : arg3,
            deadline_timestamp_ms : arg4,
        };
        0x2::event::emit<CoinWagerCoinBalanceCreatedEvent>(v6);
        v5
    }

    fun create_coin_wager_usd_balance_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: u64, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = borrow_wager_balance_registry_mut(arg0);
        assert!(v0.is_enabled, 13836187803479965701);
        assert!(arg2 > 0, 13841535840924336163);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(&arg3), 13842943220103512109);
        maybe_reset_give_balance_ratio_counters(v0, arg5);
        let v1 = &mut v0.current_epoch_coin_wager_usd_ratio_count;
        consume_ratio_limit(v1, v0.daily_coin_wager_usd_ratio_limit, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(arg3, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(arg2)));
        create_user_wager_balance_data_if_not_exists(v0, arg1, arg5);
        let v2 = borrow_user_wager_balance_data_mut(v0, arg1);
        ensure_coin_balance_data_if_not_exists<T0>(v2, arg5);
        let v3 = borrow_coin_balance_data_mut<T0>(v2);
        let v4 = CoinWagerUSDBalance<T0>{
            id                    : 0x2::object::new(arg5),
            is_claimable          : false,
            wager_trigger         : arg2,
            total_wager           : 0,
            usd_balance           : arg3,
            deadline_timestamp_ms : arg4,
        };
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        assert_balance_type_limit_not_reached<CoinWagerUSDBalance<T0>>(&v3.coin_wager_usd_balances);
        0x1::vector::push_back<CoinWagerUSDBalance<T0>>(&mut v3.coin_wager_usd_balances, v4);
        let v6 = CoinWagerUSDBalanceCreatedEvent{
            balance_id            : v5,
            player                : arg1,
            coin_type             : 0x1::type_name::with_defining_ids<T0>(),
            wager_trigger         : arg2,
            usd_reward            : arg3,
            deadline_timestamp_ms : arg4,
        };
        0x2::event::emit<CoinWagerUSDBalanceCreatedEvent>(v6);
        v5
    }

    fun create_usd_wager_coin_balance_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = borrow_wager_balance_registry_mut(arg0);
        assert!(v0.is_enabled, 13836187399753039877);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive(&arg2), 13841535437197410339);
        maybe_reset_give_balance_ratio_counters(v0, arg5);
        let v1 = &mut v0.current_epoch_usd_wager_coin_ratio_count;
        consume_ratio_limit(v1, v0.daily_usd_wager_coin_ratio_limit, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(arg3), arg2));
        create_user_wager_balance_data_if_not_exists(v0, arg1, arg5);
        let v2 = borrow_user_wager_balance_data_mut(v0, arg1);
        ensure_coin_balance_data_if_not_exists<T0>(v2, arg5);
        let v3 = borrow_coin_balance_data_mut<T0>(v2);
        let v4 = USDWagerCoinBalance<T0>{
            id                    : 0x2::object::new(arg5),
            is_claimable          : false,
            wager_trigger         : arg2,
            total_wager           : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            coin_balance          : arg3,
            deadline_timestamp_ms : arg4,
        };
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        assert_balance_type_limit_not_reached<USDWagerCoinBalance<T0>>(&v3.usd_wager_coin_balances);
        0x1::vector::push_back<USDWagerCoinBalance<T0>>(&mut v3.usd_wager_coin_balances, v4);
        let v6 = USDWagerCoinBalanceCreatedEvent{
            balance_id            : v5,
            player                : arg1,
            coin_type             : 0x1::type_name::with_defining_ids<T0>(),
            wager_trigger         : arg2,
            coin_reward           : arg3,
            deadline_timestamp_ms : arg4,
        };
        0x2::event::emit<USDWagerCoinBalanceCreatedEvent>(v6);
        v5
    }

    fun create_usd_wager_usd_balance_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = borrow_wager_balance_registry_mut(arg0);
        assert!(v0.is_enabled, 13836187227954348037);
        consume_usd_wager_usd_ratio_limit(v0, &arg2, &arg3, arg5);
        create_user_wager_balance_data_if_not_exists(v0, arg1, arg5);
        let v1 = borrow_user_wager_balance_data_mut(v0, arg1);
        let v2 = USDWagerUSDBalance{
            id                    : 0x2::object::new(arg5),
            is_claimable          : false,
            wager_trigger         : arg2,
            total_wager           : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            usd_balance           : arg3,
            deadline_timestamp_ms : arg4,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        assert_balance_type_limit_not_reached<USDWagerUSDBalance>(&v1.usd_wager_usd_balances);
        0x1::vector::push_back<USDWagerUSDBalance>(&mut v1.usd_wager_usd_balances, v2);
        let v4 = USDWagerUSDBalanceCreatedEvent{
            balance_id            : v3,
            player                : arg1,
            wager_trigger         : arg2,
            usd_reward            : arg3,
            deadline_timestamp_ms : arg4,
        };
        0x2::event::emit<USDWagerUSDBalanceCreatedEvent>(v4);
        v3
    }

    fun create_user_wager_balance_data_if_not_exists(arg0: &mut WagerBalanceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UserWagerBalanceKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists_<UserWagerBalanceKey>(&arg0.id, v0)) {
            let v1 = UserWagerBalanceData{
                id                         : 0x2::object::new(arg2),
                has_claimed_new_user_bonus : false,
                usd_wager_usd_balances     : 0x1::vector::empty<USDWagerUSDBalance>(),
            };
            let v2 = UserWagerBalanceKey{pos0: arg1};
            0x2::dynamic_object_field::add<UserWagerBalanceKey, UserWagerBalanceData>(&mut arg0.id, v2, v1);
        };
    }

    fun create_wager_balance_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WagerBalanceRegistry{
            id                                        : 0x2::object::new(arg1),
            version_set                               : 0x2::vec_set::singleton<u64>(0),
            is_enabled                                : true,
            is_new_user_bonus_enabled                 : true,
            new_user_bonus_configs                    : 0x1::vector::empty<NewUserBonusConfig>(),
            daily_usd_wager_usd_ratio_limit           : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            daily_usd_wager_coin_ratio_limit          : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            daily_coin_wager_coin_ratio_limit         : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            daily_coin_wager_usd_ratio_limit          : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            current_epoch_usd_wager_usd_ratio_count   : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            current_epoch_usd_wager_coin_ratio_count  : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            current_epoch_coin_wager_coin_ratio_count : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            current_epoch_coin_wager_usd_ratio_count  : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            last_epoch_reset                          : 0,
            stakers_contribution_to_rakeback_pool     : 1000000,
        };
        let v1 = WagerBalance{dummy_field: false};
        let v2 = WagerBalanceRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<WagerBalance, WagerBalanceRegistryKey, WagerBalanceRegistry>(arg0, v1, v2, v0);
        let v3 = WagerBalanceRegistryCreatedEvent{
            registry_id                           : 0x2::object::id<WagerBalanceRegistry>(&v0),
            is_enabled                            : true,
            is_new_user_bonus_enabled             : true,
            stakers_contribution_to_rakeback_pool : 1000000,
        };
        0x2::event::emit<WagerBalanceRegistryCreatedEvent>(v3);
    }

    fun destroy_empty_coin_wager_coin_balance<T0>(arg0: CoinWagerCoinBalance<T0>) {
        let CoinWagerCoinBalance {
            id                    : v0,
            is_claimable          : v1,
            wager_trigger         : v2,
            total_wager           : v3,
            coin_balance          : _,
            deadline_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v6 = v3 >= (v2 as u128);
        assert!(v1 && v6 || !v1 && !v6, 13840409219462463515);
    }

    fun destroy_empty_coin_wager_usd_balance<T0>(arg0: CoinWagerUSDBalance<T0>) {
        let CoinWagerUSDBalance {
            id                    : v0,
            is_claimable          : v1,
            wager_trigger         : v2,
            total_wager           : v3,
            usd_balance           : _,
            deadline_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v6 = v3 >= (v2 as u128);
        assert!(v1 && v6 || !v1 && !v6, 13840690621424861213);
    }

    fun destroy_empty_usd_wager_coin_balance<T0>(arg0: USDWagerCoinBalance<T0>) {
        let USDWagerCoinBalance {
            id                    : v0,
            is_claimable          : v1,
            wager_trigger         : v2,
            total_wager           : v3,
            coin_balance          : _,
            deadline_timestamp_ms : _,
        } = arg0;
        let v6 = v3;
        let v7 = v2;
        0x2::object::delete(v0);
        let v8 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gte(&v6, &v7);
        assert!(v1 && v8 || !v1 && !v8, 13840127817500065817);
    }

    fun destroy_empty_usd_wager_usd_balance(arg0: USDWagerUSDBalance) {
        let USDWagerUSDBalance {
            id                    : v0,
            is_claimable          : v1,
            wager_trigger         : v2,
            total_wager           : v3,
            usd_balance           : _,
            deadline_timestamp_ms : _,
        } = arg0;
        let v6 = v3;
        let v7 = v2;
        0x2::object::delete(v0);
        let v8 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gte(&v6, &v7);
        assert!(v1 && v8 || !v1 && !v8, 13839846123479891991);
    }

    fun edit_new_user_bonus_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) {
        assert_valid_new_user_bonus_config(&arg2, &arg3);
        let v0 = borrow_wager_balance_registry_mut(arg0);
        assert_valid_new_user_bonus_index(v0, arg1);
        let v1 = NewUserBonusConfig{
            wager_trigger_usd : arg2,
            usd_reward        : arg3,
        };
        *0x1::vector::borrow_mut<NewUserBonusConfig>(&mut v0.new_user_bonus_configs, arg1) = v1;
        emit_new_user_bonus_config_upserted_event(v0, arg1, arg2, arg3, false);
    }

    fun edit_wager_balance_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: bool, arg2: bool, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg6: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg7: u64) {
        assert!(arg7 <= 10000000, 13838440732870574093);
        let v0 = borrow_wager_balance_registry_mut(arg0);
        v0.is_enabled = arg1;
        v0.is_new_user_bonus_enabled = arg2;
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(&arg3), 13842662891882938411);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(&arg4), 13842662896177905707);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(&arg5), 13842662900472873003);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(&arg6), 13842662904767840299);
        v0.daily_usd_wager_usd_ratio_limit = arg3;
        v0.daily_usd_wager_coin_ratio_limit = arg4;
        v0.daily_coin_wager_coin_ratio_limit = arg5;
        v0.daily_coin_wager_usd_ratio_limit = arg6;
        v0.stakers_contribution_to_rakeback_pool = arg7;
        let v1 = WagerBalanceRegistryEditedEvent{
            is_enabled                            : arg1,
            is_new_user_bonus_enabled             : arg2,
            daily_usd_wager_usd_ratio_limit       : arg3,
            daily_usd_wager_coin_ratio_limit      : arg4,
            daily_coin_wager_coin_ratio_limit     : arg5,
            daily_coin_wager_usd_ratio_limit      : arg6,
            stakers_contribution_to_rakeback_pool : arg7,
        };
        0x2::event::emit<WagerBalanceRegistryEditedEvent>(v1);
    }

    fun emit_new_user_bonus_config_removed_event(arg0: &WagerBalanceRegistry, arg1: u64, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) {
        let v0 = NewUserBonusConfigRemovedEvent{
            registry_id       : 0x2::object::uid_to_inner(&arg0.id),
            bonus_index       : arg1,
            wager_trigger_usd : arg2,
            usd_reward        : arg3,
        };
        0x2::event::emit<NewUserBonusConfigRemovedEvent>(v0);
    }

    fun emit_new_user_bonus_config_upserted_event(arg0: &WagerBalanceRegistry, arg1: u64, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: bool) {
        let v0 = NewUserBonusConfigUpsertedEvent{
            registry_id       : 0x2::object::uid_to_inner(&arg0.id),
            bonus_index       : arg1,
            wager_trigger_usd : arg2,
            usd_reward        : arg3,
            is_new            : arg4,
        };
        0x2::event::emit<NewUserBonusConfigUpsertedEvent>(v0);
    }

    fun ensure_coin_balance_data_if_not_exists<T0>(arg0: &mut UserWagerBalanceData, arg1: &mut 0x2::tx_context::TxContext) {
        if (!coin_balance_data_exists<T0>(arg0)) {
            let v0 = CoinBalanceData<T0>{
                id                       : 0x2::object::new(arg1),
                usd_wager_coin_balances  : 0x1::vector::empty<USDWagerCoinBalance<T0>>(),
                coin_wager_coin_balances : 0x1::vector::empty<CoinWagerCoinBalance<T0>>(),
                coin_wager_usd_balances  : 0x1::vector::empty<CoinWagerUSDBalance<T0>>(),
            };
            0x2::dynamic_object_field::add<CoinBalanceKey, CoinBalanceData<T0>>(&mut arg0.id, coin_balance_key<T0>(), v0);
        };
    }

    public fun manager_add_new_user_bonus(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalance>(arg1, 0x2::tx_context::sender(arg4));
        add_new_user_bonus_internal(arg0, arg2, arg3);
    }

    public fun manager_create_coin_wager_coin_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalanceGiveBalancePermission>(arg1, 0x2::tx_context::sender(arg6));
        create_coin_wager_coin_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun manager_create_coin_wager_usd_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: u64, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalanceGiveBalancePermission>(arg1, 0x2::tx_context::sender(arg6));
        create_coin_wager_usd_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun manager_create_usd_wager_coin_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalanceGiveBalancePermission>(arg1, 0x2::tx_context::sender(arg6));
        create_usd_wager_coin_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun manager_create_usd_wager_usd_balance(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalanceGiveBalancePermission>(arg1, 0x2::tx_context::sender(arg6));
        create_usd_wager_usd_balance_internal(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun manager_create_wager_balance_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalance>(arg1, 0x2::tx_context::sender(arg2));
        create_wager_balance_registry_internal(arg0, arg2);
    }

    public fun manager_edit_new_user_bonus(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalance>(arg1, 0x2::tx_context::sender(arg5));
        edit_new_user_bonus_internal(arg0, arg2, arg3, arg4);
    }

    public fun manager_edit_wager_balance_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: bool, arg3: bool, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg6: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg7: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalance>(arg1, 0x2::tx_context::sender(arg9));
        edit_wager_balance_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun manager_remove_new_user_bonus(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalance>(arg1, 0x2::tx_context::sender(arg3));
        remove_new_user_bonus_internal(arg0, arg2);
    }

    public fun manager_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalance>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_wager_balance_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun manager_reset_give_balance_ratio_counters(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<WagerBalance>(arg1, 0x2::tx_context::sender(arg2));
        reset_give_balance_ratio_counters_internal(arg0, arg2);
    }

    fun maybe_reset_give_balance_ratio_counters(arg0: &mut WagerBalanceRegistry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg1);
        if (arg0.last_epoch_reset < v0) {
            arg0.current_epoch_usd_wager_usd_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
            arg0.current_epoch_usd_wager_coin_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
            arg0.current_epoch_coin_wager_coin_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
            arg0.current_epoch_coin_wager_usd_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
            arg0.last_epoch_reset = v0;
        };
    }

    public fun operator_create_coin_wager_coin_balance<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: T1, arg2: address, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_config_exists<T1>(arg0), 13841256779719114785);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::assert_operator_config_enabled<T1>(arg0);
        create_coin_wager_coin_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun operator_create_coin_wager_usd_balance<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: T1, arg2: address, arg3: u64, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_config_exists<T1>(arg0), 13841256839848656929);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::assert_operator_config_enabled<T1>(arg0);
        create_coin_wager_usd_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun operator_create_usd_wager_coin_balance<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: T1, arg2: address, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_config_exists<T1>(arg0), 13841256719589572641);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::assert_operator_config_enabled<T1>(arg0);
        create_usd_wager_coin_balance_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun operator_create_usd_wager_usd_balance<T0: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: T0, arg2: address, arg3: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg4: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_config_exists<T0>(arg0), 13841256659460030497);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::assert_operator_config_enabled<T0>(arg0);
        create_usd_wager_usd_balance_internal(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    fun package_version() : u64 {
        0
    }

    fun remove_new_user_bonus_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64) {
        let v0 = borrow_wager_balance_registry_mut(arg0);
        assert_valid_new_user_bonus_index(v0, arg1);
        let v1 = 0x1::vector::remove<NewUserBonusConfig>(&mut v0.new_user_bonus_configs, arg1);
        emit_new_user_bonus_config_removed_event(v0, arg1, v1.wager_trigger_usd, v1.usd_reward);
    }

    fun remove_version_internal(arg0: &mut WagerBalanceRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13843786000061562931);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = WagerBalanceRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<WagerBalanceRegistryVersionChangedEvent>(v0);
    }

    fun reset_give_balance_ratio_counters_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0x2::tx_context::TxContext) {
        let v0 = borrow_wager_balance_registry_mut(arg0);
        v0.current_epoch_usd_wager_usd_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
        v0.current_epoch_usd_wager_coin_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
        v0.current_epoch_coin_wager_coin_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
        v0.current_epoch_coin_wager_usd_ratio_count = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero();
        v0.last_epoch_reset = 0x2::tx_context::epoch(arg1);
        let v1 = GiveBalanceRatioCountersResetEvent{
            registry_id : 0x2::object::id<WagerBalanceRegistry>(v0),
            epoch       : v0.last_epoch_reset,
        };
        0x2::event::emit<GiveBalanceRatioCountersResetEvent>(v1);
    }

    public fun settle_wager_balance<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_player<T0, T1>(arg1);
        let v1 = false;
        let v2 = borrow_wager_balance_registry_mut(arg0);
        if (!v2.is_enabled) {
            return
        };
        let v3 = v2.stakers_contribution_to_rakeback_pool;
        let v4 = UserWagerBalanceKey{pos0: v0};
        if (!0x2::dynamic_object_field::exists_<UserWagerBalanceKey>(&v2.id, v4)) {
            return
        };
        let v5 = borrow_user_wager_balance_data_mut(v2, v0);
        let v6 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_total_stake_usd_value_if_exists<T0, T1>(arg1);
        let v7 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_stake_amount<T0, T1>(arg1);
        let v8 = 0;
        let v9 = 0x1::vector::empty<u64>();
        while (v8 < 0x1::vector::length<USDWagerUSDBalance>(&v5.usd_wager_usd_balances)) {
            let v10 = 0x1::vector::borrow_mut<USDWagerUSDBalance>(&mut v5.usd_wager_usd_balances, v8);
            let v11 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(v10.total_wager, v6);
            let v12 = if (0x1::option::is_some<u64>(&v10.deadline_timestamp_ms)) {
                if (!v10.is_claimable) {
                    0x2::clock::timestamp_ms(arg2) > *0x1::option::borrow<u64>(&v10.deadline_timestamp_ms)
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                0x1::vector::push_back<u64>(&mut v9, v8);
            };
            if (!v10.is_claimable && (0x1::option::is_none<u64>(&v10.deadline_timestamp_ms) || 0x2::clock::timestamp_ms(arg2) <= *0x1::option::borrow<u64>(&v10.deadline_timestamp_ms))) {
                if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gt(&v11, &v10.total_wager)) {
                    v1 = true;
                    let v13 = USDWagerUSDBalanceProgressEvent{
                        balance_id      : 0x2::object::uid_to_inner(&v10.id),
                        player          : v0,
                        new_total_wager : v11,
                        old_total_wager : v10.total_wager,
                    };
                    0x2::event::emit<USDWagerUSDBalanceProgressEvent>(v13);
                    v10.total_wager = v11;
                };
                if (!v10.is_claimable && 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gte(&v10.total_wager, &v10.wager_trigger)) {
                    let v14 = USDWagerUSDBalanceCompletedEvent{
                        balance_id            : 0x2::object::uid_to_inner(&v10.id),
                        player                : v0,
                        wager_trigger         : v10.wager_trigger,
                        usd_reward            : v10.usd_balance,
                        deadline_timestamp_ms : v10.deadline_timestamp_ms,
                    };
                    0x2::event::emit<USDWagerUSDBalanceCompletedEvent>(v14);
                    v10.is_claimable = true;
                };
            };
            v8 = v8 + 1;
        };
        while (0x1::vector::length<u64>(&v9) > 0) {
            let v15 = 0x1::vector::remove<USDWagerUSDBalance>(&mut v5.usd_wager_usd_balances, 0x1::vector::pop_back<u64>(&mut v9));
            let v16 = USDWagerUSDBalanceExpiredEvent{
                balance_id            : 0x2::object::uid_to_inner(&v15.id),
                player                : v0,
                wager_trigger         : v15.wager_trigger,
                total_wager           : v15.total_wager,
                usd_reward            : v15.usd_balance,
                deadline_timestamp_ms : v15.deadline_timestamp_ms,
            };
            0x2::event::emit<USDWagerUSDBalanceExpiredEvent>(v16);
            destroy_empty_usd_wager_usd_balance(v15);
        };
        if (coin_balance_data_exists<T0>(v5)) {
            let v17 = borrow_coin_balance_data_mut<T0>(v5);
            let v18 = 0;
            let v19 = 0x1::vector::empty<u64>();
            while (v18 < 0x1::vector::length<USDWagerCoinBalance<T0>>(&v17.usd_wager_coin_balances)) {
                let v20 = 0x1::vector::borrow_mut<USDWagerCoinBalance<T0>>(&mut v17.usd_wager_coin_balances, v18);
                let v21 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(v20.total_wager, v6);
                let v22 = if (0x1::option::is_some<u64>(&v20.deadline_timestamp_ms)) {
                    if (!v20.is_claimable) {
                        0x2::clock::timestamp_ms(arg2) > *0x1::option::borrow<u64>(&v20.deadline_timestamp_ms)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v22) {
                    0x1::vector::push_back<u64>(&mut v19, v18);
                };
                if (!v20.is_claimable && (0x1::option::is_none<u64>(&v20.deadline_timestamp_ms) || 0x2::clock::timestamp_ms(arg2) <= *0x1::option::borrow<u64>(&v20.deadline_timestamp_ms))) {
                    if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gt(&v21, &v20.total_wager)) {
                        v1 = true;
                        let v23 = USDWagerCoinBalanceProgressEvent{
                            balance_id      : 0x2::object::uid_to_inner(&v20.id),
                            player          : v0,
                            new_total_wager : v21,
                            old_total_wager : v20.total_wager,
                        };
                        0x2::event::emit<USDWagerCoinBalanceProgressEvent>(v23);
                        v20.total_wager = v21;
                    };
                    if (!v20.is_claimable && 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::gte(&v20.total_wager, &v20.wager_trigger)) {
                        let v24 = USDWagerCoinBalanceCompletedEvent{
                            balance_id            : 0x2::object::uid_to_inner(&v20.id),
                            player                : v0,
                            wager_trigger         : v20.wager_trigger,
                            coin_reward           : v20.coin_balance,
                            deadline_timestamp_ms : v20.deadline_timestamp_ms,
                        };
                        0x2::event::emit<USDWagerCoinBalanceCompletedEvent>(v24);
                        v20.is_claimable = true;
                    };
                };
                v18 = v18 + 1;
            };
            while (0x1::vector::length<u64>(&v19) > 0) {
                let v25 = 0x1::vector::remove<USDWagerCoinBalance<T0>>(&mut v17.usd_wager_coin_balances, 0x1::vector::pop_back<u64>(&mut v19));
                let v26 = USDWagerCoinBalanceExpiredEvent{
                    balance_id            : 0x2::object::uid_to_inner(&v25.id),
                    player                : v0,
                    coin_type             : 0x1::type_name::with_defining_ids<T0>(),
                    wager_trigger         : v25.wager_trigger,
                    total_wager           : v25.total_wager,
                    coin_reward           : v25.coin_balance,
                    deadline_timestamp_ms : v25.deadline_timestamp_ms,
                };
                0x2::event::emit<USDWagerCoinBalanceExpiredEvent>(v26);
                destroy_empty_usd_wager_coin_balance<T0>(v25);
            };
            let v27 = 0;
            let v28 = 0x1::vector::empty<u64>();
            while (v27 < 0x1::vector::length<CoinWagerCoinBalance<T0>>(&v17.coin_wager_coin_balances)) {
                let v29 = 0x1::vector::borrow_mut<CoinWagerCoinBalance<T0>>(&mut v17.coin_wager_coin_balances, v27);
                let v30 = v29.total_wager + (v7 as u128);
                let v31 = if (0x1::option::is_some<u64>(&v29.deadline_timestamp_ms)) {
                    if (!v29.is_claimable) {
                        0x2::clock::timestamp_ms(arg2) > *0x1::option::borrow<u64>(&v29.deadline_timestamp_ms)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v31) {
                    0x1::vector::push_back<u64>(&mut v28, v27);
                };
                if (!v29.is_claimable && (0x1::option::is_none<u64>(&v29.deadline_timestamp_ms) || 0x2::clock::timestamp_ms(arg2) <= *0x1::option::borrow<u64>(&v29.deadline_timestamp_ms))) {
                    if (v30 > v29.total_wager) {
                        v1 = true;
                        let v32 = CoinWagerCoinBalanceProgressEvent{
                            balance_id      : 0x2::object::uid_to_inner(&v29.id),
                            player          : v0,
                            new_total_wager : v30,
                            old_total_wager : v29.total_wager,
                        };
                        0x2::event::emit<CoinWagerCoinBalanceProgressEvent>(v32);
                        v29.total_wager = v30;
                    };
                    if (!v29.is_claimable && v29.total_wager >= (v29.wager_trigger as u128)) {
                        let v33 = CoinWagerCoinBalanceCompletedEvent{
                            balance_id            : 0x2::object::uid_to_inner(&v29.id),
                            player                : v0,
                            wager_trigger         : v29.wager_trigger,
                            coin_reward           : v29.coin_balance,
                            deadline_timestamp_ms : v29.deadline_timestamp_ms,
                        };
                        0x2::event::emit<CoinWagerCoinBalanceCompletedEvent>(v33);
                        v29.is_claimable = true;
                    };
                };
                v27 = v27 + 1;
            };
            while (0x1::vector::length<u64>(&v28) > 0) {
                let v34 = 0x1::vector::remove<CoinWagerCoinBalance<T0>>(&mut v17.coin_wager_coin_balances, 0x1::vector::pop_back<u64>(&mut v28));
                let v35 = CoinWagerCoinBalanceExpiredEvent{
                    balance_id            : 0x2::object::uid_to_inner(&v34.id),
                    player                : v0,
                    coin_type             : 0x1::type_name::with_defining_ids<T0>(),
                    wager_trigger         : v34.wager_trigger,
                    total_wager           : v34.total_wager,
                    coin_reward           : v34.coin_balance,
                    deadline_timestamp_ms : v34.deadline_timestamp_ms,
                };
                0x2::event::emit<CoinWagerCoinBalanceExpiredEvent>(v35);
                destroy_empty_coin_wager_coin_balance<T0>(v34);
            };
            let v36 = 0;
            let v37 = 0x1::vector::empty<u64>();
            while (v36 < 0x1::vector::length<CoinWagerUSDBalance<T0>>(&v17.coin_wager_usd_balances)) {
                let v38 = 0x1::vector::borrow_mut<CoinWagerUSDBalance<T0>>(&mut v17.coin_wager_usd_balances, v36);
                let v39 = v38.total_wager + (v7 as u128);
                let v40 = if (0x1::option::is_some<u64>(&v38.deadline_timestamp_ms)) {
                    if (!v38.is_claimable) {
                        0x2::clock::timestamp_ms(arg2) > *0x1::option::borrow<u64>(&v38.deadline_timestamp_ms)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v40) {
                    0x1::vector::push_back<u64>(&mut v37, v36);
                };
                if (!v38.is_claimable && (0x1::option::is_none<u64>(&v38.deadline_timestamp_ms) || 0x2::clock::timestamp_ms(arg2) <= *0x1::option::borrow<u64>(&v38.deadline_timestamp_ms))) {
                    if (v39 > v38.total_wager) {
                        v1 = true;
                        let v41 = CoinWagerUSDBalanceProgressEvent{
                            balance_id      : 0x2::object::uid_to_inner(&v38.id),
                            player          : v0,
                            new_total_wager : v39,
                            old_total_wager : v38.total_wager,
                        };
                        0x2::event::emit<CoinWagerUSDBalanceProgressEvent>(v41);
                        v38.total_wager = v39;
                    };
                    if (!v38.is_claimable && v38.total_wager >= (v38.wager_trigger as u128)) {
                        let v42 = CoinWagerUSDBalanceCompletedEvent{
                            balance_id            : 0x2::object::uid_to_inner(&v38.id),
                            player                : v0,
                            wager_trigger         : v38.wager_trigger,
                            usd_reward            : v38.usd_balance,
                            deadline_timestamp_ms : v38.deadline_timestamp_ms,
                        };
                        0x2::event::emit<CoinWagerUSDBalanceCompletedEvent>(v42);
                        v38.is_claimable = true;
                    };
                };
                v36 = v36 + 1;
            };
            while (0x1::vector::length<u64>(&v37) > 0) {
                let v43 = 0x1::vector::remove<CoinWagerUSDBalance<T0>>(&mut v17.coin_wager_usd_balances, 0x1::vector::pop_back<u64>(&mut v37));
                let v44 = CoinWagerUSDBalanceExpiredEvent{
                    balance_id            : 0x2::object::uid_to_inner(&v43.id),
                    player                : v0,
                    coin_type             : 0x1::type_name::with_defining_ids<T0>(),
                    wager_trigger         : v43.wager_trigger,
                    total_wager           : v43.total_wager,
                    usd_reward            : v43.usd_balance,
                    deadline_timestamp_ms : v43.deadline_timestamp_ms,
                };
                0x2::event::emit<CoinWagerUSDBalanceExpiredEvent>(v44);
                destroy_empty_coin_wager_usd_balance<T0>(v43);
            };
        };
        if (v1) {
            let v45 = (((0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_stake_amount<T0, T1>(arg1) as u128) * (v3 as u128) / (1000000000 as u128)) as u64);
            if (v45 > 0) {
                let v46 = WagerBalance{dummy_field: false};
                0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_fund_rakeback_pool_using_stake_ticket_sources<T0, WagerBalance, T1>(arg0, v46, arg1, v45);
            };
        };
    }

    // decompiled from Move bytecode v6
}

