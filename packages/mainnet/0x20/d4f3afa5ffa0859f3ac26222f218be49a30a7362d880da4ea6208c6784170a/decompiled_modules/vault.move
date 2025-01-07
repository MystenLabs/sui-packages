module 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::vault {
    struct Period has drop, store {
        duration_time: u64,
        reward_per_ms: u64,
    }

    struct PoolConfig has store {
        pool_weight: u64,
        last_reward_time: u64,
        acc_reward_per_lp_value: u64,
        pool_value: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        total_pool_weight: u64,
        start_time: u64,
        end_time: u64,
        periods: vector<Period>,
        pool_configs: vector<PoolConfig>,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        pool_index: u64,
    }

    struct Farm has store, key {
        id: 0x2::object::UID,
        lp_value: u64,
        finished_value: u64,
        owner: address,
    }

    struct InitEvent has copy, drop {
        sender: address,
        pause_status_id: 0x2::object::ID,
    }

    struct VaultCreateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
    }

    struct VaultEditEvent has copy, drop {
        vault_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
    }

    struct VaultAddPeriodEvent has copy, drop {
        vault_id: 0x2::object::ID,
        period_index: u64,
        duration_time: u64,
        start_time: u64,
        end_time: u64,
        reward_per_ms: u64,
    }

    struct VaultRemovePeriodEvent has copy, drop {
        vault_id: 0x2::object::ID,
        period_index: u64,
        duration_time: u64,
        start_time: u64,
        end_time: u64,
        reward_per_ms: u64,
    }

    struct VaultEditPeriodEvent has copy, drop {
        vault_id: 0x2::object::ID,
        period_index: u64,
        duration_time: u64,
        start_time: u64,
        end_time: u64,
        reward_per_ms: u64,
    }

    struct PoolConfigAddEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_weight: u64,
        last_reward_time: u64,
        pool_index: u64,
    }

    struct PoolCreateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        pool_index: u64,
    }

    struct PoolUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_index: u64,
        last_reward_time: u64,
        pool_reward: u64,
    }

    struct FarmCreateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        lp_position_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        value: u64,
    }

    struct FarmRemoveEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        lp_position_id: 0x2::object::ID,
        value: u64,
        reward: u64,
    }

    public entry fun add_period(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.end_time + 1;
        let v1 = arg1.end_time + arg2;
        if (arg1.end_time == 0) {
            v0 = arg1.start_time;
            v1 = arg1.start_time + arg2 - 1;
        };
        let v2 = Period{
            duration_time : arg2,
            reward_per_ms : arg3,
        };
        0x1::vector::push_back<Period>(&mut arg1.periods, v2);
        arg1.end_time = v1;
        let v3 = VaultAddPeriodEvent{
            vault_id      : 0x2::object::id<Vault>(arg1),
            period_index  : 0x1::vector::length<Period>(&arg1.periods) - 1,
            duration_time : arg2,
            start_time    : v0,
            end_time      : v1,
            reward_per_ms : arg3,
        };
        0x2::event::emit<VaultAddPeriodEvent>(v3);
    }

    public entry fun add_pool_config(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg1.end_time, 1);
        mass_update_pools(arg1, arg2, arg4);
        let v1 = v0;
        if (v0 < arg1.start_time) {
            v1 = arg1.start_time;
        };
        arg1.total_pool_weight = arg1.total_pool_weight + arg3;
        let v2 = PoolConfig{
            pool_weight             : arg3,
            last_reward_time        : v1,
            acc_reward_per_lp_value : 0,
            pool_value              : 0,
        };
        0x1::vector::push_back<PoolConfig>(&mut arg1.pool_configs, v2);
        let v3 = PoolConfigAddEvent{
            vault_id         : 0x2::object::id<Vault>(arg1),
            pool_weight      : arg3,
            last_reward_time : v1,
            pool_index       : 0x1::vector::length<PoolConfig>(&arg1.pool_configs) - 1,
        };
        0x2::event::emit<PoolConfigAddEvent>(v3);
    }

    public entry fun create_pool<T0>(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id         : 0x2::object::new(arg3),
            vault_id   : 0x2::object::id<Vault>(arg1),
            pool_index : arg2,
        };
        let v1 = PoolCreateEvent{
            vault_id   : 0x2::object::id<Vault>(arg1),
            pool_id    : 0x2::object::id<Pool<T0>>(&v0),
            pool_index : arg2,
        };
        0x2::event::emit<PoolCreateEvent>(v1);
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    public entry fun create_vault(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = Vault{
            id                : 0x2::object::new(arg2),
            total_pool_weight : 0,
            start_time        : arg1,
            end_time          : v0,
            periods           : 0x1::vector::empty<Period>(),
            pool_configs      : 0x1::vector::empty<PoolConfig>(),
        };
        let v2 = VaultCreateEvent{
            vault_id   : 0x2::object::id<Vault>(&v1),
            start_time : arg1,
            end_time   : v0,
        };
        0x2::event::emit<VaultCreateEvent>(v2);
        0x2::transfer::public_share_object<Vault>(v1);
    }

    public entry fun deposit<T0: store + key>(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::config::PauseStatus, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &mut Pool<T0>, arg4: T0, arg5: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::pubkey::PublicKey, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::config::assert_pause(arg0);
        let v0 = 0x2::address::to_string(0x2::object::id_address<T0>(&arg4));
        0x1::string::append(&mut v0, 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::utils::u64_to_string(arg6));
        0x1::string::append(&mut v0, 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::utils::u64_to_string(arg7));
        let v1 = 0x2::hash::blake2b256(0x1::string::bytes(&v0));
        assert!(0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::pubkey::verify(&arg8, arg5, &v1), 3);
        update_pool_by_index(arg1, arg2, arg3.pool_index, arg9);
        let v2 = 0x2::tx_context::sender(arg9);
        let v3 = 0x1::vector::borrow_mut<PoolConfig>(&mut arg1.pool_configs, arg3.pool_index);
        let v4 = Farm{
            id             : 0x2::object::new(arg9),
            lp_value       : arg6,
            finished_value : arg6 * v3.acc_reward_per_lp_value,
            owner          : v2,
        };
        v3.pool_value = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_add_u64(v3.pool_value, arg6);
        let v5 = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::position::mint(0x2::object::id<Pool<T0>>(arg3), 0x2::object::id<Farm>(&v4), 0x2::object::id<T0>(&arg4), arg6, 0x2::clock::timestamp_ms(arg2), arg9);
        let v6 = FarmCreateEvent{
            vault_id       : 0x2::object::id<Vault>(arg1),
            pool_id        : 0x2::object::id<Pool<T0>>(arg3),
            farm_id        : 0x2::object::id<Farm>(&v4),
            lp_position_id : 0x2::object::id<T0>(&arg4),
            position_id    : 0x2::object::id<0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::position::Position>(&v5),
            value          : arg6,
        };
        0x2::event::emit<FarmCreateEvent>(v6);
        0x2::transfer::public_transfer<0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::position::Position>(v5, v2);
        0x2::dynamic_object_field::add<bool, T0>(&mut v4.id, true, arg4);
        0x2::dynamic_object_field::add<0x2::object::ID, Farm>(&mut arg3.id, 0x2::object::id<Farm>(&v4), v4);
    }

    public entry fun edit_period(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Period>(&mut arg1.periods, arg2);
        arg1.end_time = arg1.end_time - v0.duration_time + arg3;
        v0.duration_time = arg3;
        v0.reward_per_ms = arg4;
        let v1 = 0;
        let v2 = 0;
        while (v1 < arg2) {
            v2 = v2 + 0x1::vector::borrow<Period>(&arg1.periods, v1).duration_time;
            v1 = v1 + 1;
        };
        let v3 = v2 + 1;
        let v4 = VaultEditPeriodEvent{
            vault_id      : 0x2::object::id<Vault>(arg1),
            period_index  : arg2,
            duration_time : arg3,
            start_time    : v3,
            end_time      : v3 + arg3 - 1,
            reward_per_ms : arg4,
        };
        0x2::event::emit<VaultEditPeriodEvent>(v4);
    }

    public entry fun edit_vault(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        let v0 = VaultEditEvent{
            vault_id   : 0x2::object::id<Vault>(arg1),
            start_time : arg2,
            end_time   : arg3,
        };
        0x2::event::emit<VaultEditEvent>(v0);
    }

    public fun get_multiplier(arg0: &Vault, arg1: u64, arg2: u64) : u64 {
        if (arg1 < arg0.start_time) {
            arg1 = arg0.start_time;
        };
        if (arg2 > arg0.end_time) {
            arg2 = arg0.end_time;
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0.start_time;
        while (v1 < 0x1::vector::length<Period>(&arg0.periods)) {
            let v3 = 0x1::vector::borrow<Period>(&arg0.periods, v1);
            let v4 = v2 + v3.duration_time - 1;
            if (arg1 >= v2) {
                if (arg2 <= v4) {
                    v0 = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_add_u64(v0, 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_mul_u64(arg2 - arg1 + 1, v3.reward_per_ms));
                    break
                };
                v0 = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_add_u64(v0, 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_mul_u64(v3.duration_time, v3.reward_per_ms));
                arg1 = v4 + 1;
                v2 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitEvent{
            sender          : 0x2::tx_context::sender(arg0),
            pause_status_id : 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::config::new_pause_status(arg0),
        };
        0x2::event::emit<InitEvent>(v0);
    }

    public entry fun mass_update_pools(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolConfig>(&arg0.pool_configs)) {
            update_pool_by_index(arg0, arg1, v0, arg2);
            v0 = v0 + 1;
        };
    }

    public entry fun remove_period(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<Period>(&arg1.periods, arg2);
        arg1.end_time = arg1.end_time - v0.duration_time;
        let v1 = VaultRemovePeriodEvent{
            vault_id      : 0x2::object::id<Vault>(arg1),
            period_index  : arg2,
            duration_time : v0.duration_time,
            start_time    : arg1.start_time,
            end_time      : arg1.end_time,
            reward_per_ms : v0.reward_per_ms,
        };
        0x2::event::emit<VaultRemovePeriodEvent>(v1);
        0x1::vector::remove<Period>(&mut arg1.periods, arg2);
    }

    public entry fun update_pool_by_index(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x1::vector::borrow<PoolConfig>(&mut arg0.pool_configs, arg2);
        if (v0 <= v1.last_reward_time) {
            return
        };
        let v2 = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_div_u64(0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_mul_u64(get_multiplier(arg0, v1.last_reward_time, v0), v1.pool_weight), arg0.total_pool_weight);
        let v3 = 0x1::vector::borrow_mut<PoolConfig>(&mut arg0.pool_configs, arg2);
        if (v3.pool_value > 0) {
            v3.acc_reward_per_lp_value = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_add_u64(v3.acc_reward_per_lp_value, 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_div_u64(v2, v3.pool_value));
        };
        v3.last_reward_time = v0;
        let v4 = PoolUpdateEvent{
            vault_id         : 0x2::object::id<Vault>(arg0),
            pool_index       : arg2,
            last_reward_time : v0,
            pool_reward      : v2,
        };
        0x2::event::emit<PoolUpdateEvent>(v4);
    }

    public entry fun withdraw<T0: store + key, T1>(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::config::PauseStatus, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &mut Pool<T0>, arg4: &mut 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::wallet::Wallet<T1>, arg5: 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::position::Position, arg6: &mut 0x2::tx_context::TxContext) {
        0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::config::assert_pause(arg0);
        update_pool_by_index(arg1, arg2, arg3.pool_index, arg6);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::borrow_mut<PoolConfig>(&mut arg1.pool_configs, arg3.pool_index);
        let v2 = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::position::get_farm_id(&arg5);
        let Farm {
            id             : v3,
            lp_value       : v4,
            finished_value : v5,
            owner          : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Farm>(&mut arg3.id, v2);
        let v7 = v3;
        assert!(v0 == v6, 0);
        let v8 = 0x2::dynamic_object_field::remove<bool, T0>(&mut v7, true);
        let v9 = v4 * v1.acc_reward_per_lp_value - v5;
        assert!(0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::wallet::get_balance<T1>(arg4) >= v9, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::wallet::take<T1>(arg4, v9, arg6), v0);
        v1.pool_value = 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math::safe_sub_u64(v1.pool_value, v4);
        let v10 = FarmRemoveEvent{
            vault_id       : 0x2::object::id<Vault>(arg1),
            pool_id        : 0x2::object::id<Pool<T0>>(arg3),
            farm_id        : v2,
            lp_position_id : 0x2::object::id<T0>(&v8),
            value          : v4,
            reward         : v9,
        };
        0x2::event::emit<FarmRemoveEvent>(v10);
        0x2::object::delete(v7);
        0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::position::burn(arg5);
        0x2::transfer::public_transfer<T0>(v8, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

