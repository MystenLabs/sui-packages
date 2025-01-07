module 0xfe5f5d6aaf3dcc8ae9c36ecb99348a15c39c2520cf2ea9ca5fb8459c29afc3a7::dynamic_liquidation_pool {
    struct LiquidityPool has store, key {
        id: 0x2::object::UID,
        version: u8,
        paused: bool,
        total_eligible_balance: u256,
        total_staking_weight: u256,
        token_id_counter: u64,
        current_index: u256,
        reward_rate: u256,
        maintainer_base_reward: u64,
        minimum_lp_value: u256,
        last_timestamp: u64,
        user_stakings: 0x2::table::Table<address, vector<u64>>,
        user_rewards: 0x2::table::Table<address, u64>,
        token_infos: 0x2::table::Table<u64, TokenInfo>,
        position_tokens: 0x2::table::Table<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        locking_types_to_ms: vector<u64>,
        locking_multipliers: vector<u256>,
        user_autolock_settings: 0x2::table::Table<address, u64>,
        user_qualifications: 0x2::table::Table<address, bool>,
    }

    struct StakingRewardPool has store, key {
        id: 0x2::object::UID,
        stake_reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        maintainer_reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        decimal: u8,
    }

    struct TokenInfo has store {
        owner: address,
        token_id: u64,
        locking_type: u64,
        token_value: u256,
        token_weight: u256,
        token_index: u256,
        token_reward: u256,
        expiration_timestamp: u64,
    }

    struct DLPAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun calculate_lp_token_value(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : u256 {
        1
    }

    public fun calculate_lp_token_weight(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: u256) : u256 {
        1
    }

    public entry fun claim_reward(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool, arg2: u64, arg3: &mut StakingRewardPool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u64>(&arg1.user_rewards, 0x2::tx_context::sender(arg4)), 0);
        update_reward(arg0, arg1);
        update_token_reward(arg0, arg1, arg2);
        let v0 = *0x2::table::borrow<address, u64>(&arg1.user_rewards, 0x2::tx_context::sender(arg4));
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3.stake_reward_balance, v0), arg4), 0x2::tx_context::sender(arg4));
    }

    public(friend) fun create_reward_pool(arg0: &DLPAdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingRewardPool{
            id                        : 0x2::object::new(arg2),
            stake_reward_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            maintainer_reward_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            decimal                   : arg1,
        };
        0x2::transfer::share_object<StakingRewardPool>(v0);
    }

    fun deactivate_token(arg0: &mut LiquidityPool, arg1: u64) {
        let v0 = 0x2::table::borrow_mut<u64, TokenInfo>(&mut arg0.token_infos, arg1);
        arg0.total_staking_weight = arg0.total_staking_weight - v0.token_weight;
        v0.expiration_timestamp = 0;
        v0.token_weight = 0;
    }

    public fun dynamic_reward_index(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock) : u256 {
        arg0.current_index + arg0.reward_rate / arg0.total_staking_weight * (((0x2::clock::timestamp_ms(arg1) - arg0.last_timestamp) / 1000) as u256)
    }

    public fun dynamic_token_reward(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock, arg2: u64) : u256 {
        verify_token_exists(arg0, arg2);
        let v0 = dynamic_reward_index(arg0, arg1);
        let v1 = 0x2::table::borrow<u64, TokenInfo>(&arg0.token_infos, arg2);
        (v0 - v1.token_index) * v1.token_weight + 0x2::table::borrow_mut<u64, TokenInfo>(&mut arg0.token_infos, arg2).token_reward
    }

    fun excecute_relock(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<u64, TokenInfo>(&mut arg0.token_infos, arg3);
        arg0.total_staking_weight = arg0.total_staking_weight - v0.token_weight;
        v0.expiration_timestamp = 0x2::clock::timestamp_ms(arg1) + *0x1::vector::borrow<u64>(&arg0.locking_types_to_ms, arg2);
        v0.token_weight = calculate_lp_token_weight(0x2::table::borrow<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_tokens, v0.token_id), *0x1::vector::borrow<u256>(&arg0.locking_multipliers, arg2));
        arg0.total_staking_weight = arg0.total_staking_weight + v0.token_weight;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DLPAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DLPAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 2592000000;
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0);
        0x1::vector::push_back<u64>(&mut v2, v1);
        0x1::vector::push_back<u64>(&mut v2, v1 * 3);
        0x1::vector::push_back<u64>(&mut v2, v1 * 6);
        0x1::vector::push_back<u64>(&mut v2, v1 * 12);
        let v3 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v3, 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray_div(8, 10));
        0x1::vector::push_back<u256>(&mut v3, 1 * 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray());
        0x1::vector::push_back<u256>(&mut v3, 4 * 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray());
        0x1::vector::push_back<u256>(&mut v3, 10 * 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray());
        0x1::vector::push_back<u256>(&mut v3, 25 * 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray());
        let v4 = LiquidityPool{
            id                     : 0x2::object::new(arg0),
            version                : 6,
            paused                 : false,
            total_eligible_balance : 0,
            total_staking_weight   : 0,
            token_id_counter       : 0,
            current_index          : 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray(),
            reward_rate            : 0,
            maintainer_base_reward : 0,
            minimum_lp_value       : 0,
            last_timestamp         : 0,
            user_stakings          : 0x2::table::new<address, vector<u64>>(arg0),
            user_rewards           : 0x2::table::new<address, u64>(arg0),
            token_infos            : 0x2::table::new<u64, TokenInfo>(arg0),
            position_tokens        : 0x2::table::new<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0),
            locking_types_to_ms    : v2,
            locking_multipliers    : v3,
            user_autolock_settings : 0x2::table::new<address, u64>(arg0),
            user_qualifications    : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<LiquidityPool>(v4);
    }

    public entry fun init_dlp_timestamp(arg0: &DLPAdminCap, arg1: &mut LiquidityPool, arg2: &0x2::clock::Clock) {
        if (arg1.last_timestamp != 0) {
            return
        };
        arg1.last_timestamp = 0x2::clock::timestamp_ms(arg2);
    }

    public fun is_user_last_qualified(arg0: &mut LiquidityPool, arg1: address) : bool {
        if (!0x2::table::contains<address, bool>(&arg0.user_qualifications, arg1)) {
            return false
        };
        *0x2::table::borrow<address, bool>(&arg0.user_qualifications, arg1)
    }

    public fun is_user_qualified(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool, arg2: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg4: address) : bool {
        assert!(0x2::table::contains<address, vector<u64>>(&arg1.user_stakings, arg4), 2);
        let v0 = 0x2::table::borrow<address, vector<u64>>(&mut arg1.user_stakings, arg4);
        let v1 = 0x1::vector::length<u64>(v0);
        let v2 = 0;
        while (v1 > 0) {
            v2 = v2 + calculate_lp_token_value(arg0, arg2, 0x2::table::borrow<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position_tokens, *0x1::vector::borrow<u64>(v0, v1 - 1)));
            v1 = v1 - 1;
        };
        v2 >= 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::logic::user_health_collateral_value(arg0, arg2, arg3, arg4) * 5 / 100
    }

    fun parse_token_info(arg0: &LiquidityPool, arg1: u64) : (address, u64, u64, u256, u256, u256, u256, u64) {
        let v0 = 0x2::table::borrow<u64, TokenInfo>(&arg0.token_infos, arg1);
        (v0.owner, v0.token_id, v0.locking_type, v0.token_value, v0.token_weight, v0.token_index, v0.token_reward, v0.expiration_timestamp)
    }

    public entry fun relock(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        verify_token_exists(arg1, arg2);
        verfify_token_owner(arg1, arg2, 0x2::tx_context::sender(arg4));
        verfify_token_unlocked(arg1, arg0, arg2);
        update_reward(arg0, arg1);
        update_token_reward(arg0, arg1, arg2);
        excecute_relock(arg1, arg0, arg3, arg2);
    }

    public entry fun set_auto_relock(arg0: &mut LiquidityPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, u64>(&mut arg0.user_autolock_settings, 0x2::tx_context::sender(arg2), arg1);
    }

    public entry fun set_reward_rate(arg0: &DLPAdminCap, arg1: &mut LiquidityPool, arg2: u256) {
        if (arg1.last_timestamp != 0) {
            return
        };
        arg1.reward_rate = arg2;
    }

    public entry fun stake(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &mut LiquidityPool, arg5: &mut StakingRewardPool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 < 0x1::vector::length<u64>(&arg4.locking_types_to_ms), 0);
        assert!(arg6 > 0, 1);
        update_reward(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = calculate_lp_token_value(arg0, arg1, &arg3);
        let v2 = calculate_lp_token_weight(&arg3, *0x1::vector::borrow<u256>(&arg4.locking_multipliers, arg6));
        let v3 = 0;
        if (arg6 > 0) {
            v3 = 0x2::clock::timestamp_ms(arg0) + *0x1::vector::borrow<u64>(&arg4.locking_types_to_ms, arg6);
        };
        assert!(v1 > arg4.minimum_lp_value, 0);
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg4.user_stakings, v0), arg4.token_id_counter);
        0x2::table::add<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg4.position_tokens, arg4.token_id_counter, arg3);
        let v4 = TokenInfo{
            owner                : v0,
            token_id             : arg4.token_id_counter,
            locking_type         : arg6,
            token_value          : v1,
            token_weight         : v2,
            token_index          : arg4.current_index,
            token_reward         : 0,
            expiration_timestamp : v3,
        };
        0x2::table::add<u64, TokenInfo>(&mut arg4.token_infos, arg4.token_id_counter, v4);
        if (!0x2::table::contains<address, u64>(&arg4.user_autolock_settings, v0)) {
            0x2::table::add<address, u64>(&mut arg4.user_autolock_settings, v0, 1);
        };
        arg4.total_staking_weight = arg4.total_staking_weight + v2;
        let v5 = update_user_qualification(arg4, arg0, arg1, arg2, arg5, v0, false, arg7);
        0xfe5f5d6aaf3dcc8ae9c36ecb99348a15c39c2520cf2ea9ca5fb8459c29afc3a7::boosted_reward_distruibutor::update_user_reward_state(v0, v5);
        arg4.token_id_counter = arg4.token_id_counter + 1;
    }

    public entry fun unstake(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut LiquidityPool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg2);
        update_token_reward(arg0, arg2, arg3);
        verfify_token_owner(arg2, arg3, 0x2::tx_context::sender(arg4));
        let TokenInfo {
            owner                : _,
            token_id             : v1,
            locking_type         : _,
            token_value          : _,
            token_weight         : v4,
            token_index          : _,
            token_reward         : _,
            expiration_timestamp : v7,
        } = 0x2::table::remove<u64, TokenInfo>(&mut arg2.token_infos, arg3);
        let v8 = v1;
        assert!(0x2::clock::timestamp_ms(arg0) > v7, 1);
        arg2.total_staking_weight = arg2.total_staking_weight - v4;
        let v9 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg2.user_stakings, 0x2::tx_context::sender(arg4));
        let (_, v11) = 0x1::vector::index_of<u64>(v9, &v8);
        0x1::vector::swap_remove<u64>(v9, v11);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::remove<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.position_tokens, v8), 0x2::tx_context::sender(arg4));
    }

    public fun update_reward(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = dynamic_reward_index(arg1, arg0);
        arg1.current_index = v1;
        arg1.last_timestamp = v0;
    }

    public fun update_token_reward(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool, arg2: u64) {
        verify_token_exists(arg1, arg2);
        let v0 = 0x2::table::borrow_mut<u64, TokenInfo>(&mut arg1.token_infos, arg2);
        v0.token_reward = v0.token_reward + (arg1.current_index - v0.token_index) * v0.token_weight;
        v0.token_index = arg1.current_index;
    }

    public entry fun update_user_expired_lock(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut LiquidityPool, arg3: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg4: &mut StakingRewardPool, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        verify_token_exists(arg2, arg5);
        verfify_token_lock_expired(arg2, arg0, arg5);
        update_reward(arg0, arg2);
        update_token_reward(arg0, arg2, arg5);
        let v0 = 0x2::table::borrow<u64, TokenInfo>(&arg2.token_infos, arg5).owner;
        let v1 = *0x2::table::borrow<address, u64>(&arg2.user_autolock_settings, v0);
        if (v1 > 0) {
            excecute_relock(arg2, arg0, v1, arg5);
        } else {
            deactivate_token(arg2, arg5);
        };
        if (arg6 && v0 != 0x2::tx_context::sender(arg7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg4.maintainer_reward_balance, arg2.maintainer_base_reward), arg7), 0x2::tx_context::sender(arg7));
        };
        update_user_qualification(arg2, arg0, arg1, arg3, arg4, v0, false, arg7);
    }

    public entry fun update_user_qualification(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock, arg2: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg4: &mut StakingRewardPool, arg5: address, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = is_user_qualified(arg1, arg0, arg2, arg3, arg5);
        if (*0x2::table::borrow<address, bool>(&arg0.user_qualifications, arg5) != v0 && arg6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg4.maintainer_reward_balance, arg0.maintainer_base_reward), arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::table::add<address, bool>(&mut arg0.user_qualifications, arg5, v0);
        v0
    }

    fun verfify_token_lock_expired(arg0: &LiquidityPool, arg1: &0x2::clock::Clock, arg2: u64) {
        assert!(0x2::table::borrow<u64, TokenInfo>(&arg0.token_infos, arg2).expiration_timestamp > 0, 0);
        assert!(0x2::clock::timestamp_ms(arg1) > 0x2::table::borrow<u64, TokenInfo>(&arg0.token_infos, arg2).expiration_timestamp, 0);
    }

    fun verfify_token_owner(arg0: &LiquidityPool, arg1: u64, arg2: address) {
        assert!(arg2 == 0x2::table::borrow<u64, TokenInfo>(&arg0.token_infos, arg1).owner, 0);
    }

    fun verfify_token_unlocked(arg0: &LiquidityPool, arg1: &0x2::clock::Clock, arg2: u64) {
        assert!(0x2::clock::timestamp_ms(arg1) > 0x2::table::borrow<u64, TokenInfo>(&arg0.token_infos, arg2).expiration_timestamp, 0);
    }

    fun verify_token_exists(arg0: &LiquidityPool, arg1: u64) {
        assert!(0x2::table::contains<u64, TokenInfo>(&arg0.token_infos, arg1), 0);
    }

    // decompiled from Move bytecode v6
}

