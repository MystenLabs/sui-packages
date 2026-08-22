module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::reward_accumulator {
    struct RewardAccumulator has store {
        id: 0x2::object::UID,
        total_shares: u64,
        acc_rps_x64: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        reward_balances: 0x2::bag::Bag,
        extraneous_balances: 0x2::bag::Bag,
    }

    struct UserRewardState has store {
        shares: u64,
        reward_debt_x64: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : RewardAccumulator {
        RewardAccumulator{
            id                  : 0x2::object::new(arg0),
            total_shares        : 0,
            acc_rps_x64         : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            reward_balances     : 0x2::bag::new(arg0),
            extraneous_balances : 0x2::bag::new(arg0),
        }
    }

    fun calc_unsettled(arg0: &RewardAccumulator, arg1: &UserRewardState, arg2: &0x1::type_name::TypeName) : u64 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.acc_rps_x64, arg2)) {
            return 0
        };
        let v0 = get_debt(arg1, arg2);
        let v1 = (arg1.shares as u256) * *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.acc_rps_x64, arg2);
        if (v1 <= v0) {
            return 0
        };
        (((v1 - v0) / 18446744073709551616) as u64)
    }

    public fun claim<T0>(arg0: &mut RewardAccumulator, arg1: &mut UserRewardState) : 0x2::balance::Balance<T0> {
        settle_all(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.pending_rewards, &v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.pending_rewards, &v0);
        let v2 = *v1;
        *v1 = 0;
        if (v2 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_balances, v0), v2)
    }

    public fun deposit_shares(arg0: &mut RewardAccumulator, arg1: &mut UserRewardState, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        settle_all(arg0, arg1);
        arg1.shares = arg1.shares + arg2;
        arg0.total_shares = arg0.total_shares + arg2;
        sync_all_debt(arg0, arg1);
    }

    public fun destroy_empty_user_state(arg0: UserRewardState) {
        let UserRewardState {
            shares          : v0,
            reward_debt_x64 : _,
            pending_rewards : v2,
        } = arg0;
        let v3 = v2;
        assert!(v0 == 0, 1);
        let v4 = 0;
        while (v4 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v3)) {
            let (_, v6) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v3, v4);
            assert!(*v6 == 0, 1);
            v4 = v4 + 1;
        };
    }

    fun get_debt(arg0: &UserRewardState, arg1: &0x1::type_name::TypeName) : u256 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.reward_debt_x64, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_debt_x64, arg1)
        } else {
            0
        }
    }

    fun get_or_insert_pending(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName) : &mut u64 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, &arg1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(arg0, arg1, 0);
        };
        0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(arg0, &arg1)
    }

    fun get_pending_amount(arg0: &UserRewardState, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, arg1)
        } else {
            0
        }
    }

    public fun has_balance<T0>(arg0: &RewardAccumulator) : bool {
        0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.reward_balances, 0x1::type_name::get<T0>())
    }

    fun join_bag_balance<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x1::type_name::TypeName, arg2: 0x2::balance::Balance<T0>) {
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, arg1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, arg1), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, arg1, arg2);
        };
    }

    public fun new_user_state() : UserRewardState {
        UserRewardState{
            shares          : 0,
            reward_debt_x64 : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            pending_rewards : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        }
    }

    public fun pending_reward<T0>(arg0: &RewardAccumulator, arg1: &UserRewardState) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        get_pending_amount(arg1, &v0) + calc_unsettled(arg0, arg1, &v0)
    }

    public fun reward_balance_value<T0>(arg0: &RewardAccumulator) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.reward_balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.reward_balances, v0))
        } else {
            0
        }
    }

    fun set_or_insert_debt(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg1: 0x1::type_name::TypeName, arg2: u256) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(arg0, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(arg0, arg1, arg2);
        };
    }

    fun settle_all(arg0: &RewardAccumulator, arg1: &mut UserRewardState) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg0.acc_rps_x64)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rps_x64, v0);
            let v3 = get_debt(arg1, v1);
            let v4 = (arg1.shares as u256) * *v2;
            if (v4 > v3) {
                let v5 = (((v4 - v3) / 18446744073709551616) as u64);
                if (v5 > 0) {
                    let v6 = &mut arg1.pending_rewards;
                    let v7 = get_or_insert_pending(v6, *v1);
                    *v7 = *v7 + v5;
                };
            };
            let v8 = &mut arg1.reward_debt_x64;
            set_or_insert_debt(v8, *v1, v4);
            v0 = v0 + 1;
        };
    }

    fun sync_all_debt(arg0: &RewardAccumulator, arg1: &mut UserRewardState) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg0.acc_rps_x64)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rps_x64, v0);
            let v3 = &mut arg1.reward_debt_x64;
            set_or_insert_debt(v3, *v1, (arg1.shares as u256) * *v2);
            v0 = v0 + 1;
        };
    }

    public fun top_up<T0>(arg0: &mut RewardAccumulator, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = 0x1::type_name::get<T0>();
        if (arg0.total_shares == 0) {
            let v2 = &mut arg0.extraneous_balances;
            join_bag_balance<T0>(v2, v1, arg1);
            return
        };
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.acc_rps_x64, &v1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rps_x64, v1, 0);
        };
        let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rps_x64, &v1);
        *v3 = *v3 + (v0 as u256) * 18446744073709551616 / (arg0.total_shares as u256);
        let v4 = &mut arg0.reward_balances;
        join_bag_balance<T0>(v4, v1, arg1);
    }

    public fun total_shares(arg0: &RewardAccumulator) : u64 {
        arg0.total_shares
    }

    public fun user_shares(arg0: &UserRewardState) : u64 {
        arg0.shares
    }

    public fun withdraw_extraneous<T0>(arg0: &mut RewardAccumulator) : 0x2::balance::Balance<T0> {
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.extraneous_balances, 0x1::type_name::get<T0>())
    }

    public fun withdraw_shares(arg0: &mut RewardAccumulator, arg1: &mut UserRewardState, arg2: u64) {
        assert!(arg1.shares >= arg2, 0);
        if (arg2 == 0) {
            return
        };
        settle_all(arg0, arg1);
        arg1.shares = arg1.shares - arg2;
        arg0.total_shares = arg0.total_shares - arg2;
        sync_all_debt(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

