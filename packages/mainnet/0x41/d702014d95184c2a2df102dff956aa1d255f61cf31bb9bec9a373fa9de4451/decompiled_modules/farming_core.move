module 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_core {
    struct BorrowPoolKey has copy, drop, store {
        hearn_addr: address,
        market_id: u64,
    }

    struct Farming has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        operators: vector<address>,
        minors: vector<address>,
        bankers: vector<address>,
        lend_pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
        borrow_pools: 0x2::table::Table<BorrowPoolKey, address>,
        user_lend_pools: 0x2::table::Table<address, vector<address>>,
        user_borrow_pools: 0x2::table::Table<address, vector<address>>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        hearn_addr: address,
        vault_addr: address,
        market_id: u64,
        is_paused: bool,
        boosts: 0x2::vec_map::VecMap<address, u128>,
        model: u8,
        total_shares: u128,
        total_boost_shares: u128,
        staked_balance: 0x2::balance::Balance<T0>,
        positions: 0x2::table::Table<address, Position>,
        reward_configs: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardConfig>,
    }

    struct RewardConfig has store {
        reward_bank_id: address,
        start_time: u64,
        reward_per_second: u64,
        end_time: u64,
        last_update_time: u64,
        acc_reward_per_share: u128,
    }

    struct Position has store {
        shares: u128,
        boost_shares: u128,
        debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
    }

    struct RewardBank<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: address,
        reward_reserve: 0x2::balance::Balance<T0>,
    }

    struct StakeInfo<phantom T0> has key {
        id: 0x2::object::UID,
        pool: address,
        position: address,
    }

    struct ClaimableReward has copy, drop {
        reward_token_type: 0x1::type_name::TypeName,
        reward_bank_id: address,
        amount: u64,
    }

    public(friend) fun add_banker(arg0: &mut Farming, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x1::vector::contains<address>(&arg0.bankers, &arg1), 13);
        0x1::vector::push_back<address>(&mut arg0.bankers, arg1);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_role_update(3, arg1, true, arg2);
    }

    public(friend) fun add_minor(arg0: &mut Farming, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x1::vector::contains<address>(&arg0.minors, &arg1), 13);
        0x1::vector::push_back<address>(&mut arg0.minors, arg1);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_role_update(2, arg1, true, arg2);
    }

    public(friend) fun add_operator(arg0: &mut Farming, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x1::vector::contains<address>(&arg0.operators, &arg1), 13);
        0x1::vector::push_back<address>(&mut arg0.operators, arg1);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_role_update(1, arg1, true, arg2);
    }

    public(friend) fun add_reward_config<T0, T1>(arg0: &Farming, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : address {
        assert_version(arg0);
        assert_minor(arg0, 0x2::tx_context::sender(arg6));
        assert!(arg3 < arg4, 0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg1.reward_configs, &v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v2 = if (v1 > arg4) {
            arg4
        } else {
            v1
        };
        let v3 = RewardBank<T1>{
            id             : 0x2::object::new(arg6),
            pool_id        : pool_id<T0>(arg1),
            reward_reserve : 0x2::balance::zero<T1>(),
        };
        let v4 = reward_bank_id<T1>(&v3);
        let v5 = RewardConfig{
            reward_bank_id       : v4,
            start_time           : arg3,
            reward_per_second    : arg2,
            end_time             : arg4,
            last_update_time     : v2,
            acc_reward_per_share : 0,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, RewardConfig>(&mut arg1.reward_configs, v0, v5);
        0x2::transfer::share_object<RewardBank<T1>>(v3);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_reward_config_add(pool_id<T0>(arg1), v4, 0x1::type_name::with_defining_ids<T1>(), arg3, arg2, arg4, arg6);
        v4
    }

    fun add_user_borrow_pool(arg0: &mut Farming, arg1: address, arg2: address) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_borrow_pools, arg1)) {
            0x2::table::add<address, vector<address>>(&mut arg0.user_borrow_pools, arg1, 0x1::vector::singleton<address>(arg2));
        } else {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_borrow_pools, arg1);
            if (!0x1::vector::contains<address>(v0, &arg2)) {
                0x1::vector::push_back<address>(v0, arg2);
            };
        };
    }

    fun add_user_lend_pool(arg0: &mut Farming, arg1: address, arg2: address) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_lend_pools, arg1)) {
            0x2::table::add<address, vector<address>>(&mut arg0.user_lend_pools, arg1, 0x1::vector::singleton<address>(arg2));
        } else {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_lend_pools, arg1);
            if (!0x1::vector::contains<address>(v0, &arg2)) {
                0x1::vector::push_back<address>(v0, arg2);
            };
        };
    }

    public(friend) fun assert_banker(arg0: &Farming, arg1: address) {
        let v0 = if (is_owner(arg0, arg1)) {
            true
        } else if (is_operator(arg0, arg1)) {
            true
        } else {
            is_banker(arg0, arg1)
        };
        assert!(v0, 12);
    }

    fun assert_borrow_market_match<T0>(arg0: &Pool<T0>, arg1: &0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::Hearn, arg2: u64) {
        assert!(arg0.hearn_addr == 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::hearn_address(arg1), 17);
        assert!(arg0.market_id == arg2, 17);
    }

    fun assert_market_borrow_model<T0>(arg0: &Pool<T0>) {
        assert!(arg0.model == 2, 7);
    }

    public(friend) fun assert_minor(arg0: &Farming, arg1: address) {
        let v0 = if (is_owner(arg0, arg1)) {
            true
        } else if (is_operator(arg0, arg1)) {
            true
        } else {
            is_minor(arg0, arg1)
        };
        assert!(v0, 11);
    }

    public(friend) fun assert_operator(arg0: &Farming, arg1: address) {
        assert!(is_owner(arg0, arg1) || is_operator(arg0, arg1), 10);
    }

    public(friend) fun assert_owner(arg0: &Farming, arg1: address) {
        assert!(is_owner(arg0, arg1), 8);
    }

    public(friend) fun assert_reward_bank<T0, T1>(arg0: &Pool<T0>, arg1: &RewardBank<T1>) {
        assert!(arg1.pool_id == pool_id<T0>(arg0), 6);
    }

    fun assert_vault_lend_model<T0>(arg0: &Pool<T0>) {
        assert!(arg0.model == 1, 7);
    }

    fun assert_version(arg0: &Farming) {
        assert!(arg0.version == 1, 20);
    }

    fun calc_pool_acc_reward_per_share(arg0: &RewardConfig, arg1: u128, arg2: u64) : u128 {
        let v0 = arg0.last_update_time;
        let v1 = v0;
        if (v0 < arg0.start_time) {
            v1 = arg0.start_time;
        };
        let v2 = arg2;
        if (arg2 > arg0.end_time) {
            v2 = arg0.end_time;
        };
        let v3 = if (v2 <= v1) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0.reward_per_second == 0
        };
        if (v3) {
            return arg0.acc_reward_per_share
        };
        arg0.acc_reward_per_share + 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::math::mul_div_down(checked_mul_u128(((v2 - v1) as u128), (arg0.reward_per_second as u128)), 1000000000000, arg1)
    }

    fun calc_user_boost_shares<T0>(arg0: &Pool<T0>, arg1: &address, arg2: u128) : u128 {
        if (arg2 == 0) {
            return 0
        };
        checked_mul_u128(arg2, get_boost<T0>(arg0, arg1)) / 1000
    }

    fun checked_mul_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        if (v0 / arg0 != arg1) {
            abort 3
        };
        v0
    }

    public(friend) fun claim<T0, T1>(arg0: &mut Farming, arg1: &mut Pool<T0>, arg2: &mut RewardBank<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        assert_version(arg0);
        assert!(!arg1.is_paused, 19);
        assert_reward_bank<T0, T1>(arg1, arg2);
        update_pool_acc_reward_per_share<T0>(arg1, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = take_position<T0>(arg1, v0);
        let v2 = &mut v1;
        update_user_postion_pending(v2, &arg1.reward_configs);
        let v3 = &mut v1;
        update_user_postion_debts(v3, &arg1.reward_configs);
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        let v5 = map_get_u128(&v1.pending_rewards, &v4);
        if (v5 == 0) {
            store_or_delete_position_if_empty<T0>(arg0, arg1, v0, v1);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        assert!(v5 <= (0x2::balance::value<T1>(&arg2.reward_reserve) as u128), 21);
        let v6 = &mut v1.pending_rewards;
        map_set_u128(v6, v4, v5 - v5);
        store_or_delete_position_if_empty<T0>(arg0, arg1, v0, v1);
        let v7 = 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::math::to_u64(v5);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_claim(pool_id<T0>(arg1), v4, v0, v7, arg4);
        0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.reward_reserve, v7), arg4))
    }

    fun clamp_time_for_reward(arg0: &RewardConfig, arg1: u64) : u64 {
        let v0 = arg1;
        if (arg1 > arg0.end_time) {
            v0 = arg0.end_time;
        };
        v0
    }

    public(friend) fun create_borrow_pool<T0>(arg0: &mut Farming, arg1: &0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::Hearn, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : address {
        assert_version(arg0);
        assert_minor(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::hearn_address(arg1);
        let v1 = BorrowPoolKey{
            hearn_addr : v0,
            market_id  : arg2,
        };
        assert!(!0x2::table::contains<BorrowPoolKey, address>(&arg0.borrow_pools, v1), 16);
        let v2 = new_pool<T0>(arg3, 2, v0, @0x0, arg2);
        let v3 = pool_id<T0>(&v2);
        0x2::transfer::share_object<Pool<T0>>(v2);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_pool_create(v3, 0x1::type_name::with_defining_ids<T0>(), 2, arg2, v0, @0x0, arg3);
        0x2::table::add<BorrowPoolKey, address>(&mut arg0.borrow_pools, v1, v3);
        v3
    }

    public(friend) fun create_lend_pool<T0, T1>(arg0: &mut Farming, arg1: &0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::Hearn, arg2: &0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::meta_vault_core::Vault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : address {
        assert_version(arg0);
        assert_minor(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::hearn_address(arg1);
        let v1 = 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::meta_vault_core::vault_id<T0, T1>(arg2);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.lend_pools, v2), 15);
        let v3 = new_pool<T1>(arg3, 1, v0, v1, 0);
        let v4 = pool_id<T1>(&v3);
        0x2::transfer::share_object<Pool<T1>>(v3);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_pool_create(v4, v2, 1, 0, v0, v1, arg3);
        0x2::table::add<0x1::type_name::TypeName, address>(&mut arg0.lend_pools, v2, v4);
        v4
    }

    fun create_stake_info<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : StakeInfo<T0> {
        StakeInfo<T0>{
            id       : 0x2::object::new(arg2),
            pool     : arg0,
            position : arg1,
        }
    }

    public(friend) fun del_banker(arg0: &mut Farming, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.bankers, &arg1);
        assert!(v0, 14);
        0x1::vector::remove<address>(&mut arg0.bankers, v1);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_role_update(3, arg1, false, arg2);
    }

    public(friend) fun del_minor(arg0: &mut Farming, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.minors, &arg1);
        assert!(v0, 14);
        0x1::vector::remove<address>(&mut arg0.minors, v1);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_role_update(2, arg1, false, arg2);
    }

    public(friend) fun del_operator(arg0: &mut Farming, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg1);
        assert!(v0, 14);
        0x1::vector::remove<address>(&mut arg0.operators, v1);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_role_update(1, arg1, false, arg2);
    }

    fun destroy_vec_map_u128(arg0: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>) {
        while (0x2::vec_map::length<0x1::type_name::TypeName, u128>(&arg0) > 0) {
            let (v0, _) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&arg0, 0);
            let v2 = *v0;
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg0, &v2);
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u128>(arg0);
    }

    public(friend) fun extract_reward_bank<T0, T1>(arg0: &Farming, arg1: &Pool<T0>, arg2: &mut RewardBank<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version(arg0);
        assert_banker(arg0, 0x2::tx_context::sender(arg4));
        assert_reward_bank<T0, T1>(arg1, arg2);
        let v0 = if (arg3 == 0) {
            0x2::balance::value<T1>(&arg2.reward_reserve)
        } else {
            arg3
        };
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_reward_bank_extract(pool_id<T0>(arg1), reward_bank_id<T1>(arg2), 0x1::type_name::with_defining_ids<T1>(), v0, arg4);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.reward_reserve, v0), arg4)
    }

    public fun farming_borrow_pool_id(arg0: &Farming, arg1: &0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::Hearn, arg2: u64) : (0x1::option::Option<address>, bool) {
        let v0 = BorrowPoolKey{
            hearn_addr : 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::hearn_address(arg1),
            market_id  : arg2,
        };
        if (!0x2::table::contains<BorrowPoolKey, address>(&arg0.borrow_pools, v0)) {
            (0x1::option::none<address>(), false)
        } else {
            (0x1::option::some<address>(*0x2::table::borrow<BorrowPoolKey, address>(&arg0.borrow_pools, v0)), true)
        }
    }

    public fun farming_lend_pool_id<T0>(arg0: &Farming) : (0x1::option::Option<address>, bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.lend_pools, v0)) {
            (0x1::option::none<address>(), false)
        } else {
            (0x1::option::some<address>(*0x2::table::borrow<0x1::type_name::TypeName, address>(&arg0.lend_pools, v0)), true)
        }
    }

    public(friend) fun fund_reward_bank<T0, T1>(arg0: &Farming, arg1: &Pool<T0>, arg2: &mut RewardBank<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::tx_context::TxContext) : u64 {
        assert_version(arg0);
        assert_banker(arg0, 0x2::tx_context::sender(arg4));
        assert_reward_bank<T0, T1>(arg1, arg2);
        let v0 = 0x2::coin::value<T1>(&arg3);
        0x2::balance::join<T1>(&mut arg2.reward_reserve, 0x2::coin::into_balance<T1>(arg3));
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_reward_bank_fund(pool_id<T0>(arg1), reward_bank_id<T1>(arg2), 0x1::type_name::with_defining_ids<T1>(), v0, arg4);
        v0
    }

    public fun get_boost<T0>(arg0: &Pool<T0>, arg1: &address) : u128 {
        if (!0x2::vec_map::contains<address, u128>(&arg0.boosts, arg1)) {
            return 1000
        };
        *0x2::vec_map::get<address, u128>(&arg0.boosts, arg1)
    }

    public fun get_claimable_rewards<T0>(arg0: &Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<ClaimableReward> {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0x1::vector::empty<ClaimableReward>()
        };
        let v0 = 0x2::table::borrow<address, Position>(&arg0.positions, arg1);
        let v1 = 0x1::vector::empty<ClaimableReward>();
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, v2);
            let v5 = 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::math::mul_div_down(v0.boost_shares, calc_pool_acc_reward_per_share(v4, arg0.total_boost_shares, 0x2::clock::timestamp_ms(arg2) / 1000), 1000000000000);
            let v6 = map_get_u128(&v0.debts, v3);
            let v7 = map_get_u128(&v0.pending_rewards, v3);
            let v8 = v7;
            if (v5 > v6) {
                v8 = v7 + v5 - v6;
            };
            if (v8 > 0) {
                let v9 = ClaimableReward{
                    reward_token_type : *v3,
                    reward_bank_id    : v4.reward_bank_id,
                    amount            : 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::math::to_u64_saturating(v8),
                };
                0x1::vector::push_back<ClaimableReward>(&mut v1, v9);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_position_boost_shares<T0>(arg0: &Pool<T0>, arg1: address) : u128 {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Position>(&arg0.positions, arg1).boost_shares
    }

    public fun get_position_shares<T0>(arg0: &Pool<T0>, arg1: address) : u128 {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Position>(&arg0.positions, arg1).shares
    }

    public fun get_user_borrow_pools(arg0: &Farming, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_borrow_pools, arg1)) {
            0x1::vector::empty<address>()
        } else {
            *0x2::table::borrow<address, vector<address>>(&arg0.user_borrow_pools, arg1)
        }
    }

    public fun get_user_lend_pools(arg0: &Farming, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_lend_pools, arg1)) {
            0x1::vector::empty<address>()
        } else {
            *0x2::table::borrow<address, vector<address>>(&arg0.user_lend_pools, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v0);
        let v4 = Farming{
            id                : 0x2::object::new(arg0),
            version           : 1,
            owner             : v0,
            operators         : v1,
            minors            : v2,
            bankers           : v3,
            lend_pools        : 0x2::table::new<0x1::type_name::TypeName, address>(arg0),
            borrow_pools      : 0x2::table::new<BorrowPoolKey, address>(arg0),
            user_lend_pools   : 0x2::table::new<address, vector<address>>(arg0),
            user_borrow_pools : 0x2::table::new<address, vector<address>>(arg0),
        };
        0x2::transfer::share_object<Farming>(v4);
    }

    public fun is_banker(arg0: &Farming, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.bankers, &arg1)
    }

    public fun is_minor(arg0: &Farming, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.minors, &arg1)
    }

    public fun is_operator(arg0: &Farming, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_owner(arg0: &Farming, arg1: address) : bool {
        arg0.owner == arg1
    }

    fun map_add_u128(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>, arg1: 0x1::type_name::TypeName, arg2: u128) {
        if (arg2 == 0) {
            return
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(arg0, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(arg0, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(arg0, arg1, arg2);
        };
    }

    fun map_get_u128(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>, arg1: &0x1::type_name::TypeName) : u128 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(arg0, arg1)) {
            0
        } else {
            *0x2::vec_map::get<0x1::type_name::TypeName, u128>(arg0, arg1)
        }
    }

    fun map_set_u128(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>, arg1: 0x1::type_name::TypeName, arg2: u128) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u128>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(arg0, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(arg0, arg1, arg2);
        };
    }

    public(friend) fun migrate(arg0: &mut Farming, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg0.version < 1, 20);
        arg0.version = 1;
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_migrate(arg0.version, arg1);
    }

    public(friend) fun new_pool<T0>(arg0: &mut 0x2::tx_context::TxContext, arg1: u8, arg2: address, arg3: address, arg4: u64) : Pool<T0> {
        assert!(arg1 == 1 || arg1 == 2, 7);
        Pool<T0>{
            id                 : 0x2::object::new(arg0),
            hearn_addr         : arg2,
            vault_addr         : arg3,
            market_id          : arg4,
            is_paused          : false,
            boosts             : 0x2::vec_map::empty<address, u128>(),
            model              : arg1,
            total_shares       : 0,
            total_boost_shares : 0,
            staked_balance     : 0x2::balance::zero<T0>(),
            positions          : 0x2::table::new<address, Position>(arg0),
            reward_configs     : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardConfig>(),
        }
    }

    public(friend) fun pause<T0>(arg0: &Farming, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_minor(arg0, 0x2::tx_context::sender(arg3));
        update_pool_acc_reward_per_share<T0>(arg1, arg2);
        arg1.is_paused = true;
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_pool_pause(pool_id<T0>(arg1), arg3);
    }

    public fun pool_id<T0>(arg0: &Pool<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun pool_is_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.is_paused
    }

    public fun pool_total_shares<T0>(arg0: &Pool<T0>) : u128 {
        arg0.total_shares
    }

    fun remove_user_borrow_pool(arg0: &mut Farming, arg1: address, arg2: address) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_borrow_pools, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_borrow_pools, arg1);
        let (v1, v2) = 0x1::vector::index_of<address>(v0, &arg2);
        if (v1) {
            0x1::vector::remove<address>(v0, v2);
        };
        if (0x1::vector::length<address>(v0) == 0) {
            0x2::table::remove<address, vector<address>>(&mut arg0.user_borrow_pools, arg1);
        };
    }

    fun remove_user_lend_pool(arg0: &mut Farming, arg1: address, arg2: address) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_lend_pools, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_lend_pools, arg1);
        let (v1, v2) = 0x1::vector::index_of<address>(v0, &arg2);
        if (v1) {
            0x1::vector::remove<address>(v0, v2);
        };
        if (0x1::vector::length<address>(v0) == 0) {
            0x2::table::remove<address, vector<address>>(&mut arg0.user_lend_pools, arg1);
        };
    }

    public(friend) fun resume<T0>(arg0: &Farming, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_minor(arg0, 0x2::tx_context::sender(arg3));
        update_pool_acc_reward_per_share<T0>(arg1, arg2);
        arg1.is_paused = false;
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_pool_resume(pool_id<T0>(arg1), arg3);
    }

    public fun reward_bank_id<T0>(arg0: &RewardBank<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun set_boost<T0>(arg0: &Farming, arg1: &mut Pool<T0>, arg2: address, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_operator(arg0, 0x2::tx_context::sender(arg5));
        update_pool_acc_reward_per_share<T0>(arg1, arg4);
        let v0 = take_position<T0>(arg1, arg2);
        let v1 = &mut v0;
        update_user_postion_pending(v1, &arg1.reward_configs);
        let v2 = if (v0.shares == 0) {
            0
        } else {
            checked_mul_u128(v0.shares, arg3) / 1000
        };
        arg1.total_boost_shares = arg1.total_boost_shares - v0.boost_shares + v2;
        v0.boost_shares = v2;
        let v3 = &mut v0;
        update_user_postion_debts(v3, &arg1.reward_configs);
        store_position<T0>(arg1, arg2, v0);
        update_boost<T0>(arg1, arg2, arg3);
    }

    public(friend) fun set_reward_config<T0, T1>(arg0: &Farming, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_minor(arg0, 0x2::tx_context::sender(arg6));
        assert!(arg3 < arg4, 0);
        update_pool_acc_reward_per_share<T0>(arg1, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg1.reward_configs, &v0), 5);
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg1.reward_configs, &v0);
        v1.start_time = arg3;
        v1.reward_per_second = arg2;
        v1.end_time = arg4;
        v1.last_update_time = clamp_time_for_reward(v1, 0x2::clock::timestamp_ms(arg5) / 1000);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_reward_config_update(pool_id<T0>(arg1), v1.reward_bank_id, v0, v1.start_time, v1.reward_per_second, v1.end_time, arg6);
    }

    public(friend) fun stake<T0>(arg0: &mut Farming, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_vault_lend_model<T0>(arg1);
        assert!(!arg1.is_paused, 19);
        let v0 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = !0x2::table::contains<address, Position>(&arg1.positions, v1);
        0x2::balance::join<T0>(&mut arg1.staked_balance, 0x2::coin::into_balance<T0>(arg2));
        stake_account<T0>(arg0, arg1, v1, v0, true, arg3);
        if (v2) {
            add_user_lend_pool(arg0, v1, pool_id<T0>(arg1));
            let v3 = create_stake_info<T0>(pool_id<T0>(arg1), v1, arg4);
            0x2::transfer::transfer<StakeInfo<T0>>(v3, v1);
        };
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_stake(pool_id<T0>(arg1), v1, v0, arg1.total_shares, arg4);
    }

    fun stake_account<T0>(arg0: &mut Farming, arg1: &mut Pool<T0>, arg2: address, arg3: u128, arg4: bool, arg5: &0x2::clock::Clock) {
        if (arg3 == 0) {
            return
        };
        update_pool_acc_reward_per_share<T0>(arg1, arg5);
        let v0 = take_position<T0>(arg1, arg2);
        let v1 = &mut v0;
        update_user_postion_pending(v1, &arg1.reward_configs);
        let v2 = &mut v0;
        update_shares<T0>(arg1, &arg2, v2, arg3, arg4);
        let v3 = &mut v0;
        update_user_postion_debts(v3, &arg1.reward_configs);
        store_or_delete_position_if_empty<T0>(arg0, arg1, arg2, v0);
    }

    public(friend) fun stake_adjust<T0>(arg0: &mut Farming, arg1: &mut Pool<T0>, arg2: &0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::Hearn, arg3: u64, arg4: address, arg5: u128, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        if (arg5 == 0) {
            return
        };
        assert_market_borrow_model<T0>(arg1);
        assert_borrow_market_match<T0>(arg1, arg2, arg3);
        let v0 = if (arg6) {
            !0x2::table::contains<address, Position>(&arg1.positions, arg4)
        } else {
            false
        };
        stake_account<T0>(arg0, arg1, arg4, arg5, arg6, arg7);
        if (v0) {
            add_user_borrow_pool(arg0, arg4, pool_id<T0>(arg1));
        };
        if (arg6) {
            0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_stake(pool_id<T0>(arg1), arg4, arg5, arg1.total_shares, arg8);
        } else {
            0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_unstake(pool_id<T0>(arg1), arg4, arg5, arg1.total_shares, arg8);
        };
    }

    fun store_or_delete_position_if_empty<T0>(arg0: &mut Farming, arg1: &mut Pool<T0>, arg2: address, arg3: Position) {
        let v0 = arg3.shares == 0 && vec_map_all_zero(&arg3.pending_rewards);
        if (!v0) {
            store_position<T0>(arg1, arg2, arg3);
            return
        };
        if (arg1.model == 1) {
            remove_user_lend_pool(arg0, arg2, pool_id<T0>(arg1));
        } else {
            remove_user_borrow_pool(arg0, arg2, pool_id<T0>(arg1));
        };
        let Position {
            shares          : _,
            boost_shares    : _,
            debts           : v3,
            pending_rewards : v4,
        } = arg3;
        destroy_vec_map_u128(v4);
        destroy_vec_map_u128(v3);
    }

    fun store_position<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: Position) {
        0x2::table::add<address, Position>(&mut arg0.positions, arg1, arg2);
    }

    fun take_position<T0>(arg0: &mut Pool<T0>, arg1: address) : Position {
        if (0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            0x2::table::remove<address, Position>(&mut arg0.positions, arg1)
        } else {
            Position{shares: 0, boost_shares: 0, debts: 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(), pending_rewards: 0x2::vec_map::empty<0x1::type_name::TypeName, u128>()}
        }
    }

    public(friend) fun unstake<T0>(arg0: &mut Farming, arg1: &mut Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg0);
        assert_vault_lend_model<T0>(arg1);
        assert!(!arg1.is_paused, 19);
        assert!(arg2 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        stake_account<T0>(arg0, arg1, v0, arg2, false, arg3);
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::farming_events::emit_unstake(pool_id<T0>(arg1), v0, arg2, arg1.total_shares, arg4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.staked_balance, 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::math::to_u64(arg2)), arg4)
    }

    fun update_boost<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: u128) {
        if (0x2::vec_map::contains<address, u128>(&arg0.boosts, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u128>(&mut arg0.boosts, &arg1);
        };
        if (arg2 != 1000) {
            0x2::vec_map::insert<address, u128>(&mut arg0.boosts, arg1, arg2);
        };
    }

    fun update_pool_acc_reward_per_share<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, v0);
            update_reward_config(v2, arg0.total_boost_shares, arg1);
            v0 = v0 + 1;
        };
    }

    fun update_reward_config(arg0: &mut RewardConfig, arg1: u128, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        arg0.acc_reward_per_share = calc_pool_acc_reward_per_share(arg0, arg1, v0);
        arg0.last_update_time = clamp_time_for_reward(arg0, v0);
    }

    fun update_shares<T0>(arg0: &mut Pool<T0>, arg1: &address, arg2: &mut Position, arg3: u128, arg4: bool) {
        if (arg3 == 0) {
            return
        };
        if (arg4) {
            arg2.shares = arg2.shares + arg3;
            arg0.total_shares = arg0.total_shares + arg3;
        } else {
            assert!(arg2.shares >= arg3, 2);
            arg2.shares = arg2.shares - arg3;
            arg0.total_shares = arg0.total_shares - arg3;
        };
        let v0 = calc_user_boost_shares<T0>(arg0, arg1, arg2.shares);
        arg2.boost_shares = v0;
        arg0.total_boost_shares = arg0.total_boost_shares - arg2.boost_shares + v0;
    }

    fun update_user_postion_debts(arg0: &mut Position, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardConfig>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, RewardConfig>(arg1)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, RewardConfig>(arg1, v0);
            let v3 = &mut arg0.debts;
            map_set_u128(v3, *v1, 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::math::mul_div_down(arg0.boost_shares, v2.acc_reward_per_share, 1000000000000));
            v0 = v0 + 1;
        };
    }

    fun update_user_postion_pending(arg0: &mut Position, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardConfig>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, RewardConfig>(arg1)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, RewardConfig>(arg1, v0);
            let v3 = 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::math::mul_div_down(arg0.boost_shares, v2.acc_reward_per_share, 1000000000000);
            let v4 = map_get_u128(&arg0.debts, v1);
            if (v3 > v4) {
                let v5 = &mut arg0.pending_rewards;
                map_add_u128(v5, *v1, v3 - v4);
            };
            v0 = v0 + 1;
        };
    }

    fun vec_map_all_zero(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>) : bool {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, u128>(arg0)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(arg0, v0);
            if (*v2 != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

