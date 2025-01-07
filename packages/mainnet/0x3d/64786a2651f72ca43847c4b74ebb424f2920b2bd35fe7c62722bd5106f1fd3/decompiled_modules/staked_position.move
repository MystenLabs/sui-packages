module 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::staked_position {
    struct StakedPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        afterburner_vault_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        multiplier_staked_amount: u64,
        lock_start_timestamp_ms: u64,
        lock_duration_ms: u64,
        lock_multiplier: u64,
        last_reward_timestamp_ms: u64,
        base_rewards_accumulated: vector<u64>,
        multiplier_rewards_accumulated: vector<u64>,
        base_rewards_debt: vector<u64>,
        multiplier_rewards_debt: vector<u64>,
    }

    public fun join<T0>(arg0: &mut StakedPosition<T0>, arg1: StakedPosition<T0>, arg2: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg3: &0x2::clock::Clock) {
        abort 9
    }

    public fun split<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakedPosition<T0> {
        abort 9
    }

    public fun transfer<T0>(arg0: StakedPosition<T0>, arg1: address) {
        0x2::transfer::transfer<StakedPosition<T0>>(arg0, arg1);
    }

    public fun afterburner_vault_id<T0>(arg0: &StakedPosition<T0>) : 0x2::object::ID {
        arg0.afterburner_vault_id
    }

    public fun begin_harvest<T0>(arg0: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>) : 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::HarvestedRewardsEventMetadata {
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::begin_harvest(0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg0))
    }

    public fun base_rewards_accumulated<T0>(arg0: &StakedPosition<T0>) : vector<u64> {
        arg0.base_rewards_accumulated
    }

    public fun base_rewards_accumulated_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>) : u64 {
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::borrow<T0, u64>(arg1, &arg0.base_rewards_accumulated, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun base_rewards_debt<T0>(arg0: &StakedPosition<T0>) : vector<u64> {
        arg0.base_rewards_debt
    }

    public fun base_rewards_debt_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>) : u64 {
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::borrow<T0, u64>(arg1, &arg0.base_rewards_debt, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    fun calc_total_rewards_from_time_t0<T0>(arg0: &StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: u128, arg4: u64) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.last_reward_timestamp_ms;
        let v2 = lock_end_timestamp_ms<T0>(arg0);
        let v3 = if (v0 <= v2) {
            0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_64_128(arg0.multiplier_staked_amount, arg3)
        } else if (v2 <= v1) {
            *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_debt, arg4)
        } else if (0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::emission_end_timestamp_ms<T0>(arg1) <= v2) {
            0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_64_128(arg0.multiplier_staked_amount, arg3)
        } else {
            0x2::math::max((((0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_64_128(arg0.multiplier_staked_amount, arg3) as u128) * ((v2 - v1) as u128) / ((v0 - v1) as u128)) as u64), *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_debt, arg4))
        };
        (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_64_128(staked_amount<T0>(arg0), arg3), v3)
    }

    fun decrease_base_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::split<T0>(&mut arg0.balance, arg2);
        arg0.base_rewards_debt = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::calc_rewards_debt<T0>(arg1, staked_amount<T0>(arg0));
        update_multiplier_staked_amount<T0>(arg0, arg1);
        v0
    }

    public fun deposit_principal<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg1), 2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0);
        update_position<T0>(arg0, arg1, arg2);
        let v1 = is_unlocked<T0>(arg0, arg1, arg2);
        if (!v1) {
            arg0.lock_start_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        };
        increase_base_staked_amount<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg3));
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::increase_stake<T0>(arg1, v0);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::increase_stake_with_multiplier<T0>(arg1, v0 + 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::calc_multiplier_staked_amount(v0, arg0.lock_multiplier));
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_deposited_principal_event<T0>(0x2::object::id<StakedPosition<T0>>(arg0), arg0.afterburner_vault_id, v0);
    }

    public fun destroy<T0>(arg0: StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg1), 2);
        assert!(is_unlocked<T0>(&arg0, arg1, arg2), 1);
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::sum_u64(&arg0.base_rewards_accumulated) + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::sum_u64(&arg0.multiplier_rewards_accumulated) == 0, 4);
        let StakedPosition {
            id                             : v0,
            afterburner_vault_id           : _,
            balance                        : v2,
            multiplier_staked_amount       : _,
            lock_start_timestamp_ms        : _,
            lock_duration_ms               : _,
            lock_multiplier                : _,
            last_reward_timestamp_ms       : _,
            base_rewards_accumulated       : _,
            multiplier_rewards_accumulated : _,
            base_rewards_debt              : _,
            multiplier_rewards_debt        : _,
        } = arg0;
        let v12 = v0;
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_destroyed_staked_position_event(0x2::object::uid_to_inner(&v12));
        0x2::object::delete(v12);
        0x2::balance::destroy_zero<T0>(v2);
    }

    public fun end_harvest(arg0: 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::HarvestedRewardsEventMetadata) {
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_harvested_rewards_event(arg0);
    }

    public fun harvest_rewards<T0, T1>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::HarvestedRewardsEventMetadata, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::lock_enforcement<T0>(arg1) == 0, 2);
        assert!(arg0.afterburner_vault_id == 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg1), 2);
        assert!(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::afterburner_vault_id(arg2) == arg0.afterburner_vault_id, 2);
        update_position<T0>(arg0, arg1, arg3);
        let v0 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>();
        let v1 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::type_name_to_index<T0>(arg1, v0);
        let v2 = *0x1::vector::borrow<u64>(&arg0.base_rewards_accumulated, v1);
        *0x1::vector::borrow_mut<u64>(&mut arg0.base_rewards_accumulated, v1) = 0;
        assert!(v2 > 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::minimal_claim(), 10);
        let v3 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::claim_rewards<T0, T1>(arg1, v2, arg4);
        if (0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::lock_enforcement<T0>(arg1) == 0 || is_unlocked<T0>(arg0, arg1, arg3)) {
            let v4 = *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_accumulated, v1);
            *0x1::vector::borrow_mut<u64>(&mut arg0.multiplier_rewards_accumulated, v1) = 0;
            if (v4 > 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::minimal_claim()) {
                0x2::coin::join<T1>(&mut v3, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::claim_rewards<T0, T1>(arg1, v4, arg4));
            };
        };
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::add_harvest_metadata(arg2, v0, 0x2::coin::value<T1>(&v3));
        v3
    }

    fun increase_base_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
        arg0.base_rewards_debt = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::calc_rewards_debt<T0>(arg1, staked_amount<T0>(arg0));
        update_multiplier_staked_amount<T0>(arg0, arg1);
    }

    public fun is_unlocked<T0>(arg0: &StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::calc_emitted_rewards<T0>(arg1);
        let v1 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::rewards<T0>(arg1);
        let v2 = 0;
        let v3 = true;
        while (v2 < 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::type_names_len<T0>(arg1) && v3) {
            if (*0x1::vector::borrow<u64>(&v0, v2) < *0x1::vector::borrow<u64>(&v1, v2)) {
                v3 = false;
            };
            v2 = v2 + 1;
        };
        let v4 = lock_end_timestamp_ms<T0>(arg0) <= 0x2::clock::timestamp_ms(arg2) || 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::emission_end_timestamp_ms<T0>(arg1) <= 0x2::clock::timestamp_ms(arg2);
        v4 || v3
    }

    public fun last_reward_timestamp_ms<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.last_reward_timestamp_ms
    }

    public fun lock<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg1), 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = is_unlocked<T0>(arg0, arg1, arg2);
        if (!v1) {
            assert!(arg3 >= lock_end_timestamp_ms<T0>(arg0) - v0, 3);
        };
        update_position<T0>(arg0, arg1, arg2);
        let v2 = staked_amount_with_multiplier<T0>(arg0);
        arg0.lock_start_timestamp_ms = v0;
        update_lock_duration_ms<T0>(arg0, arg1, arg3);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::decrease_stake_with_multiplier<T0>(arg1, v2);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::increase_stake_with_multiplier<T0>(arg1, staked_amount_with_multiplier<T0>(arg0));
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_locked_event<T0>(0x2::object::id<StakedPosition<T0>>(arg0), arg0.afterburner_vault_id, staked_amount<T0>(arg0), v0, arg3, arg0.lock_multiplier);
    }

    public fun lock_duration_ms<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.lock_duration_ms
    }

    public fun lock_end_timestamp_ms<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.lock_start_timestamp_ms + arg0.lock_duration_ms
    }

    public fun lock_multiplier<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.lock_multiplier
    }

    public fun lock_start_timestamp_ms<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.lock_start_timestamp_ms
    }

    public fun multiplier_rewards_accumulated<T0>(arg0: &StakedPosition<T0>) : vector<u64> {
        arg0.multiplier_rewards_accumulated
    }

    public fun multiplier_rewards_accumulated_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>) : u64 {
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::borrow<T0, u64>(arg1, &arg0.multiplier_rewards_accumulated, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun multiplier_rewards_debt<T0>(arg0: &StakedPosition<T0>) : vector<u64> {
        arg0.multiplier_rewards_debt
    }

    public fun multiplier_rewards_debt_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>) : u64 {
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::borrow<T0, u64>(arg1, &arg0.multiplier_rewards_debt, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::type_to_string<T1>())
    }

    public fun multiplier_staked_amount<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.multiplier_staked_amount
    }

    public fun renew_lock<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock) {
        let v0 = arg0.lock_duration_ms;
        lock<T0>(arg0, arg1, arg2, v0);
    }

    fun return_multiplier_rewards<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::type_names_len<T0>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_accumulated, v0);
            let v2 = (((v1 as u128) * (arg2 as u128) / (staked_amount<T0>(arg0) as u128)) as u64);
            0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::reemit_rewards<T0>(arg1, v2, v0);
            *0x1::vector::borrow_mut<u64>(&mut arg0.multiplier_rewards_accumulated, v0) = v1 - v2;
            v0 = v0 + 1;
        };
    }

    public fun stake<T0>(arg0: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakedPosition<T0> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        assert!(v0 >= 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::min_stake_amount<T0>(arg0), 5);
        assert!(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::min_lock_duration_ms<T0>(arg0) <= arg3, 3);
        assert!(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::emission_end_timestamp_ms<T0>(arg0) != 0, 8);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::update_emission_timestamps<T0>(arg0, arg1);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::emit_rewards<T0>(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::calc_lock_duration_multiplier(arg3, 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::max_lock_duration_ms<T0>(arg0), 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::min_lock_duration_ms<T0>(arg0), 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::max_lock_multiplier<T0>(arg0));
        let v3 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::calc_multiplier_staked_amount(v0, v2);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::increase_stake<T0>(arg0, v0);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::increase_stake_with_multiplier<T0>(arg0, v0 + v3);
        let v4 = StakedPosition<T0>{
            id                             : 0x2::object::new(arg4),
            afterburner_vault_id           : 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg0),
            balance                        : 0x2::coin::into_balance<T0>(arg2),
            multiplier_staked_amount       : v3,
            lock_start_timestamp_ms        : v1,
            lock_duration_ms               : arg3,
            lock_multiplier                : v2,
            last_reward_timestamp_ms       : v1,
            base_rewards_accumulated       : 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::empty_vector(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::type_names_len<T0>(arg0)),
            multiplier_rewards_accumulated : 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::empty_vector(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::type_names_len<T0>(arg0)),
            base_rewards_debt              : 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::calc_rewards_debt<T0>(arg0, v0),
            multiplier_rewards_debt        : 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::calc_rewards_debt<T0>(arg0, v3),
        };
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_staked_event<T0>(0x2::object::id<StakedPosition<T0>>(&v4), 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg0), v0, v3, v1, arg3, v2);
        v4
    }

    public fun staked_amount<T0>(arg0: &StakedPosition<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun staked_amount_with_multiplier<T0>(arg0: &StakedPosition<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance) + arg0.multiplier_staked_amount
    }

    public fun unlock<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock) {
        assert!(is_unlocked<T0>(arg0, arg1, arg2), 1);
        update_position<T0>(arg0, arg1, arg2);
    }

    fun unlock_<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock) {
        assert!(is_unlocked<T0>(arg0, arg1, arg2), 1);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::decrease_stake_with_multiplier<T0>(arg1, arg0.multiplier_staked_amount);
        arg0.multiplier_staked_amount = 0;
        arg0.lock_duration_ms = 0;
        arg0.lock_multiplier = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::lock_multiplier_lower_bound();
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_unlocked_event<T0>(0x2::object::id<StakedPosition<T0>>(arg0), arg0.afterburner_vault_id, staked_amount<T0>(arg0));
    }

    fun update_lock_duration_ms<T0>(arg0: &mut StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: u64) {
        arg0.lock_duration_ms = arg2;
        arg0.lock_multiplier = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::calc_lock_multiplier<T0>(arg1, arg2);
        update_multiplier_staked_amount<T0>(arg0, arg1);
    }

    fun update_multiplier_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>) {
        arg0.multiplier_staked_amount = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::calc_multiplier_staked_amount(staked_amount<T0>(arg0), arg0.lock_multiplier);
        arg0.multiplier_rewards_debt = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::calc_rewards_debt<T0>(arg1, arg0.multiplier_staked_amount);
    }

    public fun update_position<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.afterburner_vault_id == 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg1), 2);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::emit_rewards<T0>(arg1, arg2);
        let v0 = 0;
        let v1 = 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::rewards_accumulated_per_share<T0>(arg1);
        while (v0 < 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::type_names_len<T0>(arg1)) {
            let (v2, v3) = if (v0 < 0x1::vector::length<u64>(&arg0.base_rewards_debt)) {
                (*0x1::vector::borrow<u64>(&arg0.base_rewards_debt, v0), *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_debt, v0))
            } else {
                0x1::vector::push_back<u64>(&mut arg0.base_rewards_debt, 0);
                0x1::vector::push_back<u64>(&mut arg0.multiplier_rewards_debt, 0);
                (0, 0)
            };
            let (v4, v5) = if (v0 < 0x1::vector::length<u64>(&arg0.base_rewards_accumulated)) {
                (*0x1::vector::borrow<u64>(&arg0.base_rewards_accumulated, v0), *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_accumulated, v0))
            } else {
                0x1::vector::push_back<u64>(&mut arg0.base_rewards_accumulated, 0);
                0x1::vector::push_back<u64>(&mut arg0.multiplier_rewards_accumulated, 0);
                (0, 0)
            };
            let (v6, v7) = calc_total_rewards_from_time_t0<T0>(arg0, arg1, arg2, *0x1::vector::borrow<u128>(&v1, v0), v0);
            *0x1::vector::borrow_mut<u64>(&mut arg0.base_rewards_accumulated, v0) = v6 - v2 + v4;
            *0x1::vector::borrow_mut<u64>(&mut arg0.multiplier_rewards_accumulated, v0) = v7 - v3 + v5;
            *0x1::vector::borrow_mut<u64>(&mut arg0.base_rewards_debt, v0) = v6;
            *0x1::vector::borrow_mut<u64>(&mut arg0.multiplier_rewards_debt, v0) = v7;
            v0 = v0 + 1;
        };
        if (is_unlocked<T0>(arg0, arg1, arg2)) {
            unlock_<T0>(arg0, arg1, arg2);
        };
        arg0.last_reward_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun withdraw_principal<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::lock_enforcement<T0>(arg1) == 0, 2);
        assert!(arg0.afterburner_vault_id == 0x2::object::id<0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::AfterburnerVault<T0>>(arg1), 2);
        assert!(arg3 > 0, 0);
        assert!(is_unlocked<T0>(arg0, arg1, arg2), 1);
        assert!(arg3 <= staked_amount<T0>(arg0), 6);
        let v0 = staked_amount<T0>(arg0) - arg3;
        assert!(0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::min_stake_amount<T0>(arg1) <= v0 || v0 == 0, 5);
        update_position<T0>(arg0, arg1, arg2);
        let v1 = if (0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::lock_enforcement<T0>(arg1) == 1) {
            let v2 = is_unlocked<T0>(arg0, arg1, arg2);
            !v2
        } else {
            false
        };
        if (v1) {
            return_multiplier_rewards<T0>(arg0, arg1, arg3);
        };
        let v3 = decrease_base_staked_amount<T0>(arg0, arg1, arg3);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::decrease_stake<T0>(arg1, arg3);
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::afterburner_vault::decrease_stake_with_multiplier<T0>(arg1, arg3 + 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::utils::calc_multiplier_staked_amount(arg3, arg0.lock_multiplier));
        0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events::emit_withdrew_principal_event<T0>(0x2::object::id<StakedPosition<T0>>(arg0), arg0.afterburner_vault_id, arg3);
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    // decompiled from Move bytecode v6
}

