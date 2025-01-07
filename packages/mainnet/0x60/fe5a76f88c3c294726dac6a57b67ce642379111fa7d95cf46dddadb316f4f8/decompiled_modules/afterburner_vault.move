module 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        afterburner_vault_id: 0x2::object::ID,
    }

    struct OneTimeAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        afterburner_vault_id: 0x2::object::ID,
    }

    struct AfterburnerVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        type_names: vector<0x1::ascii::String>,
        rewards: vector<u64>,
        rewards_accumulated_per_share: vector<u128>,
        total_staked_amount: u64,
        total_staked_amount_with_multiplier: u64,
        emission_schedules_ms: vector<u64>,
        emission_rates: vector<u64>,
        emission_start_timestamps_ms: vector<u64>,
        emission_end_timestamp_ms: u64,
        last_reward_timestamps_ms: vector<u64>,
        lock_enforcement: u64,
        min_lock_duration_ms: u64,
        max_lock_duration_ms: u64,
        max_lock_multiplier: u64,
        min_stake_amount: u64,
    }

    struct UnlockFlag has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0, T1: copy>(arg0: &AfterburnerVault<T0>, arg1: &vector<T1>, arg2: 0x1::ascii::String) : T1 {
        *0x1::vector::borrow<T1>(arg1, type_name_to_index<T0>(arg0, arg2))
    }

    public fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (AfterburnerVault<T0>, OwnerCap) {
        assert!(arg1 <= arg2, 2);
        assert!(arg0 == 0, 1);
        assert!(arg3 >= 1000000000000000000, 9);
        let v0 = AfterburnerVault<T0>{
            id                                  : 0x2::object::new(arg5),
            type_names                          : 0x1::vector::empty<0x1::ascii::String>(),
            rewards                             : vector[],
            rewards_accumulated_per_share       : vector[],
            total_staked_amount                 : 0,
            total_staked_amount_with_multiplier : 0,
            emission_schedules_ms               : vector[],
            emission_rates                      : vector[],
            emission_start_timestamps_ms        : vector[],
            emission_end_timestamp_ms           : 0,
            last_reward_timestamps_ms           : vector[],
            lock_enforcement                    : arg0,
            min_lock_duration_ms                : arg1,
            max_lock_duration_ms                : arg2,
            max_lock_multiplier                 : arg3,
            min_stake_amount                    : arg4,
        };
        0x2::dynamic_field::add<0x1::ascii::String, vector<u64>>(&mut v0.id, rewards_remaining_df_key(), vector[]);
        let v1 = OwnerCap{
            id                   : 0x2::object::new(arg5),
            afterburner_vault_id : 0x2::object::id<AfterburnerVault<T0>>(&v0),
        };
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_created_vault_event<T0>(0x2::object::id<AfterburnerVault<T0>>(&v0), arg1, arg2, arg3, arg4);
        (v0, v1)
    }

    public fun add_remaining_rewards<T0>(arg0: &OwnerCap, arg1: &mut AfterburnerVault<T0>, arg2: vector<u64>) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<AfterburnerVault<T0>>(arg1), 1);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.type_names) == 0x1::vector::length<u64>(&arg2) || 0x1::vector::length<u64>(&arg2) == 0, 10);
        if (0x1::vector::length<u64>(&arg2) == 0) {
            let v0 = 0x1::vector::length<0x1::ascii::String>(&arg1.type_names);
            let v1 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::empty_vector(v0);
            let v2 = 0;
            while (v2 < v0) {
                let v3 = calc_rewards_emitted_from_time_tm_to_tn_<T0>(arg1, *0x1::vector::borrow<u64>(&arg1.emission_start_timestamps_ms, v2), *0x1::vector::borrow<u64>(&arg1.last_reward_timestamps_ms, v2), v2);
                let v4 = *0x1::vector::borrow<u64>(&arg1.rewards, v2);
                let v5 = if (v3 < v4) {
                    v4 - v3
                } else {
                    0
                };
                *0x1::vector::borrow_mut<u64>(&mut v1, v2) = v5;
                v2 = v2 + 1;
            };
            0x2::dynamic_field::add<0x1::ascii::String, vector<u64>>(&mut arg1.id, rewards_remaining_df_key(), v1);
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, vector<u64>>(&mut arg1.id, rewards_remaining_df_key(), arg2);
        };
    }

    public fun add_reward<T0, T1>(arg0: &OwnerCap, arg1: &mut AfterburnerVault<T0>, arg2: 0x2::coin::Coin<T1>) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<AfterburnerVault<T0>>(arg1), 1);
        add_reward_<T0, T1>(arg1, arg2);
    }

    fun add_reward_<T0, T1>(arg0: &mut AfterburnerVault<T0>, arg1: 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>();
        assert!(contains_type_name<T0>(arg0, v0), 3);
        let v1 = type_name_to_index<T0>(arg0, v0);
        let v2 = 0x2::coin::value<T1>(&arg1);
        let v3 = rewards_of<T0, T1>(arg0) + v2;
        *0x1::vector::borrow_mut<u64>(&mut arg0.rewards, v1) = v3;
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.id, v0), 0x2::coin::into_balance<T1>(arg1));
        increase_remaining_rewards_for_<T0>(arg0, v1, v3);
        let v4 = last_reward_timestamp_ms_for<T0, T1>(arg0) + emission_schedule_ms_for<T0, T1>(arg0) * v3 / emission_rate_for<T0, T1>(arg0);
        if (arg0.emission_end_timestamp_ms < v4) {
            arg0.emission_end_timestamp_ms = v4;
        };
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_added_reward_event<T1>(0x2::object::id<AfterburnerVault<T0>>(arg0), v2);
    }

    public fun add_reward_and_consume_admin_cap<T0, T1>(arg0: OneTimeAdminCap<T1>, arg1: &mut AfterburnerVault<T0>, arg2: 0x2::coin::Coin<T1>) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<AfterburnerVault<T0>>(arg1), 1);
        add_reward_<T0, T1>(arg1, arg2);
        let OneTimeAdminCap {
            id                   : v0,
            afterburner_vault_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun calc_emission_end_timestamp_ms<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0.rewards)) {
            let v3 = *0x1::vector::borrow<u64>(&arg0.emission_start_timestamps_ms, v2) + (((1 + ((*0x1::vector::borrow<u64>(&arg0.rewards, v2) as u128) - 1) / (*0x1::vector::borrow<u64>(&arg0.emission_rates, v2) as u128)) * (*0x1::vector::borrow<u64>(&arg0.emission_schedules_ms, v2) as u128)) as u64);
            if (v0 < v3) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun calc_emitted_rewards<T0>(arg0: &AfterburnerVault<T0>) : vector<u64> {
        let v0 = vector[];
        let v1 = type_names<T0>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(&arg0.rewards, v2) - remaining_rewards_for<T0>(arg0, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun calc_emitted_rewards_for<T0, T1>(arg0: &AfterburnerVault<T0>) : u64 {
        let v0 = type_to_index<T0, T1>(arg0);
        *0x1::vector::borrow<u64>(&arg0.rewards, v0) - remaining_rewards_for<T0>(arg0, v0)
    }

    public fun calc_lock_multiplier<T0>(arg0: &AfterburnerVault<T0>, arg1: u64) : u64 {
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::calc_lock_duration_multiplier(arg1, arg0.max_lock_duration_ms, arg0.min_lock_duration_ms, arg0.max_lock_multiplier)
    }

    public fun calc_rewards_debt<T0>(arg0: &AfterburnerVault<T0>, arg1: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = type_names<T0>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_64_128(arg1, *0x1::vector::borrow<u128>(&arg0.rewards_accumulated_per_share, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    fun calc_rewards_emitted_from_time_tm_to_tn_<T0>(arg0: &AfterburnerVault<T0>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (arg2 - arg1) / *0x1::vector::borrow<u64>(&arg0.emission_schedules_ms, arg3) * *0x1::vector::borrow<u64>(&arg0.emission_rates, arg3)
    }

    fun calc_rewards_to_emit_<T0>(arg0: &AfterburnerVault<T0>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        0x2::math::min(remaining_rewards_for<T0>(arg0, arg2), calc_rewards_emitted_from_time_tm_to_tn_<T0>(arg0, *0x1::vector::borrow<u64>(&arg0.last_reward_timestamps_ms, arg2), 0x2::clock::timestamp_ms(arg1), arg2))
    }

    public(friend) fun claim_rewards<T0, T1>(arg0: &mut AfterburnerVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 10, 8);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>()), arg1), arg2)
    }

    public fun contains_type<T0, T1>(arg0: &AfterburnerVault<T0>) : bool {
        contains_type_name<T0>(arg0, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun contains_type_name<T0>(arg0: &AfterburnerVault<T0>, arg1: 0x1::ascii::String) : bool {
        let (v0, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.type_names, &arg1);
        v0
    }

    fun decrease_remaining_rewards_for_<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64, arg2: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, vector<u64>>(&mut arg0.id, rewards_remaining_df_key());
        let v1 = *0x1::vector::borrow<u64>(v0, arg1);
        let v2 = if (v1 > arg2) {
            v1 - arg2
        } else {
            0
        };
        *0x1::vector::borrow_mut<u64>(v0, arg1) = v2;
    }

    public(friend) fun decrease_stake<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64) {
        assert!(arg0.total_staked_amount >= arg1, 6);
        arg0.total_staked_amount = arg0.total_staked_amount - arg1;
    }

    public(friend) fun decrease_stake_with_multiplier<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64) {
        assert!(arg0.total_staked_amount_with_multiplier >= arg1, 6);
        arg0.total_staked_amount_with_multiplier = arg0.total_staked_amount_with_multiplier - arg1;
    }

    public fun emission_end_timestamp_ms<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.emission_end_timestamp_ms
    }

    public fun emission_rate_for<T0, T1>(arg0: &AfterburnerVault<T0>) : u64 {
        borrow<T0, u64>(arg0, &arg0.emission_rates, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun emission_rates<T0>(arg0: &AfterburnerVault<T0>) : vector<u64> {
        arg0.emission_rates
    }

    public fun emission_schedule_ms_for<T0, T1>(arg0: &AfterburnerVault<T0>) : u64 {
        borrow<T0, u64>(arg0, &arg0.emission_schedules_ms, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun emission_schedules_ms<T0>(arg0: &AfterburnerVault<T0>) : vector<u64> {
        arg0.emission_schedules_ms
    }

    public fun emission_start_timestamp_ms_for<T0, T1>(arg0: &AfterburnerVault<T0>) : u64 {
        borrow<T0, u64>(arg0, &arg0.emission_start_timestamps_ms, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun emission_start_timestamps_ms<T0>(arg0: &AfterburnerVault<T0>) : vector<u64> {
        arg0.emission_start_timestamps_ms
    }

    public fun emit_rewards<T0>(arg0: &mut AfterburnerVault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.total_staked_amount == 0) {
            return
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg0.type_names)) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.last_reward_timestamps_ms, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg0.emission_schedules_ms, v1);
            if (v0 < v2 + v3) {
                v1 = v1 + 1;
                continue
            };
            let v4 = calc_rewards_to_emit_<T0>(arg0, arg1, v1);
            if (v4 == 0) {
                v1 = v1 + 1;
                continue
            };
            decrease_remaining_rewards_for_<T0>(arg0, v1, v4);
            increase_rewards_accumulated_per_share<T0>(arg0, v4, v1);
            *0x1::vector::borrow_mut<u64>(&mut arg0.last_reward_timestamps_ms, v1) = v2 + (v0 - v2) / v3 * v3;
            v1 = v1 + 1;
        };
    }

    public fun grant_one_time_admin_cap<T0>(arg0: &OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OneTimeAdminCap<T0>{
            id                   : 0x2::object::new(arg2),
            afterburner_vault_id : arg0.afterburner_vault_id,
        };
        0x2::transfer::transfer<OneTimeAdminCap<T0>>(v0, arg1);
    }

    public fun increase_emissions_for<T0, T1>(arg0: &OwnerCap, arg1: &mut AfterburnerVault<T0>, arg2: u64, arg3: u64) {
        abort 11
    }

    fun increase_remaining_rewards_for_<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64, arg2: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, vector<u64>>(&mut arg0.id, rewards_remaining_df_key());
        *0x1::vector::borrow_mut<u64>(v0, arg1) = *0x1::vector::borrow<u64>(v0, arg1) + arg2;
    }

    fun increase_rewards_accumulated_per_share<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64, arg2: u64) {
        let v0 = (arg1 as u128) * 1000000000000000000 / (arg0.total_staked_amount_with_multiplier as u128);
        if (v0 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u128>(&mut arg0.rewards_accumulated_per_share, arg2) = *0x1::vector::borrow<u128>(&arg0.rewards_accumulated_per_share, arg2) + v0;
    }

    public(friend) fun increase_stake<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64) {
        arg0.total_staked_amount = arg0.total_staked_amount + arg1;
    }

    public(friend) fun increase_stake_with_multiplier<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64) {
        arg0.total_staked_amount_with_multiplier = arg0.total_staked_amount_with_multiplier + arg1;
    }

    public fun initialize_reward<T0, T1>(arg0: &OwnerCap, arg1: &mut AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<AfterburnerVault<T0>>(arg1), 1);
        initialize_reward_<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun initialize_reward_<T0, T1>(arg0: &mut AfterburnerVault<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64) {
        assert!(0x2::coin::value<T1>(&arg2) > 0, 0);
        assert!(!contains_type<T0, T1>(arg0), 5);
        let v0 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>();
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.type_names, v0);
        let v1 = 0x2::coin::value<T1>(&arg2);
        0x1::vector::push_back<u64>(&mut arg0.rewards, v1);
        0x1::vector::push_back<u128>(&mut arg0.rewards_accumulated_per_share, 0);
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, 0x2::coin::into_balance<T1>(arg2));
        0x1::vector::push_back<u64>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, vector<u64>>(&mut arg0.id, rewards_remaining_df_key()), v1);
        let v2 = 0x2::clock::timestamp_ms(arg1) + arg5;
        0x1::vector::push_back<u64>(&mut arg0.emission_start_timestamps_ms, v2);
        0x1::vector::push_back<u64>(&mut arg0.last_reward_timestamps_ms, v2);
        0x1::vector::push_back<u64>(&mut arg0.emission_schedules_ms, arg3);
        0x1::vector::push_back<u64>(&mut arg0.emission_rates, arg4);
        let v3 = v2 + arg3 * v1 / arg4;
        if (arg0.emission_end_timestamp_ms < v3) {
            arg0.emission_end_timestamp_ms = v3;
        };
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_initialized_reward_event<T1>(0x2::object::id<AfterburnerVault<T0>>(arg0), v1, arg4, v2);
    }

    public fun initialize_reward_and_consume_admin_cap<T0, T1>(arg0: OneTimeAdminCap<T1>, arg1: &mut AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<AfterburnerVault<T0>>(arg1), 1);
        initialize_reward_<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let OneTimeAdminCap {
            id                   : v0,
            afterburner_vault_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_vault_unlocked<T0>(arg0: &AfterburnerVault<T0>) : bool {
        let v0 = UnlockFlag{dummy_field: false};
        0x2::dynamic_field::exists_<UnlockFlag>(&arg0.id, v0)
    }

    public fun last_reward_timestamp_ms_for<T0, T1>(arg0: &AfterburnerVault<T0>) : u64 {
        borrow<T0, u64>(arg0, &arg0.last_reward_timestamps_ms, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun last_reward_timestamps_ms<T0>(arg0: &AfterburnerVault<T0>) : vector<u64> {
        arg0.last_reward_timestamps_ms
    }

    public fun lock_enforcement<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.lock_enforcement
    }

    public fun lock_vault<T0>(arg0: &OwnerCap, arg1: &mut AfterburnerVault<T0>) {
        let v0 = UnlockFlag{dummy_field: false};
        0x2::dynamic_field::remove<UnlockFlag, bool>(&mut arg1.id, v0);
    }

    public fun max_lock_duration_ms<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.max_lock_duration_ms
    }

    public fun max_lock_multiplier<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.max_lock_multiplier
    }

    public fun min_lock_duration_ms<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.min_lock_duration_ms
    }

    public fun min_stake_amount<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.min_stake_amount
    }

    public fun minimal_claim() : u64 {
        10
    }

    public(friend) fun reemit_rewards<T0>(arg0: &mut AfterburnerVault<T0>, arg1: u64, arg2: u64) {
        increase_rewards_accumulated_per_share<T0>(arg0, arg1, arg2);
    }

    public fun remaining_rewards<T0>(arg0: &AfterburnerVault<T0>) : vector<u64> {
        *0x2::dynamic_field::borrow<0x1::ascii::String, vector<u64>>(&arg0.id, rewards_remaining_df_key())
    }

    public fun remaining_rewards_for<T0>(arg0: &AfterburnerVault<T0>, arg1: u64) : u64 {
        let v0 = 0x2::dynamic_field::borrow<0x1::ascii::String, vector<u64>>(&arg0.id, rewards_remaining_df_key());
        assert!(arg1 < 0x1::vector::length<u64>(v0), 10);
        *0x1::vector::borrow<u64>(v0, arg1)
    }

    public fun rewards<T0>(arg0: &AfterburnerVault<T0>) : vector<u64> {
        arg0.rewards
    }

    public fun rewards_accumulated_per_share<T0>(arg0: &AfterburnerVault<T0>) : vector<u128> {
        arg0.rewards_accumulated_per_share
    }

    public fun rewards_accumulated_per_share_for<T0, T1>(arg0: &AfterburnerVault<T0>) : u128 {
        borrow<T0, u128>(arg0, &arg0.rewards_accumulated_per_share, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun rewards_of<T0, T1>(arg0: &AfterburnerVault<T0>) : u64 {
        borrow<T0, u64>(arg0, &arg0.rewards, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    fun rewards_remaining_df_key() : 0x1::ascii::String {
        0x1::ascii::string(b"rewards_remaining_df_field")
    }

    public fun share_vault<T0>(arg0: AfterburnerVault<T0>) {
        0x2::transfer::public_share_object<AfterburnerVault<T0>>(arg0);
    }

    public fun total_staked_amount<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.total_staked_amount
    }

    public fun total_staked_amount_with_multiplier<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        arg0.total_staked_amount_with_multiplier
    }

    public fun transfer_owner_cap(arg0: OwnerCap, arg1: address) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public fun type_name_to_index<T0>(arg0: &AfterburnerVault<T0>, arg1: 0x1::ascii::String) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.type_names, &arg1);
        assert!(v0, 5);
        v1
    }

    public fun type_names<T0>(arg0: &AfterburnerVault<T0>) : vector<0x1::ascii::String> {
        arg0.type_names
    }

    public fun type_names_len<T0>(arg0: &AfterburnerVault<T0>) : u64 {
        0x1::vector::length<0x1::ascii::String>(&arg0.type_names)
    }

    public fun type_to_index<T0, T1>(arg0: &AfterburnerVault<T0>) : u64 {
        type_name_to_index<T0>(arg0, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun unlock_vault<T0>(arg0: &OwnerCap, arg1: &mut AfterburnerVault<T0>) {
        let v0 = UnlockFlag{dummy_field: false};
        0x2::dynamic_field::add<UnlockFlag, bool>(&mut arg1.id, v0, true);
    }

    public(friend) fun update_emission_timestamps<T0>(arg0: &mut AfterburnerVault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.rewards)) {
            if (*0x1::vector::borrow<u64>(&arg0.emission_start_timestamps_ms, v1) < v0 && arg0.total_staked_amount == 0) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.emission_start_timestamps_ms, v1) = v0;
                *0x1::vector::borrow_mut<u64>(&mut arg0.last_reward_timestamps_ms, v1) = v0;
                arg0.emission_end_timestamp_ms = calc_emission_end_timestamp_ms<T0>(arg0);
            };
            v1 = v1 + 1;
        };
    }

    public fun update_emissions_for<T0, T1>(arg0: &OwnerCap, arg1: &mut AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<AfterburnerVault<T0>>(arg1), 1);
        assert!(contains_type<T0, T1>(arg1), 3);
        let v0 = type_to_index<T0, T1>(arg1);
        *0x1::vector::borrow_mut<u64>(&mut arg1.emission_schedules_ms, v0) = arg3;
        *0x1::vector::borrow_mut<u64>(&mut arg1.emission_rates, v0) = arg4;
        arg1.emission_end_timestamp_ms = calc_emission_end_timestamp_ms<T0>(arg1);
        emit_rewards<T0>(arg1, arg2);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_increased_emissions_event<T1>(0x2::object::id<AfterburnerVault<T0>>(arg1), arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

