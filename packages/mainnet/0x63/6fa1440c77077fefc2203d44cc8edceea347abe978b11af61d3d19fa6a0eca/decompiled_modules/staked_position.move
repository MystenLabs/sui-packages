module 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::staked_position {
    struct StakedPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        multiplier_staked_amount: u64,
        lock_enforcement: 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::LockEnforcement,
        lock_start_timestamp_ms: u64,
        lock_duration_ms: u64,
        lock_multiplier: u64,
        last_reward_timestamp_ms: u64,
        base_rewards_accumulated: vector<u64>,
        multiplier_rewards_accumulated: vector<u64>,
        base_rewards_debt: vector<u64>,
        multiplier_rewards_debt: vector<u64>,
    }

    struct HarvestRewardsCap {
        vault_id: 0x2::object::ID,
        reward_types: vector<0x1::type_name::TypeName>,
        reward_amounts: vector<u64>,
    }

    public fun join<T0>(arg0: &mut StakedPosition<T0>, arg1: StakedPosition<T0>, arg2: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg3: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg4: &0x2::clock::Clock) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg3);
        let v0 = 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg2);
        assert!(arg0.vault_id == v0, 1);
        assert!(arg1.vault_id == v0, 1);
        assert!(arg1.lock_enforcement == arg0.lock_enforcement, 8);
        update_position<T0>(arg0, arg2, arg3, arg4);
        let v1 = &mut arg1;
        update_position<T0>(v1, arg2, arg3, arg4);
        let v2 = vector[];
        let v3 = arg0.base_rewards_accumulated;
        let v4 = arg1.base_rewards_accumulated;
        0x1::vector::reverse<u64>(&mut v4);
        assert!(0x1::vector::length<u64>(&v3) == 0x1::vector::length<u64>(&v4), 13906837674741727231);
        0x1::vector::reverse<u64>(&mut v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v3)) {
            0x1::vector::push_back<u64>(&mut v2, 0x1::vector::pop_back<u64>(&mut v3) + 0x1::vector::pop_back<u64>(&mut v4));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        0x1::vector::destroy_empty<u64>(v4);
        arg0.base_rewards_accumulated = v2;
        let v6 = vector[];
        let v7 = arg0.multiplier_rewards_accumulated;
        let v8 = arg1.multiplier_rewards_accumulated;
        0x1::vector::reverse<u64>(&mut v8);
        assert!(0x1::vector::length<u64>(&v7) == 0x1::vector::length<u64>(&v8), 13906837691921596415);
        0x1::vector::reverse<u64>(&mut v7);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v7)) {
            0x1::vector::push_back<u64>(&mut v6, 0x1::vector::pop_back<u64>(&mut v7) + 0x1::vector::pop_back<u64>(&mut v8));
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u64>(v7);
        0x1::vector::destroy_empty<u64>(v8);
        arg0.multiplier_rewards_accumulated = v6;
        arg1.base_rewards_accumulated = vector[];
        arg1.multiplier_rewards_accumulated = vector[];
        if (arg0.lock_start_timestamp_ms < arg1.lock_start_timestamp_ms) {
            arg0.lock_start_timestamp_ms = arg1.lock_start_timestamp_ms;
        };
        if (arg0.lock_duration_ms < arg1.lock_duration_ms) {
            update_lock_duration_ms<T0>(arg0, arg2, arg1.lock_duration_ms);
        };
        let v10 = &mut arg1;
        let v11 = decrease_staked_amount<T0>(v10, arg2, staked_amount<T0>(&arg1));
        increase_staked_amount<T0>(arg0, arg2, v11);
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_joined_event(0x2::object::uid_to_inner(&arg0.id), 0x2::object::uid_to_inner(&arg1.id));
        destroy<T0>(arg1, arg3);
    }

    public fun split<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : StakedPosition<T0> {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        let v0 = 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1);
        assert!(arg0.vault_id == v0, 1);
        let v1 = staked_amount<T0>(arg0);
        assert!(arg4 < v1, 5);
        let v2 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::min_stake_amount<T0>(arg1);
        assert!(v2 <= v1 - arg4, 3);
        assert!(v2 <= arg4, 3);
        update_position<T0>(arg0, arg1, arg2, arg3);
        let v3 = decrease_staked_amount<T0>(arg0, arg1, arg4);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::size<T0>(arg1)) {
            0x1::vector::push_back<u64>(&mut v5, 0);
            v6 = v6 + 1;
        };
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::size<T0>(arg1)) {
            0x1::vector::push_back<u64>(&mut v7, 0);
            v8 = v8 + 1;
        };
        let v9 = StakedPosition<T0>{
            id                             : 0x2::object::new(arg5),
            vault_id                       : v0,
            balance                        : 0x2::balance::zero<T0>(),
            multiplier_staked_amount       : 0,
            lock_enforcement               : arg0.lock_enforcement,
            lock_start_timestamp_ms        : v4,
            lock_duration_ms               : arg0.lock_duration_ms,
            lock_multiplier                : arg0.lock_multiplier,
            last_reward_timestamp_ms       : v4,
            base_rewards_accumulated       : v5,
            multiplier_rewards_accumulated : v7,
            base_rewards_debt              : vector[],
            multiplier_rewards_debt        : vector[],
        };
        let v10 = &mut v9;
        increase_staked_amount<T0>(v10, arg1, v3);
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_staked_event<T0>(0x2::object::uid_to_inner(&v9.id), v0, arg4, v9.multiplier_staked_amount, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::to_u8(v9.lock_enforcement), v4, v9.lock_duration_ms, v9.lock_multiplier);
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_split_event(0x2::object::id<StakedPosition<T0>>(arg0), 0x2::object::uid_to_inner(&v9.id));
        v9
    }

    fun accrue_reward<T0>(arg0: &mut StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: u128, arg3: u64) {
        let (v0, v1) = if (arg3 < 0x1::vector::length<u64>(&arg0.base_rewards_accumulated)) {
            (*0x1::vector::borrow<u64>(&arg0.base_rewards_accumulated, arg3), *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_accumulated, arg3))
        } else {
            0x1::vector::push_back<u64>(&mut arg0.base_rewards_accumulated, 0);
            0x1::vector::push_back<u64>(&mut arg0.multiplier_rewards_accumulated, 0);
            (0, 0)
        };
        let (v2, v3) = if (arg3 < 0x1::vector::length<u64>(&arg0.base_rewards_debt)) {
            (*0x1::vector::borrow<u64>(&arg0.base_rewards_debt, arg3), *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_debt, arg3))
        } else {
            0x1::vector::push_back<u64>(&mut arg0.base_rewards_debt, 0);
            0x1::vector::push_back<u64>(&mut arg0.multiplier_rewards_debt, 0);
            (0, 0)
        };
        let (v4, v5) = calc_total_rewards_from_time_t0<T0>(arg0, arg1, arg2, arg3);
        *0x1::vector::borrow_mut<u64>(&mut arg0.base_rewards_accumulated, arg3) = v4 - v2 + v0;
        *0x1::vector::borrow_mut<u64>(&mut arg0.multiplier_rewards_accumulated, arg3) = v5 - v3 + v1;
        *0x1::vector::borrow_mut<u64>(&mut arg0.base_rewards_debt, arg3) = v4;
        *0x1::vector::borrow_mut<u64>(&mut arg0.multiplier_rewards_debt, arg3) = v5;
    }

    public fun base_rewards_accumulated<T0>(arg0: &StakedPosition<T0>) : vector<u64> {
        arg0.base_rewards_accumulated
    }

    public fun base_rewards_accumulated_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.base_rewards_accumulated, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::type_to_index<T0, T1>(arg1))
    }

    public fun base_rewards_debt<T0>(arg0: &StakedPosition<T0>) : vector<u64> {
        arg0.base_rewards_debt
    }

    public fun base_rewards_debt_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.base_rewards_debt, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::type_to_index<T0, T1>(arg1))
    }

    public fun begin_harvest_tx<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version) : HarvestRewardsCap {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        assert!(arg0.vault_id == 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1), 1);
        HarvestRewardsCap{
            vault_id       : 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1),
            reward_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reward_amounts : vector[],
        }
    }

    fun calc_total_rewards_from_time_t0<T0>(arg0: &StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: u128, arg3: u64) : (u64, u64) {
        let v0 = if (arg0.last_reward_timestamp_ms <= 0x1::u64::min(lock_end_timestamp_ms<T0>(arg0), 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::emission_end_timestamp_ms<T0>(arg1))) {
            0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::divide(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::multiply_u128(arg2, arg0.multiplier_staked_amount), 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::total_rewards_accumulated_per_share_scaling_factor())
        } else {
            *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_debt, arg3)
        };
        (0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::divide(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::multiply_u128(arg2, staked_amount<T0>(arg0)), 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::total_rewards_accumulated_per_share_scaling_factor()), v0)
    }

    fun decrease_multiplier_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: u64) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::decrease_total_multiplier_staked_amount<T0>(arg1, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::calc_multiplier_staked_amount(arg2, arg0.lock_multiplier));
        update_multiplier_staked_amount<T0>(arg0, arg1);
    }

    fun decrease_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::split<T0>(&mut arg0.balance, arg2);
        arg0.base_rewards_debt = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::calc_rewards_debt<T0>(arg1, staked_amount<T0>(arg0));
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::decrease_total_staked_amount<T0>(arg1, arg2);
        decrease_multiplier_staked_amount<T0>(arg0, arg1, arg2);
        v0
    }

    public fun deposit_principal<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        assert!(arg0.vault_id == 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1), 1);
        let v0 = 0x2::coin::value<T0>(&arg4);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg4);
            return
        };
        update_position<T0>(arg0, arg1, arg2, arg3);
        if (!is_unlocked<T0>(arg0, arg1, arg3)) {
            arg0.lock_start_timestamp_ms = 0x2::clock::timestamp_ms(arg3);
        };
        increase_staked_amount<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg4));
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_deposited_principal_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.vault_id, v0);
    }

    public fun destroy<T0>(arg0: StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg1);
        let v0 = 0;
        let v1 = arg0.base_rewards_accumulated;
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut v1);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        let v3 = 0;
        let v4 = arg0.multiplier_rewards_accumulated;
        0x1::vector::reverse<u64>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v4)) {
            v3 = v3 + 0x1::vector::pop_back<u64>(&mut v4);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(v4);
        assert!(v0 + v3 == 0, 9);
        let StakedPosition {
            id                             : v6,
            vault_id                       : _,
            balance                        : v8,
            multiplier_staked_amount       : _,
            lock_enforcement               : _,
            lock_start_timestamp_ms        : _,
            lock_duration_ms               : _,
            lock_multiplier                : _,
            last_reward_timestamp_ms       : _,
            base_rewards_accumulated       : _,
            multiplier_rewards_accumulated : _,
            base_rewards_debt              : _,
            multiplier_rewards_debt        : _,
        } = arg0;
        let v19 = v6;
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_destroyed_staked_position_event(0x2::object::uid_to_inner(&v19));
        0x2::object::delete(v19);
        0x2::balance::destroy_zero<T0>(v8);
    }

    public fun end_harvest_tx(arg0: HarvestRewardsCap, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg1);
        let HarvestRewardsCap {
            vault_id       : v0,
            reward_types   : v1,
            reward_amounts : v2,
        } = arg0;
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_harvested_rewards_event(v0, v1, v2);
    }

    public fun harvest_rewards<T0, T1>(arg0: &mut HarvestRewardsCap, arg1: &mut StakedPosition<T0>, arg2: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg3: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg3);
        update_position<T0>(arg1, arg2, arg3, arg4);
        assert!(arg1.vault_id == 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg2), 1);
        assert!(arg0.vault_id == arg1.vault_id, 1);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::type_name_to_index<T0>(arg2, v0);
        let v2 = *0x1::vector::borrow<u64>(&arg1.base_rewards_accumulated, v1);
        assert!(v2 > 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::minimal_claim(), 7);
        let v3 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::claim_rewards<T0, T1>(arg2, v2, arg5);
        *0x1::vector::borrow_mut<u64>(&mut arg1.base_rewards_accumulated, v1) = 0;
        if (0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::is_strict(arg1.lock_enforcement) || is_unlocked<T0>(arg1, arg2, arg4)) {
            let v4 = *0x1::vector::borrow<u64>(&arg1.multiplier_rewards_accumulated, v1);
            if (v4 > 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::minimal_claim()) {
                *0x1::vector::borrow_mut<u64>(&mut arg1.multiplier_rewards_accumulated, v1) = 0;
                0x2::coin::join<T1>(&mut v3, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::claim_rewards<T0, T1>(arg2, v4, arg5));
            };
        };
        update_with_harvested_rewards(arg0, v0, 0x2::coin::value<T1>(&v3));
        v3
    }

    fun increase_multiplier_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: u64) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::increase_total_multiplier_staked_amount<T0>(arg1, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::calc_multiplier_staked_amount(arg2, arg0.lock_multiplier));
        update_multiplier_staked_amount<T0>(arg0, arg1);
    }

    fun increase_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
        arg0.base_rewards_debt = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::calc_rewards_debt<T0>(arg1, staked_amount<T0>(arg0));
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::increase_total_staked_amount<T0>(arg1, v0);
        increase_multiplier_staked_amount<T0>(arg0, arg1, v0);
    }

    public fun is_unlocked<T0>(arg0: &StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        lock_end_timestamp_ms<T0>(arg0) <= v0 || 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::emission_end_timestamp_ms<T0>(arg1) <= v0
    }

    public fun last_reward_timestamp_ms<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.last_reward_timestamp_ms
    }

    public fun lock<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg3: &0x2::clock::Clock, arg4: u64) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        assert!(arg0.vault_id == 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1), 1);
        assert!(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::min_lock_duration_ms<T0>(arg1) <= arg4, 2);
        assert!(arg4 <= 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::max_lock_duration_ms<T0>(arg1), 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (!is_unlocked<T0>(arg0, arg1, arg3)) {
            assert!(lock_end_timestamp_ms<T0>(arg0) - v0 <= arg4, 2);
        };
        update_position<T0>(arg0, arg1, arg2, arg3);
        arg0.lock_start_timestamp_ms = v0;
        update_lock_duration_ms<T0>(arg0, arg1, arg4);
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_locked_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.vault_id, staked_amount<T0>(arg0), v0, arg4, arg0.lock_multiplier);
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

    public fun multiplier_rewards_accumulated_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_accumulated, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::type_to_index<T0, T1>(arg1))
    }

    public fun multiplier_rewards_debt<T0>(arg0: &StakedPosition<T0>) : vector<u64> {
        arg0.multiplier_rewards_debt
    }

    public fun multiplier_rewards_debt_for<T0, T1>(arg0: &StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_debt, 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::type_to_index<T0, T1>(arg1))
    }

    public fun multiplier_staked_amount<T0>(arg0: &StakedPosition<T0>) : u64 {
        arg0.multiplier_staked_amount
    }

    public fun renew_lock<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg3: &0x2::clock::Clock) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        let v0 = arg0.lock_duration_ms;
        lock<T0>(arg0, arg1, arg2, arg3, v0);
    }

    fun return_multiplier_rewards<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::size<T0>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.multiplier_rewards_accumulated, v0);
            let v2 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::divide(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::multiply(v1, arg2), staked_amount<T0>(arg0));
            0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::reemit_rewards<T0>(arg1, v2, v0);
            *0x1::vector::borrow_mut<u64>(&mut arg0.multiplier_rewards_accumulated, v0) = v1 - v2;
            v0 = v0 + 1;
        };
    }

    public fun stake<T0>(arg0: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : StakedPosition<T0> {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::min_stake_amount<T0>(arg0) <= v0, 3);
        assert!(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::min_lock_duration_ms<T0>(arg0) <= arg5, 2);
        assert!(arg5 <= 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::max_lock_duration_ms<T0>(arg0), 2);
        assert!(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::emission_end_timestamp_ms<T0>(arg0) != 0, 6);
        let v1 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::from_u8(arg4);
        assert!(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::supports<T0>(arg0, v1), 8);
        if (0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::total_staked_amount<T0>(arg0) == 0) {
            0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::adjust_emission_start_timestamps_ms<T0>(arg0, arg2);
        };
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::emit_rewards<T0>(arg0, arg1, arg2);
        let v2 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::calc_lock_multiplier<T0>(arg0, arg5);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::size<T0>(arg0)) {
            0x1::vector::push_back<u64>(&mut v4, 0);
            v5 = v5 + 1;
        };
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::size<T0>(arg0)) {
            0x1::vector::push_back<u64>(&mut v6, 0);
            v7 = v7 + 1;
        };
        let v8 = StakedPosition<T0>{
            id                             : 0x2::object::new(arg6),
            vault_id                       : 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg0),
            balance                        : 0x2::balance::zero<T0>(),
            multiplier_staked_amount       : 0,
            lock_enforcement               : v1,
            lock_start_timestamp_ms        : v3,
            lock_duration_ms               : arg5,
            lock_multiplier                : v2,
            last_reward_timestamp_ms       : v3,
            base_rewards_accumulated       : v4,
            multiplier_rewards_accumulated : v6,
            base_rewards_debt              : vector[],
            multiplier_rewards_debt        : vector[],
        };
        let v9 = &mut v8;
        increase_staked_amount<T0>(v9, arg0, 0x2::coin::into_balance<T0>(arg3));
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_staked_event<T0>(0x2::object::uid_to_inner(&v8.id), v8.vault_id, v0, v8.multiplier_staked_amount, arg4, v3, arg5, v2);
        v8
    }

    public fun staked_amount<T0>(arg0: &StakedPosition<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun staked_amount_with_multiplier<T0>(arg0: &StakedPosition<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance) + arg0.multiplier_staked_amount
    }

    public fun unlock<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg3: &0x2::clock::Clock) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        assert!(arg0.vault_id == 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1), 1);
        assert!(is_unlocked<T0>(arg0, arg1, arg3), 0);
        update_position<T0>(arg0, arg1, arg2, arg3);
    }

    fun unlock_<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x2::clock::Clock) {
        assert!(is_unlocked<T0>(arg0, arg1, arg2), 0);
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::decrease_total_multiplier_staked_amount<T0>(arg1, arg0.multiplier_staked_amount);
        arg0.multiplier_staked_amount = 0;
        arg0.lock_duration_ms = 0;
        arg0.lock_multiplier = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::lock_multiplier_lower_bound();
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_unlocked_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.vault_id, staked_amount<T0>(arg0));
    }

    fun update_lock_duration_ms<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: u64) {
        if (arg2 == arg0.lock_duration_ms) {
            return
        };
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::decrease_total_multiplier_staked_amount<T0>(arg1, arg0.multiplier_staked_amount);
        arg0.lock_duration_ms = arg2;
        arg0.lock_multiplier = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::calc_lock_multiplier<T0>(arg1, arg2);
        let v0 = staked_amount<T0>(arg0);
        increase_multiplier_staked_amount<T0>(arg0, arg1, v0);
    }

    fun update_multiplier_staked_amount<T0>(arg0: &mut StakedPosition<T0>, arg1: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>) {
        let v0 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::utils::calc_multiplier_staked_amount(staked_amount<T0>(arg0), arg0.lock_multiplier);
        arg0.multiplier_staked_amount = v0;
        arg0.multiplier_rewards_debt = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::calc_rewards_debt<T0>(arg1, v0);
    }

    public fun update_position<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg3: &0x2::clock::Clock) {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        assert!(arg0.vault_id == 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1), 1);
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::emit_rewards<T0>(arg1, arg2, arg3);
        let v0 = 0;
        let v1 = 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::total_rewards_accumulated_per_share<T0>(arg1);
        while (v0 < 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::size<T0>(arg1)) {
            accrue_reward<T0>(arg0, arg1, *0x1::vector::borrow<u128>(&v1, v0), v0);
            v0 = v0 + 1;
        };
        if (is_unlocked<T0>(arg0, arg1, arg3)) {
            unlock_<T0>(arg0, arg1, arg3);
        };
        arg0.last_reward_timestamp_ms = 0x2::clock::timestamp_ms(arg3);
    }

    fun update_with_harvested_rewards(arg0: &mut HarvestRewardsCap, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.reward_types, &arg1);
        let v2 = v1;
        if (!v0) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.reward_types, arg1);
            0x1::vector::push_back<u64>(&mut arg0.reward_amounts, 0);
            v2 = 0x1::vector::length<0x1::type_name::TypeName>(&arg0.reward_types) - 1;
        };
        *0x1::vector::borrow_mut<u64>(&mut arg0.reward_amounts, v2) = *0x1::vector::borrow<u64>(&arg0.reward_amounts, v2) + arg2;
    }

    public fun vault_id<T0>(arg0: &StakedPosition<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun withdraw_principal<T0>(arg0: &mut StakedPosition<T0>, arg1: &mut 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>, arg2: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::Version, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version::assert_correct_package(arg2);
        assert!(arg0.vault_id == 0x2::object::id<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::Vault<T0>>(arg1), 1);
        if (arg4 == 0) {
            return 0x2::coin::zero<T0>(arg5)
        };
        let v0 = is_unlocked<T0>(arg0, arg1, arg3);
        if (0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::is_strict(arg0.lock_enforcement)) {
            assert!(v0, 0);
        };
        let v1 = staked_amount<T0>(arg0);
        assert!(arg4 <= v1, 4);
        let v2 = v1 - arg4;
        assert!(0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::min_stake_amount<T0>(arg1) <= v2 || v2 == 0, 3);
        update_position<T0>(arg0, arg1, arg2, arg3);
        if (0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::vault::is_relaxed(arg0.lock_enforcement) && !v0) {
            return_multiplier_rewards<T0>(arg0, arg1, arg4);
        };
        let v3 = decrease_staked_amount<T0>(arg0, arg1, arg4);
        0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events::emit_withdrew_principal_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.vault_id, arg4);
        0x2::coin::from_balance<T0>(v3, arg5)
    }

    // decompiled from Move bytecode v6
}

