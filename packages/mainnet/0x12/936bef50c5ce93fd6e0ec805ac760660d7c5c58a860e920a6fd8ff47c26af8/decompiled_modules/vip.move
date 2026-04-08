module 0x12936bef50c5ce93fd6e0ec805ac760660d7c5c58a860e920a6fd8ff47c26af8::vip {
    struct Vip has copy, drop, store {
        dummy_field: bool,
    }

    struct VipRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VipRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_enabled: bool,
        stake_contribution_to_rakeback_pool: u64,
        vip_exp_threshholds: vector<u64>,
        vip_level_up_usd_rewards: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        daily_external_exp_limit: u64,
        current_epoch_external_exp_count: u128,
        last_epoch_reset: u64,
    }

    struct ExpMultiplierKey has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        game_type: 0x1::type_name::TypeName,
    }

    struct ExpMultiplier has store, key {
        id: 0x2::object::UID,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct PlayerExpBoost has store, key {
        id: 0x2::object::UID,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        expiry_timestamp_ms: u64,
        created_at_timestamp_ms: u64,
    }

    struct PlayerVipProfileKey has copy, drop, store {
        pos0: address,
    }

    struct PlayerVipProfile has store, key {
        id: 0x2::object::UID,
        level: u64,
        exp: u128,
    }

    struct VipLevelUpUsdRewardKey has copy, drop, store {
        level: u64,
    }

    struct VipLevelUpUsdReward has store, key {
        id: 0x2::object::UID,
        usd_reward_amount: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        created_at_timestamp_ms: u64,
    }

    struct PlayerVipLevelUpEvent has copy, drop {
        player: address,
        level_reached: u64,
    }

    struct PlayerVipExpProgressEvent has copy, drop {
        player: address,
        old_exp: u128,
        new_exp: u128,
    }

    struct ExternalVipExpGrantedEvent has copy, drop {
        player: address,
        exp_amount: u64,
    }

    struct NewVipLevelUpUsdRewardEvent has copy, drop {
        player: address,
        level: u64,
        usd_reward_amount: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct PlayerClaimVipLevelUpUsdRewardEvent has copy, drop {
        player: address,
        claimed_at_timestamp_ms: u64,
        level: u64,
        dollar_coin_type_name: 0x1::type_name::TypeName,
        usd_reward_amount: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        dollar_coin_reward_amount: u64,
        dollar_coin_decimals: u8,
        stablecoin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        stablecoin_confidence: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        payout_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct VipRegistryEditedEvent has copy, drop {
        is_enabled: bool,
        stake_contribution_to_rakeback_pool: u64,
        vip_exp_threshholds: vector<u64>,
        vip_level_up_usd_rewards: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
        daily_external_exp_limit: u64,
    }

    struct VipRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        is_enabled: bool,
        stake_contribution_to_rakeback_pool: u64,
        daily_external_exp_limit: u64,
    }

    struct VipRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct ExpMultiplierSetEvent has copy, drop {
        coin_type_name: 0x1::type_name::TypeName,
        game_type_name: 0x1::type_name::TypeName,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        is_new: bool,
    }

    struct ExpMultiplierRemovedEvent has copy, drop {
        coin_type_name: 0x1::type_name::TypeName,
        game_type_name: 0x1::type_name::TypeName,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct PlayerExpBoostCreatedEvent has copy, drop {
        actor: address,
        player: address,
        coin_type_name: 0x1::type_name::TypeName,
        game_type_name: 0x1::type_name::TypeName,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        expiry_timestamp_ms: u64,
        created_at_timestamp_ms: u64,
    }

    struct PlayerExpBoostRemovedEvent has copy, drop {
        actor: address,
        player: address,
        coin_type_name: 0x1::type_name::TypeName,
        game_type_name: 0x1::type_name::TypeName,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        expiry_timestamp_ms: u64,
        removed_at_timestamp_ms: u64,
    }

    struct PlayerExpBoostExpiredEvent has copy, drop {
        player: address,
        coin_type_name: 0x1::type_name::TypeName,
        game_type_name: 0x1::type_name::TypeName,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        expiry_timestamp_ms: u64,
        expired_at_timestamp_ms: u64,
        reason: vector<u8>,
    }

    public fun admin_add_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        let v0 = borrow_vip_registry_mut_unchecked(arg0);
        if (!0x2::vec_set::contains<u64>(&v0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v0.version_set, arg2);
            let v1 = VipRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<VipRegistryVersionChangedEvent>(v1);
        };
    }

    public fun admin_create_vip_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_vip_registry_internal(arg0, arg2);
    }

    public fun admin_edit_vip_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: bool, arg3: u64, arg4: vector<u64>, arg5: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg6: u64) {
        edit_vip_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun admin_external_give_exp_to_player(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        external_give_exp_to_player_internal(arg0, arg2, arg3, arg4, arg5);
    }

    public fun admin_remove_exp_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap) {
        remove_exp_multiplier_internal<T0, T1>(arg0);
    }

    public fun admin_remove_player_exp_boost<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        remove_player_exp_boost_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun admin_remove_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        let v0 = borrow_vip_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun admin_set_exp_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: &mut 0x2::tx_context::TxContext) {
        set_exp_multiplier_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun admin_set_player_exp_boost<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        set_player_exp_boost_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun assert_valid_exp_multiplier(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) {
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(100);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gte(arg0, &v0), 13836465984216891399);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lte(arg0, &v1), 13836465988511858695);
    }

    fun assert_valid_version(arg0: &VipRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13838718673089462289);
    }

    fun borrow_player_vip_profile_mut(arg0: &mut VipRegistry, arg1: address) : &mut PlayerVipProfile {
        let v0 = PlayerVipProfileKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<PlayerVipProfileKey, PlayerVipProfile>(&mut arg0.id, v0)
    }

    public fun borrow_vip_registry(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &VipRegistry {
        let v0 = borrow_vip_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_vip_registry_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut VipRegistry {
        let v0 = borrow_vip_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_vip_registry_mut_unchecked(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut VipRegistry {
        let v0 = Vip{dummy_field: false};
        let v1 = VipRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Vip, VipRegistryKey, VipRegistry>(arg0, v0, v1)
    }

    fun borrow_vip_registry_unchecked(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &VipRegistry {
        let v0 = VipRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Vip, VipRegistryKey, VipRegistry>(arg0, v0)
    }

    entry fun claim_vip_level_up_usd_reward<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::get_coin_decimals<T0>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::get_dollar_coin_type(arg0) == v1, 13835906496006848515);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = borrow_vip_registry_mut(arg0);
        let v4 = borrow_player_vip_profile_mut(v3, v2);
        let v5 = VipLevelUpUsdRewardKey{level: arg1};
        assert!(0x2::dynamic_object_field::exists_<VipLevelUpUsdRewardKey>(&v4.id, v5), 13840128672198688795);
        let VipLevelUpUsdReward {
            id                      : v6,
            usd_reward_amount       : v7,
            created_at_timestamp_ms : _,
        } = 0x2::dynamic_object_field::remove<VipLevelUpUsdRewardKey, VipLevelUpUsdReward>(&mut v4.id, v5);
        0x2::object::delete(v6);
        let (v9, v10, _) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::get_checked_usd_price(arg0, v1, arg2, arg3);
        let v12 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::price_upper_bound(v9, v10);
        let v13 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(v7, v12), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math::pow_u64(10, (v0 as u64)))));
        let v14 = PlayerClaimVipLevelUpUsdRewardEvent{
            player                    : v2,
            claimed_at_timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
            level                     : arg1,
            dollar_coin_type_name     : v1,
            usd_reward_amount         : v7,
            dollar_coin_reward_amount : v13,
            dollar_coin_decimals      : v0,
            stablecoin_price          : v9,
            stablecoin_confidence     : v10,
            payout_price              : v12,
        };
        0x2::event::emit<PlayerClaimVipLevelUpUsdRewardEvent>(v14);
        let v15 = Vip{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, Vip>(arg0, v15, v13), arg4), 0x2::tx_context::sender(arg4));
    }

    fun create_vip_level_up_reward(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: u64, arg3: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_vip_registry_mut(arg0);
        let v1 = VipLevelUpUsdRewardKey{level: arg2};
        let v2 = VipLevelUpUsdReward{
            id                      : 0x2::object::new(arg5),
            usd_reward_amount       : arg3,
            created_at_timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::dynamic_object_field::add<VipLevelUpUsdRewardKey, VipLevelUpUsdReward>(&mut borrow_player_vip_profile_mut(v0, arg1).id, v1, v2);
        let v3 = NewVipLevelUpUsdRewardEvent{
            player            : arg1,
            level             : arg2,
            usd_reward_amount : arg3,
        };
        0x2::event::emit<NewVipLevelUpUsdRewardEvent>(v3);
    }

    fun create_vip_registry_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VipRegistry{
            id                                  : 0x2::object::new(arg1),
            version_set                         : 0x2::vec_set::singleton<u64>(0),
            is_enabled                          : true,
            stake_contribution_to_rakeback_pool : 500,
            vip_exp_threshholds                 : 0x1::vector::empty<u64>(),
            vip_level_up_usd_rewards            : 0x2::vec_map::empty<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(),
            daily_external_exp_limit            : 10000000000000,
            current_epoch_external_exp_count    : 0,
            last_epoch_reset                    : 0,
        };
        let v1 = Vip{dummy_field: false};
        let v2 = VipRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Vip, VipRegistryKey, VipRegistry>(arg0, v1, v2, v0);
        let v3 = VipRegistryCreatedEvent{
            registry_id                         : 0x2::object::id<VipRegistry>(&v0),
            is_enabled                          : true,
            stake_contribution_to_rakeback_pool : 500,
            daily_external_exp_limit            : 10000000000000,
        };
        0x2::event::emit<VipRegistryCreatedEvent>(v3);
    }

    fun edit_vip_registry_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: bool, arg2: u64, arg3: vector<u64>, arg4: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg5: u64) {
        let v0 = borrow_vip_registry_mut(arg0);
        v0.is_enabled = arg1;
        assert!(arg2 <= 1000000 / 100, 13837031326467358731);
        v0.stake_contribution_to_rakeback_pool = arg2;
        if (0x1::vector::length<u64>(&arg3) > 1) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<u64>(&arg3) - 1) {
                assert!(*0x1::vector::borrow<u64>(&arg3, v1) < *0x1::vector::borrow<u64>(&arg3, v1 + 1), 13837312835803938829);
                v1 = v1 + 1;
            };
        };
        v0.vip_exp_threshholds = arg3;
        let (_, v3) = 0x2::vec_map::into_keys_values<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg4);
        let v4 = v3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v4)) {
            assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v4, v5)), 13837594353730453519);
            v5 = v5 + 1;
        };
        v0.vip_level_up_usd_rewards = arg4;
        v0.daily_external_exp_limit = arg5;
        let v6 = VipRegistryEditedEvent{
            is_enabled                          : arg1,
            stake_contribution_to_rakeback_pool : arg2,
            vip_exp_threshholds                 : arg3,
            vip_level_up_usd_rewards            : arg4,
            daily_external_exp_limit            : arg5,
        };
        0x2::event::emit<VipRegistryEditedEvent>(v6);
    }

    fun ensure_player_vip_profile_exists(arg0: &mut VipRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerVipProfileKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists_<PlayerVipProfileKey>(&arg0.id, v0)) {
            let v1 = PlayerVipProfile{
                id    : 0x2::object::new(arg2),
                level : 0,
                exp   : 0,
            };
            0x2::dynamic_object_field::add<PlayerVipProfileKey, PlayerVipProfile>(&mut arg0.id, v0, v1);
        };
    }

    public fun exp_multiplier_exists<T0, T1: drop>(arg0: &VipRegistry) : bool {
        assert_valid_version(arg0);
        exp_multiplier_exists_internal(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>())
    }

    fun exp_multiplier_exists_internal(arg0: &VipRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : bool {
        0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&arg0.id, make_exp_multiplier_key(arg1, arg2))
    }

    fun external_give_exp_to_player_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_vip_registry_mut(arg0);
        assert!(v0.is_enabled, 13836188671063359493);
        if (v0.last_epoch_reset < 0x2::tx_context::epoch(arg4)) {
            v0.current_epoch_external_exp_count = 0;
            v0.last_epoch_reset = 0x2::tx_context::epoch(arg4);
        };
        let v1 = v0.current_epoch_external_exp_count + (arg2 as u128);
        assert!(v1 <= (v0.daily_external_exp_limit as u128), 13835625751174447105);
        v0.current_epoch_external_exp_count = v1;
        give_exp_to_player(arg0, arg1, arg2, arg3, arg4);
        let v2 = ExternalVipExpGrantedEvent{
            player     : arg1,
            exp_amount : arg2,
        };
        0x2::event::emit<ExternalVipExpGrantedEvent>(v2);
    }

    public fun get_exp_multiplier<T0, T1: drop>(arg0: &VipRegistry) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        assert_valid_version(arg0);
        get_exp_multiplier_internal(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>())
    }

    fun get_exp_multiplier_internal(arg0: &VipRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        assert!(exp_multiplier_exists_internal(arg0, arg1, arg2), 13836749477828362249);
        0x2::dynamic_object_field::borrow<ExpMultiplierKey, ExpMultiplier>(&arg0.id, make_exp_multiplier_key(arg1, arg2)).multiplier
    }

    fun give_exp_to_player(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v3 = borrow_vip_registry_mut(arg0);
        if (!v3.is_enabled) {
            return vector[]
        };
        ensure_player_vip_profile_exists(v3, arg1, arg4);
        let v4 = PlayerVipProfileKey{pos0: arg1};
        let v5 = 0x2::dynamic_object_field::borrow_mut<PlayerVipProfileKey, PlayerVipProfile>(&mut v3.id, v4);
        let v6 = v5.exp;
        let v7 = v6 + (arg2 as u128);
        v5.exp = v7;
        let v8 = PlayerVipExpProgressEvent{
            player  : arg1,
            old_exp : v6,
            new_exp : v7,
        };
        0x2::event::emit<PlayerVipExpProgressEvent>(v8);
        let v9 = v3.vip_exp_threshholds;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v9)) {
            if (v7 >= (*0x1::vector::borrow<u64>(&v9, v11) as u128)) {
                v10 = v11 + 1;
            };
            v11 = v11 + 1;
        };
        if (v10 > v5.level) {
            let v12 = v5.level;
            while (v12 + 1 <= v10) {
                let v13 = v12 + 1;
                0x1::vector::push_back<u64>(&mut v0, v13);
                if (0x2::vec_map::contains<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v3.vip_level_up_usd_rewards, &v13)) {
                    let v14 = *0x2::vec_map::get<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v3.vip_level_up_usd_rewards, &v13);
                    if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive(&v14)) {
                        0x1::vector::push_back<u64>(&mut v1, v13);
                        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&mut v2, v14);
                    };
                };
                v12 = v12 + 1;
            };
            v5.level = v10;
        };
        let v15 = 0;
        while (v15 < 0x1::vector::length<u64>(&v0)) {
            let v16 = PlayerVipLevelUpEvent{
                player        : arg1,
                level_reached : *0x1::vector::borrow<u64>(&v0, v15),
            };
            0x2::event::emit<PlayerVipLevelUpEvent>(v16);
            v15 = v15 + 1;
        };
        let v17 = 0;
        while (v17 < 0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v2)) {
            create_vip_level_up_reward(arg0, arg1, *0x1::vector::borrow<u64>(&v1, v17), *0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v2, v17), arg3, arg4);
            v17 = v17 + 1;
        };
        v0
    }

    fun make_exp_multiplier_key(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : ExpMultiplierKey {
        ExpMultiplierKey{
            coin_type : arg0,
            game_type : arg1,
        }
    }

    public fun manager_create_vip_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg2));
        create_vip_registry_internal(arg0, arg2);
    }

    public fun manager_edit_vip_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: bool, arg3: u64, arg4: vector<u64>, arg5: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg7));
        edit_vip_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun manager_external_give_exp_to_player(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg5));
        external_give_exp_to_player_internal(arg0, arg2, arg3, arg4, arg5);
    }

    public fun manager_remove_exp_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg2));
        remove_exp_multiplier_internal<T0, T1>(arg0);
    }

    public fun manager_remove_player_exp_boost<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg4));
        remove_player_exp_boost_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun manager_remove_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_vip_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun manager_set_exp_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg3));
        set_exp_multiplier_internal<T0, T1>(arg0, arg2, arg3);
    }

    public fun manager_set_player_exp_boost<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Vip>(arg1, 0x2::tx_context::sender(arg6));
        set_player_exp_boost_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun maybe_get_exp_multiplier(arg0: &VipRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : (bool, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) {
        let v0 = make_exp_multiplier_key(arg1, arg2);
        if (0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&arg0.id, v0)) {
            (true, 0x2::dynamic_object_field::borrow<ExpMultiplierKey, ExpMultiplier>(&arg0.id, v0).multiplier)
        } else {
            (false, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1))
        }
    }

    public fun operator_give_exp_to_player<T0: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T0, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::assert_operator_config_enabled<T0>(arg0);
        external_give_exp_to_player_internal(arg0, arg2, arg3, arg4, arg5);
    }

    fun package_version() : u64 {
        0
    }

    fun purge_expired_player_exp_boost_for_types<T0, T1: drop>(arg0: &mut VipRegistry, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = PlayerVipProfileKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists_<PlayerVipProfileKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_object_field::borrow_mut<PlayerVipProfileKey, PlayerVipProfile>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = make_exp_multiplier_key(v2, v3);
        if (!0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&v1.id, v4)) {
            return
        };
        let v5 = 0x2::clock::timestamp_ms(arg2);
        if (!(v5 > 0x2::dynamic_object_field::borrow<ExpMultiplierKey, PlayerExpBoost>(&v1.id, v4).expiry_timestamp_ms)) {
            return
        };
        let PlayerExpBoost {
            id                      : v6,
            multiplier              : v7,
            expiry_timestamp_ms     : v8,
            created_at_timestamp_ms : _,
        } = 0x2::dynamic_object_field::remove<ExpMultiplierKey, PlayerExpBoost>(&mut v1.id, v4);
        0x2::object::delete(v6);
        let v10 = PlayerExpBoostExpiredEvent{
            player                  : arg1,
            coin_type_name          : v2,
            game_type_name          : v3,
            multiplier              : v7,
            expiry_timestamp_ms     : v8,
            expired_at_timestamp_ms : v5,
            reason                  : b"deadline_passed",
        };
        0x2::event::emit<PlayerExpBoostExpiredEvent>(v10);
    }

    public fun read_player_vip_data(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (u64, u128) {
        let v0 = borrow_vip_registry_mut(arg0);
        if (!v0.is_enabled) {
            abort 13836188958826168325
        };
        ensure_player_vip_profile_exists(v0, arg1, arg2);
        let v1 = PlayerVipProfileKey{pos0: arg1};
        let v2 = 0x2::dynamic_object_field::borrow<PlayerVipProfileKey, PlayerVipProfile>(&v0.id, v1);
        (v2.level, v2.exp)
    }

    fun remove_exp_multiplier_entry<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = borrow_vip_registry_mut(arg0);
        let v1 = make_exp_multiplier_key(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
        if (!0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&v0.id, v1)) {
            abort 13836747768431378441
        };
        let ExpMultiplier {
            id         : v2,
            multiplier : v3,
        } = 0x2::dynamic_object_field::remove<ExpMultiplierKey, ExpMultiplier>(&mut v0.id, v1);
        0x2::object::delete(v2);
        v3
    }

    fun remove_exp_multiplier_internal<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) {
        let v0 = ExpMultiplierRemovedEvent{
            coin_type_name : 0x1::type_name::with_defining_ids<T0>(),
            game_type_name : 0x1::type_name::with_defining_ids<T1>(),
            multiplier     : remove_exp_multiplier_entry<T0, T1>(arg0),
        };
        0x2::event::emit<ExpMultiplierRemovedEvent>(v0);
    }

    fun remove_player_exp_boost_entry<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = borrow_vip_registry_mut(arg0);
        let v1 = PlayerVipProfileKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists_<PlayerVipProfileKey>(&v0.id, v1), 13839563755149983767);
        let v2 = 0x2::dynamic_object_field::borrow_mut<PlayerVipProfileKey, PlayerVipProfile>(&mut v0.id, v1);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        let v5 = make_exp_multiplier_key(v3, v4);
        assert!(0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&v2.id, v5), 13839563806689591319);
        let PlayerExpBoost {
            id                      : v6,
            multiplier              : v7,
            expiry_timestamp_ms     : v8,
            created_at_timestamp_ms : _,
        } = 0x2::dynamic_object_field::remove<ExpMultiplierKey, PlayerExpBoost>(&mut v2.id, v5);
        0x2::object::delete(v6);
        let v10 = PlayerExpBoostRemovedEvent{
            actor                   : 0x2::tx_context::sender(arg3),
            player                  : arg1,
            coin_type_name          : v3,
            game_type_name          : v4,
            multiplier              : v7,
            expiry_timestamp_ms     : v8,
            removed_at_timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlayerExpBoostRemovedEvent>(v10);
    }

    fun remove_player_exp_boost_internal<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        remove_player_exp_boost_entry<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun remove_version_internal(arg0: &mut VipRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13839000405764341779);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = VipRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<VipRegistryVersionChangedEvent>(v0);
    }

    fun resolve_exp_multiplier(arg0: &VipRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let (v0, v1) = maybe_get_exp_multiplier(arg0, arg1, arg2);
        if (v0) {
            return v1
        };
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1)
    }

    fun resolve_exp_multiplier_for_types<T0, T1: drop>(arg0: &VipRegistry) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        resolve_exp_multiplier(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>())
    }

    fun resolve_player_exp_boost_multiplier_for_types<T0, T1: drop>(arg0: &VipRegistry, arg1: address, arg2: &0x2::clock::Clock) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = PlayerVipProfileKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists_<PlayerVipProfileKey>(&arg0.id, v0)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        let v1 = 0x2::dynamic_object_field::borrow<PlayerVipProfileKey, PlayerVipProfile>(&arg0.id, v0);
        let v2 = make_exp_multiplier_key(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
        if (!0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&v1.id, v2)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        0x2::dynamic_object_field::borrow<ExpMultiplierKey, PlayerExpBoost>(&v1.id, v2).multiplier
    }

    fun set_exp_multiplier_entry<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg2: &mut 0x2::tx_context::TxContext) : bool {
        assert_valid_exp_multiplier(&arg1);
        let v0 = borrow_vip_registry_mut(arg0);
        let v1 = make_exp_multiplier_key(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
        if (0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&v0.id, v1)) {
            0x2::dynamic_object_field::borrow_mut<ExpMultiplierKey, ExpMultiplier>(&mut v0.id, v1).multiplier = arg1;
            false
        } else {
            let v3 = ExpMultiplier{
                id         : 0x2::object::new(arg2),
                multiplier : arg1,
            };
            0x2::dynamic_object_field::add<ExpMultiplierKey, ExpMultiplier>(&mut v0.id, v1, v3);
            true
        }
    }

    fun set_exp_multiplier_internal<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ExpMultiplierSetEvent{
            coin_type_name : 0x1::type_name::with_defining_ids<T0>(),
            game_type_name : 0x1::type_name::with_defining_ids<T1>(),
            multiplier     : arg1,
            is_new         : set_exp_multiplier_entry<T0, T1>(arg0, arg1, arg2),
        };
        0x2::event::emit<ExpMultiplierSetEvent>(v0);
    }

    fun set_player_exp_boost_entry<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_exp_multiplier(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 > v0, 13839845045443231769);
        let v1 = borrow_vip_registry_mut(arg0);
        ensure_player_vip_profile_exists(v1, arg1, arg5);
        let v2 = borrow_player_vip_profile_mut(v1, arg1);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        let v5 = make_exp_multiplier_key(v3, v4);
        assert!(!0x2::dynamic_object_field::exists_<ExpMultiplierKey>(&v2.id, v5), 13839282142734188565);
        let v6 = PlayerExpBoost{
            id                      : 0x2::object::new(arg5),
            multiplier              : arg2,
            expiry_timestamp_ms     : arg3,
            created_at_timestamp_ms : v0,
        };
        0x2::dynamic_object_field::add<ExpMultiplierKey, PlayerExpBoost>(&mut v2.id, v5, v6);
        let v7 = PlayerExpBoostCreatedEvent{
            actor                   : 0x2::tx_context::sender(arg5),
            player                  : arg1,
            coin_type_name          : v3,
            game_type_name          : v4,
            multiplier              : arg2,
            expiry_timestamp_ms     : arg3,
            created_at_timestamp_ms : v0,
        };
        0x2::event::emit<PlayerExpBoostCreatedEvent>(v7);
    }

    fun set_player_exp_boost_internal<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        set_player_exp_boost_entry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun settle_vip_progress<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_player<T0, T1>(arg1);
        let v1 = borrow_vip_registry_mut(arg0);
        let v2 = v1.is_enabled;
        purge_expired_player_exp_boost_for_types<T0, T1>(v1, v0, arg2);
        let v3 = if (v2) {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(resolve_exp_multiplier_for_types<T0, T1>(v1), resolve_player_exp_boost_multiplier_for_types<T0, T1>(v1, v0, arg2))
        } else {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1)
        };
        if (!v2) {
            return
        };
        let v4 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v5, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_total_stake_usd_value_if_exists<T0, T1>(arg1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v5, v3);
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v5, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1000000));
        let v6 = Vip{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_fund_rakeback_pool_using_stake_ticket_sources<T0, Vip, T1>(arg0, v6, arg1, (((0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_stake_amount<T0, T1>(arg1) as u128) * (v1.stake_contribution_to_rakeback_pool as u128) / (1000000 as u128)) as u64));
        give_exp_to_player(arg0, v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::multiple_mul(v4)), arg2, arg3);
    }

    public fun vip_registry_enabled(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : bool {
        if (!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_config_enabled<Vip>(arg0)) {
            return false
        };
        let v0 = Vip{dummy_field: false};
        let v1 = VipRegistryKey{dummy_field: false};
        if (!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists_with_type<Vip, VipRegistryKey, VipRegistry>(arg0, v0, v1)) {
            return false
        };
        borrow_vip_registry(arg0).is_enabled
    }

    // decompiled from Move bytecode v6
}

