module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::reward {
    struct RewardManager has store {
        is_public: bool,
        vault: 0x2::bag::Bag,
        rewards: vector<Reward>,
        last_updated_time: u64,
        emergency_reward_pause: bool,
    }

    struct Reward has store {
        reward_coin: 0x1::type_name::TypeName,
        current_emission_rate: u128,
        period_emission_rates: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>,
        reward_released: u256,
        reward_refunded: u128,
        reward_harvested: u128,
    }

    struct USDC {
        dummy_field: bool,
    }

    struct SUI {
        dummy_field: bool,
    }

    public(friend) fun add_reward<T0>(arg0: &mut RewardManager, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) {
        assert!(!arg0.emergency_reward_pause, 13906835114942529557);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(arg2 > v0, 13906835127827038223);
        let v1 = if (0x1::option::is_none<u64>(&arg1)) {
            v0
        } else {
            let v2 = 0x1::option::extract<u64>(&mut arg1);
            assert!(v2 >= v0, 13906835149301743629);
            assert!(v2 < arg2, 13906835153596710925);
            v2
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((0x2::balance::value<T0>(&arg3) as u128), 18446744073709551616, ((arg2 - v1) as u128));
        let v4 = get_index<T0>(arg0);
        let v5 = borrow_mut_reward(arg0, v4);
        if (v1 != v0) {
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v5.period_emission_rates, v1)) {
                let v6 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v5.period_emission_rates, v1);
                *v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(v3), *v6);
            } else {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v5.period_emission_rates, v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(v3));
            };
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v5.period_emission_rates, arg2)) {
            let v7 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v5.period_emission_rates, arg2);
            *v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::sub(*v7, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(v3));
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v5.period_emission_rates, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::neg_from(v3));
        };
        if (v1 == v0) {
            assert!(340282366920938463463374607431768211455 - v5.current_emission_rate >= v3, 13906835303920435211);
            v5.current_emission_rate = v5.current_emission_rate + v3;
        };
        deposit<T0>(arg0, arg3);
    }

    public(friend) fun borrow_mut_reward(arg0: &mut RewardManager, arg1: u64) : &mut Reward {
        0x1::vector::borrow_mut<Reward>(&mut arg0.rewards, arg1)
    }

    public(friend) fun borrow_mut_reward_by_type<T0>(arg0: &mut RewardManager) : &mut Reward {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906836141438664709);
        borrow_mut_reward(arg0, 0x1::option::extract<u64>(&mut v0))
    }

    public fun borrow_reward(arg0: &RewardManager, arg1: u64) : &Reward {
        0x1::vector::borrow<Reward>(&arg0.rewards, arg1)
    }

    public fun borrow_reward_by_type<T0>(arg0: &RewardManager) : &Reward {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906836192978272261);
        borrow_reward(arg0, 0x1::option::extract<u64>(&mut v0))
    }

    public fun current_emission_rate(arg0: &Reward) : u128 {
        arg0.current_emission_rate
    }

    fun current_period_end_time(arg0: u64) : u64 {
        assert!(arg0 >= 1757332800, 13906837365505261587);
        arg0 + 604800 - (arg0 - 1757332800) % 604800
    }

    public(friend) fun deposit<T0>(arg0: &mut RewardManager, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), arg1)
    }

    public(friend) fun emergency_pause(arg0: &mut RewardManager) {
        assert!(!arg0.emergency_reward_pause, 13906834719805800473);
        arg0.emergency_reward_pause = true;
    }

    public fun emergency_reward_pause(arg0: &RewardManager) : bool {
        arg0.emergency_reward_pause
    }

    public(friend) fun emergency_unpause(arg0: &mut RewardManager) {
        assert!(arg0.emergency_reward_pause, 13906834758460506137);
        arg0.emergency_reward_pause = false;
    }

    public(friend) fun emergency_withdraw_refund_reward<T0>(arg0: &mut RewardManager) : 0x2::balance::Balance<T0> {
        let v0 = borrow_mut_reward_by_type<T0>(arg0);
        v0.reward_refunded = 0;
        withdraw<T0>(arg0, ((v0.reward_refunded / 18446744073709551616) as u64))
    }

    public fun get_index<T0>(arg0: &RewardManager) : u64 {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906836734144151557);
        0x1::option::extract<u64>(&mut v0)
    }

    public(friend) fun initialize_reward<T0>(arg0: &mut RewardManager, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_none<u64>(&v0), 13906834943142526977);
        assert!(0x1::vector::length<Reward>(&arg0.rewards) < 5, 13906834947437625347);
        assert!(!arg0.emergency_reward_pause, 13906834951733772309);
        let v1 = Reward{
            reward_coin           : 0x1::type_name::with_defining_ids<T0>(),
            current_emission_rate : 0,
            period_emission_rates : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::new<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(16, 2, 0x2::clock::timestamp_ms(arg1), arg2),
            reward_released       : 0,
            reward_refunded       : 0,
            reward_harvested      : 0,
        };
        0x1::vector::push_back<Reward>(&mut arg0.rewards, v1);
    }

    public fun is_public(arg0: &RewardManager) : bool {
        arg0.is_public
    }

    public fun last_update_time(arg0: &RewardManager) : u64 {
        arg0.last_updated_time
    }

    public(friend) fun make_private(arg0: &mut RewardManager) {
        assert!(arg0.is_public, 13906834835769917465);
        arg0.is_public = false;
    }

    public(friend) fun make_public(arg0: &mut RewardManager) {
        assert!(!arg0.is_public, 13906834797115211801);
        arg0.is_public = true;
    }

    public(friend) fun new_reward_manager(arg0: &mut 0x2::tx_context::TxContext) : RewardManager {
        RewardManager{
            is_public              : true,
            vault                  : 0x2::bag::new(arg0),
            rewards                : 0x1::vector::empty<Reward>(),
            last_updated_time      : 0,
            emergency_reward_pause : false,
        }
    }

    public fun period_emission_rates(arg0: &Reward) : &0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128> {
        &arg0.period_emission_rates
    }

    public(friend) fun refund_rewards(arg0: &mut RewardManager, arg1: vector<u128>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Reward>(&arg0.rewards)) {
            let v1 = borrow_mut_reward(arg0, v0);
            v1.reward_released = v1.reward_released - (*0x1::vector::borrow<u128>(&arg1, v0) as u256);
            assert!(340282366920938463463374607431768211455 - v1.reward_refunded >= *0x1::vector::borrow<u128>(&arg1, v0), 13906835857972002839);
            v1.reward_refunded = v1.reward_refunded + *0x1::vector::borrow<u128>(&arg1, v0);
            v0 = v0 + 1;
        };
    }

    public fun reward_coin(arg0: &Reward) : 0x1::type_name::TypeName {
        arg0.reward_coin
    }

    public fun reward_harvested(arg0: &Reward) : u128 {
        arg0.reward_harvested
    }

    public fun reward_index<T0>(arg0: &RewardManager) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Reward>(&arg0.rewards)) {
            if (0x1::vector::borrow<Reward>(&arg0.rewards, v0).reward_coin == 0x1::type_name::with_defining_ids<T0>()) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun reward_num(arg0: &RewardManager) : u64 {
        0x1::vector::length<Reward>(&arg0.rewards)
    }

    public fun reward_refunded(arg0: &Reward) : u128 {
        arg0.reward_refunded
    }

    public fun reward_released(arg0: &Reward) : u256 {
        arg0.reward_released
    }

    public fun rewards(arg0: &RewardManager) : &vector<Reward> {
        &arg0.rewards
    }

    public(friend) fun rollover_refunds_into_remaining_time(arg0: &mut RewardManager, arg1: vector<u128>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        while (v0 < 0x1::vector::length<Reward>(&arg0.rewards)) {
            if (*0x1::vector::borrow<u128>(&arg1, v0) == 0) {
                v0 = v0 + 1;
                continue
            };
            let v2 = borrow_mut_reward(arg0, v0);
            v2.reward_released = v2.reward_released - (*0x1::vector::borrow<u128>(&arg1, v0) as u256);
            let v3 = current_period_end_time(v1);
            let v4 = *0x1::vector::borrow<u128>(&arg1, v0) / ((v3 - v1) as u128);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v2.period_emission_rates, v3)) {
                let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v2.period_emission_rates, v3);
                *v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::sub(*v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(v4));
            } else {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v2.period_emission_rates, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::neg_from(v4));
            };
            assert!(340282366920938463463374607431768211455 - v2.current_emission_rate >= v4, 13906835763481935883);
            v2.current_emission_rate = v2.current_emission_rate + v4;
            v0 = v0 + 1;
        };
    }

    public(friend) fun settle_rewards(arg0: &mut RewardManager, arg1: &0x2::clock::Clock) : vector<u128> {
        let v0 = arg0.last_updated_time;
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v1 == v0) {
            return 0x1::vector::empty<u128>()
        };
        assert!(v0 < v1, 13906835432769191943);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u128>();
        while (v2 < 0x1::vector::length<Reward>(&arg0.rewards)) {
            let v4 = borrow_mut_reward(arg0, v2);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::is_empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v4.period_emission_rates)) {
                v2 = v2 + 1;
                0x1::vector::push_back<u128>(&mut v3, 0);
                continue
            };
            let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::find_next<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v4.period_emission_rates, v0, false);
            let v6 = 0;
            while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v5) && v1 > v0) {
                let v7 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v5);
                v6 = v6 + ((0x1::u64::min(v1, v7) - v0) as u128) * v4.current_emission_rate;
                if (v1 < v7) {
                    break
                };
                let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(v4.current_emission_rate), *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v4.period_emission_rates, v7));
                assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v8), 13906835553028931601);
                v4.current_emission_rate = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(v8);
                v0 = v7;
                v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v4.period_emission_rates, v7));
                if (v7 <= v1) {
                    0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::remove<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v4.period_emission_rates, v7);
                };
            };
            v4.reward_released = v4.reward_released + (v6 as u256);
            0x1::vector::push_back<u128>(&mut v3, v6);
            v2 = v2 + 1;
        };
        arg0.last_updated_time = v1;
        v3
    }

    public fun vault(arg0: &RewardManager) : &0x2::bag::Bag {
        &arg0.vault
    }

    public fun vault_amount<T0>(arg0: &RewardManager) : u64 {
        get_index<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault, v0))
    }

    public(friend) fun withdraw<T0>(arg0: &mut RewardManager, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = borrow_mut_reward_by_type<T0>(arg0);
        v0.reward_harvested = v0.reward_harvested + (arg1 as u128);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v1), 13906836343302389769);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 13906836351892324361);
        0x2::balance::split<T0>(v2, arg1)
    }

    // decompiled from Move bytecode v6
}

