module 0xa0e74b8f6fed4167e16515446f7cbb808b9269bbfae990c5132dcd399a7925e3::contest {
    struct Contest has copy, drop, store {
        dummy_field: bool,
    }

    struct ContestRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ContestObjectKey has copy, drop, store {
        pos0: u64,
    }

    struct ContestRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_enabled: bool,
        next_contest_id: u64,
        active_contest_id: 0x1::option::Option<u64>,
        commission_rate_normalized: u64,
    }

    struct ContestObject has store, key {
        id: 0x2::object::UID,
        contest_id: u64,
        created_at_timestamp_ms: u64,
        expiration_timestamp_ms: u64,
        leaderboard: vector<ContestLeaderboardEntry>,
        rewards_by_rank: 0x2::vec_map::VecMap<u64, ContestReward>,
        coin_types: vector<0x1::type_name::TypeName>,
        is_finalized: bool,
    }

    struct ContestLeaderboardEntry has drop, store {
        player: address,
        points: u128,
        coin_claimed: vector<bool>,
        exp_claimed: bool,
    }

    struct ContestReward has drop, store {
        coin_rewards: vector<ContestCoinReward>,
        exp_reward: u64,
    }

    struct ContestCoinReward has drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ContestantPointsKey has copy, drop, store {
        contest_id: u64,
        player: address,
    }

    struct ContestantPoints has store, key {
        id: 0x2::object::UID,
        contest_id: u64,
        points: u128,
    }

    struct ContestPointsMultiplierKey has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        game_type: 0x1::type_name::TypeName,
    }

    struct ContestPointsMultiplier has store, key {
        id: 0x2::object::UID,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct ContestCreatedEvent has copy, drop {
        contest_id: u64,
        expiration_timestamp_ms: u64,
    }

    struct ContestFinalizedEvent has copy, drop {
        contest_id: u64,
        leaderboard_length: u64,
    }

    struct ContestCoinRewardClaimedEvent has copy, drop {
        contest_id: u64,
        player: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ContestExpRewardClaimedEvent has copy, drop {
        contest_id: u64,
        player: address,
        exp_amount: u64,
    }

    struct ContestPointsEarnedEvent has copy, drop {
        contest_id: u64,
        player: address,
        points_delta: u64,
        total_points: u128,
    }

    struct ContestFundedRakebackPoolEvent has copy, drop {
        contest_id: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ContestDeadlineEditedEvent has copy, drop {
        contest_id: u64,
        new_expiration_timestamp_ms: u64,
    }

    struct ContestCoinRewardUpsertedEvent has copy, drop {
        contest_id: u64,
        rank: u64,
        coin_type: 0x1::type_name::TypeName,
        previous_amount: u64,
        new_amount: u64,
    }

    struct ContestExpRewardUpsertedEvent has copy, drop {
        contest_id: u64,
        rank: u64,
        previous_amount: u64,
        new_amount: u64,
    }

    struct ContestUnclaimableRewardsRecoveredEvent has copy, drop {
        contest_id: u64,
        leaderboard_length: u64,
        recovered_rank_count: u64,
        removed_ranks: vector<u64>,
    }

    struct ContestRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        is_enabled: bool,
        commission_rate_normalized: u64,
    }

    struct ContestRegistryEditedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        is_enabled: bool,
        commission_rate_normalized: u64,
    }

    struct ContestRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct ContestPointsMultiplierSetEvent has copy, drop {
        registry_id: 0x2::object::ID,
        coin_type_name: 0x1::type_name::TypeName,
        game_type_name: 0x1::type_name::TypeName,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        is_new: bool,
    }

    struct ContestPointsMultiplierRemovedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        coin_type_name: 0x1::type_name::TypeName,
        game_type_name: 0x1::type_name::TypeName,
        multiplier: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    fun add_or_increase_active_contest_coin_reward_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg4 > 0, 13844069545213558851);
        assert!(arg3 < 200, 13838721524948664351);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::house_exists<T0>(arg0), 13841817753988890677);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(contest_registry_exists(arg0), 13839565979943960613);
        let v1 = borrow_contest_registry_mut(arg0);
        assert!(v1.is_enabled, 13835343863881269255);
        assert!(0x1::option::is_some<u64>(&v1.active_contest_id), 13840128942782545961);
        assert!(*0x1::option::borrow<u64>(&v1.active_contest_id) == arg2, 13835906826719854603);
        assert!(contest_exists(v1, arg2), 13837314205899030549);
        let v2 = borrow_contest_object_mut(v1, arg2);
        assert!(!v2.is_finalized, 13836469789558439951);
        assert!(0x2::clock::timestamp_ms(arg1) < v2.expiration_timestamp_ms, 13843506668274319423);
        let v3 = if (0x2::vec_map::contains<u64, ContestReward>(&v2.rewards_by_rank, &arg3)) {
            let v4 = 0x2::vec_map::get_mut<u64, ContestReward>(&mut v2.rewards_by_rank, &arg3);
            let (v5, v6) = find_coin_reward_index(v4, &v0);
            if (v5) {
                let v7 = 0x1::vector::borrow_mut<ContestCoinReward>(&mut v4.coin_rewards, v6);
                let v8 = v7.amount;
                assert!(arg4 > v8, 13843788177610899521);
                v7.amount = arg4;
                v8
            } else {
                let v9 = ContestCoinReward{
                    coin_type : v0,
                    amount    : arg4,
                };
                0x1::vector::push_back<ContestCoinReward>(&mut v4.coin_rewards, v9);
                0
            }
        } else {
            let v10 = ContestCoinReward{
                coin_type : v0,
                amount    : arg4,
            };
            let v11 = 0x1::vector::empty<ContestCoinReward>();
            0x1::vector::push_back<ContestCoinReward>(&mut v11, v10);
            let v12 = ContestReward{
                coin_rewards : v11,
                exp_reward   : 0,
            };
            0x2::vec_map::insert<u64, ContestReward>(&mut v2.rewards_by_rank, arg3, v12);
            0
        };
        let (v13, _) = find_coin_type_index(v2, &v0);
        if (!v13) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2.coin_types, v0);
        };
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::total_rakeback_pool_balance<T0>(arg0) >= total_required_coin_amount(v2, &v0), 13843225390865973309);
        let v15 = ContestCoinRewardUpsertedEvent{
            contest_id      : arg2,
            rank            : arg3,
            coin_type       : v0,
            previous_amount : v3,
            new_amount      : arg4,
        };
        0x2::event::emit<ContestCoinRewardUpsertedEvent>(v15);
    }

    fun add_or_increase_active_contest_exp_reward_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg4 > 0, 13844914472655257673);
        assert!(arg3 < 200, 13838722027459837983);
        assert!(contest_registry_exists(arg0), 13839566469570232357);
        let v0 = borrow_contest_registry_mut(arg0);
        assert!(v0.is_enabled, 13835344353507540999);
        assert!(0x1::option::is_some<u64>(&v0.active_contest_id), 13840129432408817705);
        assert!(*0x1::option::borrow<u64>(&v0.active_contest_id) == arg2, 13835907316346126347);
        assert!(contest_exists(v0, arg2), 13837314695525302293);
        let v1 = borrow_contest_object_mut(v0, arg2);
        assert!(!v1.is_finalized, 13836470279184711695);
        assert!(0x2::clock::timestamp_ms(arg1) < v1.expiration_timestamp_ms, 13843507157900591167);
        let v2 = if (0x2::vec_map::contains<u64, ContestReward>(&v1.rewards_by_rank, &arg3)) {
            let v3 = 0x2::vec_map::get_mut<u64, ContestReward>(&mut v1.rewards_by_rank, &arg3);
            let v4 = v3.exp_reward;
            assert!(arg4 > v4, 13844633079282794567);
            v3.exp_reward = arg4;
            v4
        } else {
            let v5 = ContestReward{
                coin_rewards : 0x1::vector::empty<ContestCoinReward>(),
                exp_reward   : arg4,
            };
            0x2::vec_map::insert<u64, ContestReward>(&mut v1.rewards_by_rank, arg3, v5);
            0
        };
        let v6 = ContestExpRewardUpsertedEvent{
            contest_id      : arg2,
            rank            : arg3,
            previous_amount : v2,
            new_amount      : arg4,
        };
        0x2::event::emit<ContestExpRewardUpsertedEvent>(v6);
    }

    public fun admin_add_or_increase_active_contest_coin_reward<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64) {
        add_or_increase_active_contest_coin_reward_internal<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun admin_add_or_increase_active_contest_exp_reward(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64) {
        add_or_increase_active_contest_exp_reward_internal(arg0, arg2, arg3, arg4, arg5);
    }

    public fun admin_add_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        let v0 = borrow_contest_registry_mut_unchecked(arg0);
        if (!0x2::vec_set::contains<u64>(&v0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v0.version_set, arg2);
            let v1 = ContestRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<ContestRegistryVersionChangedEvent>(v1);
        };
    }

    public fun admin_create_contest(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::vec_map::VecMap<u64, ContestReward>, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        create_contest_internal(arg0, arg2, arg3, arg4, arg5)
    }

    public fun admin_create_contest_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        create_contest_registry_internal(arg0, arg2, arg3, arg4);
    }

    public fun admin_edit_active_contest_deadline(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::clock::Clock, arg3: u64) {
        edit_active_contest_deadline_internal(arg0, arg2, arg3);
    }

    public fun admin_edit_contest_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: bool, arg3: u64) {
        edit_contest_registry_internal(arg0, arg2, arg3);
    }

    public fun admin_recover_unclaimable_finalized_contest_rewards(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        recover_unclaimable_finalized_contest_rewards_internal(arg0, arg2);
    }

    public fun admin_remove_contest_points_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap) {
        remove_points_multiplier_internal<T0, T1>(arg0);
    }

    public fun admin_remove_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        let v0 = borrow_contest_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun admin_set_contest_points_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: &mut 0x2::tx_context::TxContext) {
        set_points_multiplier_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun assert_valid_multiplier(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) {
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero();
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::lt(&arg0, &v0), 13840408107066982443);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1000);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::gt(&arg0, &v1), 13842378440494678071);
    }

    fun assert_valid_version(arg0: &ContestRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13842659198211981369);
    }

    fun borrow_contest_object(arg0: &ContestRegistry, arg1: u64) : &ContestObject {
        let v0 = ContestObjectKey{pos0: arg1};
        0x2::dynamic_object_field::borrow<ContestObjectKey, ContestObject>(&arg0.id, v0)
    }

    fun borrow_contest_object_mut(arg0: &mut ContestRegistry, arg1: u64) : &mut ContestObject {
        let v0 = ContestObjectKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<ContestObjectKey, ContestObject>(&mut arg0.id, v0)
    }

    public fun borrow_contest_registry(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &ContestRegistry {
        let v0 = borrow_contest_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_contest_registry_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut ContestRegistry {
        let v0 = borrow_contest_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_contest_registry_mut_unchecked(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut ContestRegistry {
        let v0 = Contest{dummy_field: false};
        let v1 = ContestRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Contest, ContestRegistryKey, ContestRegistry>(arg0, v0, v1)
    }

    fun borrow_contest_registry_unchecked(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &ContestRegistry {
        let v0 = ContestRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Contest, ContestRegistryKey, ContestRegistry>(arg0, v0)
    }

    fun borrow_contestant_points_mut(arg0: &mut ContestObject, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut ContestantPoints {
        let v0 = arg0.contest_id;
        let v1 = ContestantPointsKey{
            contest_id : v0,
            player     : arg1,
        };
        if (!0x2::dynamic_object_field::exists_<ContestantPointsKey>(&arg0.id, v1)) {
            let v2 = ContestantPoints{
                id         : 0x2::object::new(arg2),
                contest_id : v0,
                points     : 0,
            };
            let v3 = ContestantPointsKey{
                contest_id : v0,
                player     : arg1,
            };
            0x2::dynamic_object_field::add<ContestantPointsKey, ContestantPoints>(&mut arg0.id, v3, v2);
        };
        let v4 = ContestantPointsKey{
            contest_id : v0,
            player     : arg1,
        };
        0x2::dynamic_object_field::borrow_mut<ContestantPointsKey, ContestantPoints>(&mut arg0.id, v4)
    }

    public fun claim_contest_coin_reward<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(contest_registry_exists(arg0), 13839566929131733029);
        let v2 = borrow_contest_registry_mut(arg0);
        assert!(v2.is_enabled, 13835344817364008967);
        assert!(contest_exists(v2, arg1), 13837315146496868373);
        let v3 = borrow_contest_object_mut(v2, arg1);
        assert!(v3.is_finalized, 13836752205133119505);
        let (v4, v5) = find_coin_type_index(v3, &v1);
        assert!(v4, 13837033692994863123);
        let (v6, v7) = find_leaderboard_entry_index(v3, v0);
        assert!(v6, 13838441080763973661);
        let v8 = v7;
        assert!(0x2::vec_map::contains<u64, ContestReward>(&v3.rewards_by_rank, &v8), 13837596677308284951);
        let v9 = reward_coin_amount(0x2::vec_map::get<u64, ContestReward>(&v3.rewards_by_rank, &v8), &v1);
        assert!(v9 > 0, 13841255864892129329);
        let v10 = 0x1::vector::borrow_mut<bool>(&mut 0x1::vector::borrow_mut<ContestLeaderboardEntry>(&mut v3.leaderboard, v7).coin_claimed, v5);
        assert!(!*v10, 13837878182349897753);
        *v10 = true;
        let v11 = Contest{dummy_field: false};
        let v12 = ContestCoinRewardClaimedEvent{
            contest_id : arg1,
            player     : v0,
            coin_type  : v1,
            amount     : v9,
        };
        0x2::event::emit<ContestCoinRewardClaimedEvent>(v12);
        0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, Contest>(arg0, v11, v9), arg2)
    }

    public fun claim_contest_exp_reward(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(contest_registry_exists(arg0), 13839567143880097829);
        let v1 = borrow_contest_registry_mut(arg0);
        assert!(v1.is_enabled, 13835345032112373767);
        assert!(contest_exists(v1, arg2), 13837315361245233173);
        let v2 = borrow_contest_object_mut(v1, arg2);
        assert!(v2.is_finalized, 13836752419881484305);
        let (v3, v4) = find_leaderboard_entry_index(v2, v0);
        assert!(v3, 13838441282627436573);
        let v5 = v4;
        assert!(0x2::vec_map::contains<u64, ContestReward>(&v2.rewards_by_rank, &v5), 13837596870581813271);
        let v6 = 0x2::vec_map::get<u64, ContestReward>(&v2.rewards_by_rank, &v5).exp_reward;
        assert!(v6 > 0, 13841537533142499379);
        let v7 = 0x1::vector::borrow_mut<ContestLeaderboardEntry>(&mut v2.leaderboard, v4);
        assert!(!v7.exp_claimed, 13838159846305300507);
        v7.exp_claimed = true;
        let v8 = Contest{dummy_field: false};
        0x12936bef50c5ce93fd6e0ec805ac760660d7c5c58a860e920a6fd8ff47c26af8::vip::operator_give_exp_to_player<Contest>(arg0, v8, v0, v6, arg1, arg3);
        let v9 = ContestExpRewardClaimedEvent{
            contest_id : arg2,
            player     : v0,
            exp_amount : v6,
        };
        0x2::event::emit<ContestExpRewardClaimedEvent>(v9);
        v6
    }

    fun contest_exists(arg0: &ContestRegistry, arg1: u64) : bool {
        let v0 = ContestObjectKey{pos0: arg1};
        0x2::dynamic_object_field::exists_<ContestObjectKey>(&arg0.id, v0)
    }

    fun contest_registry_exists(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : bool {
        let v0 = ContestRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists<ContestRegistryKey>(arg0, v0)
    }

    fun create_contest_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::vec_map::VecMap<u64, ContestReward>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(contest_registry_exists(arg0), 13839564794532986917);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg2 > v0, 13840972178007130159);
        assert!(0x2::vec_map::length<u64, ContestReward>(&arg3) == 0, 13844349890614001733);
        let v1 = borrow_contest_registry(arg0);
        assert!(v1.is_enabled, 13835342712830033927);
        assert!(0x1::option::is_none<u64>(&v1.active_contest_id), 13835624192101842953);
        let v2 = v1.next_contest_id;
        if (v2 > 0) {
            let v3 = v2 - 1;
            if (contest_exists(v1, v3)) {
                let v4 = borrow_contest_object(v1, v3);
                assert!(v4.is_finalized, 13835624230756548617);
                assert!(arg2 > v4.expiration_timestamp_ms, 13839846372589043751);
            };
        };
        let v5 = ContestObject{
            id                      : 0x2::object::new(arg4),
            contest_id              : v2,
            created_at_timestamp_ms : v0,
            expiration_timestamp_ms : arg2,
            leaderboard             : 0x1::vector::empty<ContestLeaderboardEntry>(),
            rewards_by_rank         : 0x2::vec_map::empty<u64, ContestReward>(),
            coin_types              : 0x1::vector::empty<0x1::type_name::TypeName>(),
            is_finalized            : false,
        };
        let v6 = borrow_contest_registry_mut(arg0);
        assert!(v6.is_enabled, 13835342854563954695);
        assert!(0x1::option::is_none<u64>(&v6.active_contest_id), 13835624333835763721);
        v6.next_contest_id = v2 + 1;
        let v7 = ContestObjectKey{pos0: v2};
        0x2::dynamic_object_field::add<ContestObjectKey, ContestObject>(&mut v6.id, v7, v5);
        v6.active_contest_id = 0x1::option::some<u64>(v2);
        let v8 = ContestCreatedEvent{
            contest_id              : v2,
            expiration_timestamp_ms : arg2,
        };
        0x2::event::emit<ContestCreatedEvent>(v8);
        v2
    }

    fun create_contest_registry_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: bool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            arg2 = 1500000;
        };
        validate_commission_rate(arg2);
        let v0 = ContestRegistryKey{dummy_field: false};
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists<ContestRegistryKey>(arg0, v0), 13839282275879092259);
        let v1 = 0x2::object::new(arg3);
        let v2 = ContestRegistry{
            id                         : v1,
            version_set                : 0x2::vec_set::singleton<u64>(0),
            is_enabled                 : arg1,
            next_contest_id            : 0,
            active_contest_id          : 0x1::option::none<u64>(),
            commission_rate_normalized : arg2,
        };
        let v3 = Contest{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Contest, ContestRegistryKey, ContestRegistry>(arg0, v3, v0, v2);
        let v4 = ContestRegistryCreatedEvent{
            registry_id                : 0x2::object::uid_to_inner(&v1),
            is_enabled                 : arg1,
            commission_rate_normalized : arg2,
        };
        0x2::event::emit<ContestRegistryCreatedEvent>(v4);
    }

    fun edit_active_contest_deadline_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64) {
        assert!(contest_registry_exists(arg0), 13839565511792525349);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg1), 13840972890971701295);
        let v0 = borrow_contest_registry_mut(arg0);
        assert!(v0.is_enabled, 13835343404319768583);
        assert!(0x1::option::is_some<u64>(&v0.active_contest_id), 13840128483221045289);
        let v1 = *0x1::option::borrow<u64>(&v0.active_contest_id);
        if (v1 > 0) {
            let v2 = v1 - 1;
            if (contest_exists(v0, v2)) {
                assert!(arg2 > borrow_contest_object(v0, v2).expiration_timestamp_ms, 13839847046898909223);
            };
        };
        let v3 = borrow_contest_object_mut(v0, v1);
        assert!(!v3.is_finalized, 13836469372946612239);
        assert!(0x2::clock::timestamp_ms(arg1) < v3.expiration_timestamp_ms, 13843506251662491711);
        v3.expiration_timestamp_ms = arg2;
        let v4 = ContestDeadlineEditedEvent{
            contest_id                  : v1,
            new_expiration_timestamp_ms : arg2,
        };
        0x2::event::emit<ContestDeadlineEditedEvent>(v4);
    }

    fun edit_contest_registry_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: bool, arg2: u64) {
        assert!(contest_registry_exists(arg0), 13839563858230116389);
        validate_commission_rate(arg2);
        let v0 = borrow_contest_registry_mut(arg0);
        v0.is_enabled = arg1;
        v0.commission_rate_normalized = arg2;
        let v1 = ContestRegistryEditedEvent{
            registry_id                : 0x2::object::uid_to_inner(&v0.id),
            is_enabled                 : arg1,
            commission_rate_normalized : arg2,
        };
        0x2::event::emit<ContestRegistryEditedEvent>(v1);
    }

    public fun finalize_contest(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock) {
        finalize_contest_internal(arg0, arg1);
    }

    fun finalize_contest_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock) {
        assert!(contest_registry_exists(arg0), 13839565047936057381);
        let v0 = borrow_contest_registry_mut(arg0);
        assert!(v0.is_enabled, 13835342931873366023);
        assert!(0x1::option::is_some<u64>(&v0.active_contest_id), 13835905886122016779);
        let v1 = *0x1::option::borrow<u64>(&v0.active_contest_id);
        let v2 = borrow_contest_object_mut(v0, v1);
        assert!(!v2.is_finalized, 13836468857550536719);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2.expiration_timestamp_ms, 13836187386868662285);
        let v3 = 0;
        while (v3 < 0x1::vector::length<ContestLeaderboardEntry>(&v2.leaderboard)) {
            let v4 = 0x1::vector::borrow_mut<ContestLeaderboardEntry>(&mut v2.leaderboard, v3);
            v4.coin_claimed = new_claim_vector(0x1::vector::length<0x1::type_name::TypeName>(&v2.coin_types));
            v4.exp_claimed = false;
            v3 = v3 + 1;
        };
        v2.is_finalized = true;
        v0.active_contest_id = 0x1::option::none<u64>();
        let v5 = ContestFinalizedEvent{
            contest_id         : v2.contest_id,
            leaderboard_length : 0x1::vector::length<ContestLeaderboardEntry>(&v2.leaderboard),
        };
        0x2::event::emit<ContestFinalizedEvent>(v5);
    }

    fun find_coin_reward_index(arg0: &ContestReward, arg1: &0x1::type_name::TypeName) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ContestCoinReward>(&arg0.coin_rewards)) {
            if (0x1::vector::borrow<ContestCoinReward>(&arg0.coin_rewards, v0).coin_type == *arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_coin_type_index(arg0: &ContestObject, arg1: &0x1::type_name::TypeName) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.coin_types)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coin_types, v0) == *arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_leaderboard_entry_index(arg0: &ContestObject, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ContestLeaderboardEntry>(&arg0.leaderboard)) {
            if (0x1::vector::borrow<ContestLeaderboardEntry>(&arg0.leaderboard, v0).player == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun make_coin_reward<T0>(arg0: u64) : ContestCoinReward {
        ContestCoinReward{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg0,
        }
    }

    public fun make_contest_reward(arg0: vector<ContestCoinReward>, arg1: u64) : ContestReward {
        ContestReward{
            coin_rewards : arg0,
            exp_reward   : arg1,
        }
    }

    fun make_points_multiplier_key(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : ContestPointsMultiplierKey {
        ContestPointsMultiplierKey{
            coin_type : arg0,
            game_type : arg1,
        }
    }

    public fun manager_add_or_increase_active_contest_coin_reward<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg6));
        add_or_increase_active_contest_coin_reward_internal<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun manager_add_or_increase_active_contest_exp_reward(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg6));
        add_or_increase_active_contest_exp_reward_internal(arg0, arg2, arg3, arg4, arg5);
    }

    public fun manager_create_contest(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::vec_map::VecMap<u64, ContestReward>, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg5));
        create_contest_internal(arg0, arg2, arg3, arg4, arg5)
    }

    public fun manager_create_contest_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg4));
        create_contest_registry_internal(arg0, arg2, arg3, arg4);
    }

    public fun manager_edit_active_contest_deadline(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg4));
        edit_active_contest_deadline_internal(arg0, arg2, arg3);
    }

    public fun manager_edit_contest_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg4));
        edit_contest_registry_internal(arg0, arg2, arg3);
    }

    public fun manager_recover_unclaimable_finalized_contest_rewards(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg3));
        recover_unclaimable_finalized_contest_rewards_internal(arg0, arg2);
    }

    public fun manager_remove_contest_points_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg2));
        remove_points_multiplier_internal<T0, T1>(arg0);
    }

    public fun manager_remove_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_contest_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun manager_set_contest_points_multiplier<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Contest>(arg1, 0x2::tx_context::sender(arg3));
        set_points_multiplier_internal<T0, T1>(arg0, arg2, arg3);
    }

    fun maybe_get_points_multiplier(arg0: &ContestRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : (bool, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) {
        let v0 = make_points_multiplier_key(arg1, arg2);
        if (0x2::dynamic_object_field::exists_<ContestPointsMultiplierKey>(&arg0.id, v0)) {
            (true, 0x2::dynamic_object_field::borrow<ContestPointsMultiplierKey, ContestPointsMultiplier>(&arg0.id, v0).multiplier)
        } else {
            (false, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1))
        }
    }

    fun new_claim_vector(arg0: u64) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        v0
    }

    fun package_version() : u64 {
        0
    }

    fun recover_unclaimable_finalized_contest_rewards_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: u64) {
        assert!(contest_registry_exists(arg0), 13839565198259912741);
        let v0 = borrow_contest_registry_mut(arg0);
        assert!(v0.is_enabled, 13835343103672057863);
        assert!(contest_exists(v0, arg1), 13837313432804917269);
        let v1 = borrow_contest_object_mut(v0, arg1);
        assert!(v1.is_finalized, 13836750495736135697);
        let v2 = 0x1::vector::length<ContestLeaderboardEntry>(&v1.leaderboard);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x2::vec_map::length<u64, ContestReward>(&v1.rewards_by_rank)) {
            let (v5, _) = 0x2::vec_map::get_entry_by_idx<u64, ContestReward>(&v1.rewards_by_rank, v4);
            let v7 = *v5;
            if (v7 >= v2) {
                0x1::vector::push_back<u64>(&mut v3, v7);
            };
            v4 = v4 + 1;
        };
        let v8 = 0x1::vector::length<u64>(&v3);
        let v9 = 0;
        while (v9 < v8) {
            let v10 = *0x1::vector::borrow<u64>(&v3, v9);
            let (_, _) = 0x2::vec_map::remove<u64, ContestReward>(&mut v1.rewards_by_rank, &v10);
            v9 = v9 + 1;
        };
        if (v8 > 0) {
            let v13 = ContestUnclaimableRewardsRecoveredEvent{
                contest_id           : arg1,
                leaderboard_length   : v2,
                recovered_rank_count : v8,
                removed_ranks        : v3,
            };
            0x2::event::emit<ContestUnclaimableRewardsRecoveredEvent>(v13);
        };
    }

    fun remove_points_multiplier_internal<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(contest_registry_exists(arg0), 13839563441618288677);
        let v2 = borrow_contest_registry_mut(arg0);
        let v3 = make_points_multiplier_key(v0, v1);
        if (!0x2::dynamic_object_field::exists_<ContestPointsMultiplierKey>(&v2.id, v3)) {
            abort 13840689358705524781
        };
        let ContestPointsMultiplier {
            id         : v4,
            multiplier : v5,
        } = 0x2::dynamic_object_field::remove<ContestPointsMultiplierKey, ContestPointsMultiplier>(&mut v2.id, v3);
        0x2::object::delete(v4);
        let v6 = ContestPointsMultiplierRemovedEvent{
            registry_id    : 0x2::object::uid_to_inner(&v2.id),
            coin_type_name : v0,
            game_type_name : v1,
            multiplier     : v5,
        };
        0x2::event::emit<ContestPointsMultiplierRemovedEvent>(v6);
    }

    fun remove_version_internal(arg0: &mut ContestRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13842940883642220603);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = ContestRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<ContestRegistryVersionChangedEvent>(v0);
    }

    fun resolve_points_multiplier(arg0: &ContestRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let (v0, v1) = maybe_get_points_multiplier(arg0, arg1, arg2);
        if (v0) {
            return v1
        };
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1)
    }

    fun reward_coin_amount(arg0: &ContestReward, arg1: &0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ContestCoinReward>(&arg0.coin_rewards)) {
            let v1 = 0x1::vector::borrow<ContestCoinReward>(&arg0.coin_rewards, v0);
            if (v1.coin_type == *arg1) {
                return v1.amount
            };
            v0 = v0 + 1;
        };
        0
    }

    fun set_points_multiplier_internal<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(contest_registry_exists(arg0), 13839563321359204389);
        let v2 = borrow_contest_registry_mut(arg0);
        assert_valid_multiplier(arg1);
        let v3 = make_points_multiplier_key(v0, v1);
        let v4 = if (0x2::dynamic_object_field::exists_<ContestPointsMultiplierKey>(&v2.id, v3)) {
            0x2::dynamic_object_field::borrow_mut<ContestPointsMultiplierKey, ContestPointsMultiplier>(&mut v2.id, v3).multiplier = arg1;
            false
        } else {
            let v5 = ContestPointsMultiplier{
                id         : 0x2::object::new(arg2),
                multiplier : arg1,
            };
            0x2::dynamic_object_field::add<ContestPointsMultiplierKey, ContestPointsMultiplier>(&mut v2.id, v3, v5);
            true
        };
        let v6 = ContestPointsMultiplierSetEvent{
            registry_id    : 0x2::object::uid_to_inner(&v2.id),
            coin_type_name : v0,
            game_type_name : v1,
            multiplier     : arg1,
            is_new         : v4,
        };
        0x2::event::emit<ContestPointsMultiplierSetEvent>(v6);
    }

    public fun settle_contest_wager<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(contest_registry_exists(arg0), 13839567345743560741);
        let v0 = borrow_contest_registry(arg0);
        if (!v0.is_enabled || 0x1::option::is_none<u64>(&v0.active_contest_id)) {
            return
        };
        let v1 = *0x1::option::borrow<u64>(&v0.active_contest_id);
        let v2 = borrow_contest_object(v0, v1);
        if (v2.is_finalized || 0x2::clock::timestamp_ms(arg2) >= v2.expiration_timestamp_ms) {
            return
        };
        let v3 = v0.commission_rate_normalized;
        let v4 = 0x1::vector::empty<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v5, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_total_stake_usd_value_if_exists<T0, T1>(arg1));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v5, resolve_points_multiplier(borrow_contest_registry(arg0), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>()));
        0x1::vector::push_back<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(v5, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(1000000));
        let v6 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::multiple_mul(v4));
        if (v6 == 0) {
            return
        };
        let v7 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_player<T0, T1>(arg1);
        let v8 = borrow_contest_registry_mut(arg0);
        let v9 = borrow_contest_object_mut(v8, v1);
        let v10 = borrow_contestant_points_mut(v9, v7, arg3);
        v10.points = v10.points + (v6 as u128);
        let v11 = v10.points;
        update_leaderboard(v9, v7, v11);
        let v12 = (((0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_stake_amount<T0, T1>(arg1) as u128) * (v3 as u128) / (1000000000 as u128)) as u64);
        if (v12 > 0) {
            let v13 = Contest{dummy_field: false};
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_fund_rakeback_pool_using_stake_ticket_sources<T0, Contest, T1>(arg0, v13, arg1, v12);
            let v14 = ContestFundedRakebackPoolEvent{
                contest_id : v1,
                coin_type  : 0x1::type_name::with_defining_ids<T0>(),
                amount     : v12,
            };
            0x2::event::emit<ContestFundedRakebackPoolEvent>(v14);
        };
        let v15 = ContestPointsEarnedEvent{
            contest_id   : v1,
            player       : v7,
            points_delta : v6,
            total_points : v11,
        };
        0x2::event::emit<ContestPointsEarnedEvent>(v15);
    }

    fun total_required_coin_amount(arg0: &ContestObject, arg1: &0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u64, ContestReward>(&arg0.rewards_by_rank)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u64, ContestReward>(&arg0.rewards_by_rank, v1);
            v0 = v0 + reward_coin_amount(v3, arg1);
            v1 = v1 + 1;
        };
        v0
    }

    fun update_leaderboard(arg0: &mut ContestObject, arg1: address, arg2: u128) {
        assert!(!arg0.is_finalized, 13836468307794722831);
        let v0 = false;
        let v1 = 0x1::vector::empty<bool>();
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<ContestLeaderboardEntry>(&arg0.leaderboard)) {
            if (0x1::vector::borrow<ContestLeaderboardEntry>(&arg0.leaderboard, v3).player == arg1) {
                let v4 = 0x1::vector::remove<ContestLeaderboardEntry>(&mut arg0.leaderboard, v3);
                v1 = v4.coin_claimed;
                v2 = v4.exp_claimed;
                v0 = true;
                break
            };
            v3 = v3 + 1;
        };
        if (!v0) {
            v2 = false;
        };
        let v5 = ContestLeaderboardEntry{
            player       : arg1,
            points       : arg2,
            coin_claimed : v1,
            exp_claimed  : v2,
        };
        0x1::vector::push_back<ContestLeaderboardEntry>(&mut arg0.leaderboard, v5);
        let v6 = 0x1::vector::length<ContestLeaderboardEntry>(&arg0.leaderboard);
        if (v6 == 0) {
            return
        };
        let v7 = v6 - 1;
        while (v7 > 0) {
            v7 = v7 - 1;
            if (0x1::vector::borrow<ContestLeaderboardEntry>(&arg0.leaderboard, v7).points > 0x1::vector::borrow<ContestLeaderboardEntry>(&arg0.leaderboard, v7).points) {
                break
            };
            0x1::vector::swap<ContestLeaderboardEntry>(&mut arg0.leaderboard, v7, v7);
        };
        if (0x1::vector::length<ContestLeaderboardEntry>(&arg0.leaderboard) > 200) {
            0x1::vector::pop_back<ContestLeaderboardEntry>(&mut arg0.leaderboard);
        };
    }

    fun validate_commission_rate(arg0: u64) {
        assert!(arg0 <= 10000000, 13839000968405975073);
    }

    // decompiled from Move bytecode v6
}

