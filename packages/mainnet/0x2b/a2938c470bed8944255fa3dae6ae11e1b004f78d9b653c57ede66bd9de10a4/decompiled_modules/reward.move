module 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::reward {
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
        reward_refunded: u256,
        reward_harvested: u128,
    }

    struct USDC {
        dummy_field: bool,
    }

    struct SUI {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : RewardManager {
        RewardManager{
            is_public              : true,
            vault                  : 0x2::bag::new(arg0),
            rewards                : 0x1::vector::empty<Reward>(),
            last_updated_time      : 0,
            emergency_reward_pause : false,
        }
    }

    public(friend) fun add_reward<T0>(arg0: &mut RewardManager, arg1: vector<u64>, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(arg2 > v0, 13906835076287430671);
        let v1 = if (0x1::vector::is_empty<u64>(&arg1)) {
            v0
        } else {
            assert!(0x1::vector::length<u64>(&arg1) == 1, 13906835093467168781);
            let v2 = 0x1::vector::pop_back<u64>(&mut arg1);
            assert!(v2 >= v0, 13906835102057103373);
            assert!(v2 < arg2, 13906835106352070669);
            v2
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((0x2::balance::value<T0>(&arg3) as u128), 1 << 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::scale_offset(), ((arg2 - v1) as u128));
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
            assert!(340282366920938463463374607431768211455 - v5.current_emission_rate >= v3, 13906835256675794955);
            v5.current_emission_rate = v5.current_emission_rate + v3;
        };
        deposit<T0>(arg0, arg3);
    }

    public(friend) fun borrow_mut_reward(arg0: &mut RewardManager, arg1: u64) : &mut Reward {
        0x1::vector::borrow_mut<Reward>(&mut arg0.rewards, arg1)
    }

    public(friend) fun borrow_mut_reward_by_type<T0>(arg0: &mut RewardManager) : &mut Reward {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906836038359449605);
        borrow_mut_reward(arg0, 0x1::option::extract<u64>(&mut v0))
    }

    public fun borrow_reward(arg0: &RewardManager, arg1: u64) : &Reward {
        0x1::vector::borrow<Reward>(&arg0.rewards, arg1)
    }

    public fun borrow_reward_by_type<T0>(arg0: &RewardManager) : &Reward {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906836089899057157);
        borrow_reward(arg0, 0x1::option::extract<u64>(&mut v0))
    }

    public fun current_emission_rate(arg0: &Reward) : u128 {
        arg0.current_emission_rate
    }

    fun current_period_end_time(arg0: u64) : u64 {
        assert!(arg0 >= 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::reward_period_start_at(), 13906837266721144853);
        arg0 + 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::reward_period() - (arg0 - 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::reward_period_start_at()) % 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::reward_period()
    }

    public(friend) fun deposit<T0>(arg0: &mut RewardManager, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), arg1)
    }

    public fun emergency_pause(arg0: &mut RewardManager) {
        arg0.emergency_reward_pause = true;
    }

    public fun emergency_reward_pause(arg0: &RewardManager) : bool {
        arg0.emergency_reward_pause
    }

    public fun emergency_unpause(arg0: &mut RewardManager) {
        arg0.emergency_reward_pause = false;
    }

    public fun get_index<T0>(arg0: &RewardManager) : u64 {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906836635359903749);
        0x1::option::extract<u64>(&mut v0)
    }

    public(friend) fun initialize_reward<T0>(arg0: &mut RewardManager, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = reward_index<T0>(arg0);
        assert!(0x1::option::is_none<u64>(&v0), 13906834900192854017);
        assert!(0x1::vector::length<Reward>(&arg0.rewards) < 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::constants::max_reward_num(), 13906834904487952387);
        let v1 = Reward{
            reward_coin           : 0x1::type_name::get<T0>(),
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
        arg0.is_public = false;
    }

    public(friend) fun make_public(arg0: &mut RewardManager) {
        arg0.is_public = true;
    }

    public fun period_emission_rates(arg0: &Reward) : &0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::SkipList<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128> {
        &arg0.period_emission_rates
    }

    public(friend) fun refund_rewards(arg0: &mut RewardManager, arg1: vector<u128>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Reward>(&arg0.rewards)) {
            let v1 = borrow_mut_reward(arg0, v0);
            v1.reward_released = v1.reward_released - (*0x1::vector::borrow<u128>(&arg1, v0) as u256);
            assert!(v1.reward_refunded + (*0x1::vector::borrow<u128>(&arg1, v0) as u256) < 115792089237316195423570985008687907853269984665640564039457584007913129639935, 13906835840791871507);
            v1.reward_refunded = v1.reward_refunded + (*0x1::vector::borrow<u128>(&arg1, v0) as u256);
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
        let v1 = 0x1::option::none<u64>();
        while (v0 < 0x1::vector::length<Reward>(&arg0.rewards)) {
            if (0x1::vector::borrow<Reward>(&arg0.rewards, v0).reward_coin == 0x1::type_name::get<T0>()) {
                v1 = 0x1::option::some<u64>(v0);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun reward_num(arg0: &RewardManager) : u64 {
        0x1::vector::length<Reward>(&arg0.rewards)
    }

    public fun reward_refunded(arg0: &Reward) : u256 {
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
            assert!(v2.reward_refunded + (*0x1::vector::borrow<u128>(&arg1, v0) as u256) < 340282366920938463463374607431768211455, 13906835690468016147);
            v2.reward_refunded = 0;
            let v3 = current_period_end_time(v1);
            let v4 = ((v2.reward_refunded as u128) + *0x1::vector::borrow<u128>(&arg1, v0)) / ((v3 - v1) as u128);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v2.period_emission_rates, v3)) {
                let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_mut<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v2.period_emission_rates, v3);
                *v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::sub(*v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(v4));
            } else {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::insert<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&mut v2.period_emission_rates, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::neg_from(v4));
            };
            assert!(340282366920938463463374607431768211455 - v2.current_emission_rate >= v4, 13906835746302066699);
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
        assert!(v0 < v1, 13906835385524551687);
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
                assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v8), 13906835505784291345);
                v4.current_emission_rate = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(v8);
                v0 = v7;
                v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::next_score<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list::borrow_node<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128>(&v4.period_emission_rates, v7));
                if (v7 < v1) {
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
        let v0 = 0x1::type_name::get<T0>();
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
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v1), 13906836240223174665);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 13906836248813109257);
        0x2::balance::split<T0>(v2, arg1)
    }

    // decompiled from Move bytecode v6
}

