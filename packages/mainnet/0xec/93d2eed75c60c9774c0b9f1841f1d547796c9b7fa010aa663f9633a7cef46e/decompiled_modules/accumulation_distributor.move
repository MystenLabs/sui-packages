module 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::accumulation_distributor {
    struct AccumulationDistributor has store {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        acc_rewards_per_share_x64: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        total_shares: u64,
        extraneous_balances: 0x2::bag::Bag,
    }

    struct PositionBalance has store {
        available_rewards: u64,
        last_acc_rewards_per_share_x64: u256,
    }

    struct Position has store {
        ad_id: 0x2::object::ID,
        shares: u64,
        balances: 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionBalance>,
    }

    public fun balance_value<T0>(arg0: &AccumulationDistributor) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
    }

    fun calc_position_unlockable_rewards_idx(arg0: &AccumulationDistributor, arg1: &Position, arg2: u64) : u64 {
        let (_, v1) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, arg2);
        let v2 = if (arg2 < 0x2::vec_map::size<0x1::type_name::TypeName, PositionBalance>(&arg1.balances)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PositionBalance>(&arg1.balances, arg2);
            v4.last_acc_rewards_per_share_x64
        } else {
            0
        };
        (((*v1 - v2) * (arg1.shares as u256) / (18446744073709551616 as u256)) as u64)
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : AccumulationDistributor {
        AccumulationDistributor{
            id                        : 0x2::object::new(arg0),
            balances                  : 0x2::bag::new(arg0),
            acc_rewards_per_share_x64 : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            total_shares              : 0,
            extraneous_balances       : 0x2::bag::new(arg0),
        }
    }

    public fun deposit_shares(arg0: &mut AccumulationDistributor, arg1: &mut Position, arg2: u64) {
        assert!(0x2::object::uid_as_inner(&arg0.id) == &arg1.ad_id, 0);
        update_position(arg0, arg1);
        arg0.total_shares = arg0.total_shares + arg2;
        arg1.shares = arg1.shares + arg2;
    }

    public fun deposit_shares_new(arg0: &mut AccumulationDistributor, arg1: u64) : Position {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, PositionBalance>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, v1);
            let v4 = PositionBalance{
                available_rewards              : 0,
                last_acc_rewards_per_share_x64 : *v3,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, PositionBalance>(&mut v0, *v2, v4);
            v1 = v1 + 1;
        };
        arg0.total_shares = arg0.total_shares + arg1;
        Position{
            ad_id    : 0x2::object::uid_to_inner(&arg0.id),
            shares   : arg1,
            balances : v0,
        }
    }

    public fun has_balance(arg0: &AccumulationDistributor, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, arg1)
    }

    public fun has_balance_with_type<T0>(arg0: &AccumulationDistributor) : bool {
        let v0 = 0x1::type_name::get<T0>();
        has_balance(arg0, &v0)
    }

    public fun merge_positions(arg0: &mut AccumulationDistributor, arg1: &mut Position, arg2: Position) {
        let v0 = 0x2::object::uid_as_inner(&arg0.id);
        assert!(&arg2.ad_id == v0, 0);
        assert!(&arg1.ad_id == v0, 0);
        let v1 = &mut arg2;
        update_position(arg0, v1);
        update_position(arg0, arg1);
        let v2 = 0;
        let v3 = 0x2::vec_map::size<0x1::type_name::TypeName, PositionBalance>(&arg1.balances);
        while (v2 < v3) {
            let (_, v5) = 0x2::vec_map::pop<0x1::type_name::TypeName, PositionBalance>(&mut arg2.balances);
            let v6 = v5;
            let (_, v8) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, PositionBalance>(&mut arg1.balances, v3 - 1 - v2);
            v8.available_rewards = v8.available_rewards + v6.available_rewards;
            let PositionBalance {
                available_rewards              : _,
                last_acc_rewards_per_share_x64 : _,
            } = v6;
            v2 = v2 + 1;
        };
        arg1.shares = arg1.shares + arg2.shares;
        let Position {
            ad_id    : _,
            shares   : _,
            balances : v13,
        } = arg2;
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, PositionBalance>(v13);
    }

    fun position_add_missing_balances(arg0: &AccumulationDistributor, arg1: &mut Position) {
        let v0 = 0x2::vec_map::size<0x1::type_name::TypeName, PositionBalance>(&arg1.balances);
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64)) {
            let (v1, _) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, v0);
            let v3 = PositionBalance{
                available_rewards              : 0,
                last_acc_rewards_per_share_x64 : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, PositionBalance>(&mut arg1.balances, *v1, v3);
            v0 = v0 + 1;
        };
    }

    public fun position_destroy_empty(arg0: Position) {
        assert!(arg0.shares == 0, 2);
        let Position {
            ad_id    : _,
            shares   : _,
            balances : v2,
        } = arg0;
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x2::vec_map::size<0x1::type_name::TypeName, PositionBalance>(&v3)) {
            let (_, v6) = 0x2::vec_map::pop<0x1::type_name::TypeName, PositionBalance>(&mut v3);
            let PositionBalance {
                available_rewards              : v7,
                last_acc_rewards_per_share_x64 : _,
            } = v6;
            assert!(v7 == 0, 2);
            v4 = v4 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, PositionBalance>(v3);
    }

    public fun position_reward_value_direct(arg0: &AccumulationDistributor, arg1: &Position, arg2: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x2::vec_map::get_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, &arg2);
        if (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, PositionBalance>(&arg1.balances)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PositionBalance>(&arg1.balances, v0);
            v3.available_rewards
        } else {
            0
        }
    }

    public fun position_rewards_value(arg0: &AccumulationDistributor, arg1: &Position, arg2: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x2::vec_map::get_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, &arg2);
        let v1 = if (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, PositionBalance>(&arg1.balances)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PositionBalance>(&arg1.balances, v0);
            v3.available_rewards
        } else {
            0
        };
        v1 + calc_position_unlockable_rewards_idx(arg0, arg1, v0)
    }

    public fun position_rewards_value_direct_with_type<T0>(arg0: &AccumulationDistributor, arg1: &Position) : u64 {
        position_reward_value_direct(arg0, arg1, 0x1::type_name::get<T0>())
    }

    public fun position_rewards_value_with_type<T0>(arg0: &AccumulationDistributor, arg1: &Position) : u64 {
        position_rewards_value(arg0, arg1, 0x1::type_name::get<T0>())
    }

    public fun position_shares(arg0: &Position) : u64 {
        arg0.shares
    }

    public fun remove_extraneous_balance<T0>(arg0: &mut AccumulationDistributor) : 0x2::balance::Balance<T0> {
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.extraneous_balances, 0x1::type_name::get<T0>())
    }

    public fun top_up<T0>(arg0: &mut AccumulationDistributor, arg1: 0x2::balance::Balance<T0>) {
        if (arg0.total_shares == 0) {
            let v0 = 0x1::type_name::get<T0>();
            if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.extraneous_balances, v0)) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.extraneous_balances, v0), arg1);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.extraneous_balances, v0, arg1);
            };
            return
        };
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::vec_map::get_idx_opt<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, &v1);
        let v3 = if (0x1::option::is_some<u64>(&v2)) {
            0x1::option::destroy_some<u64>(v2)
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, 0x2::balance::zero<T0>());
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_share_x64, v1, 0);
            0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64) - 1
        };
        let (_, v5) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_share_x64, v3);
        *v5 = *v5 + (0x2::balance::value<T0>(&arg1) as u256) * (18446744073709551616 as u256) / (arg0.total_shares as u256);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), arg1);
    }

    public fun total_shares(arg0: &AccumulationDistributor) : u64 {
        arg0.total_shares
    }

    fun update_position(arg0: &AccumulationDistributor, arg1: &mut Position) {
        position_add_missing_balances(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64)) {
            update_position_single(arg0, arg1, v0);
            v0 = v0 + 1;
        };
    }

    fun update_position_single(arg0: &AccumulationDistributor, arg1: &mut Position, arg2: u64) {
        let (_, v1) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, PositionBalance>(&mut arg1.balances, arg2);
        let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_share_x64, arg2);
        v1.available_rewards = v1.available_rewards + calc_position_unlockable_rewards_idx(arg0, arg1, arg2);
        v1.last_acc_rewards_per_share_x64 = *v3;
    }

    public fun withdraw_all_rewards<T0>(arg0: &mut AccumulationDistributor, arg1: &mut Position) : 0x2::balance::Balance<T0> {
        assert!(0x2::object::uid_as_inner(&arg0.id) == &arg1.ad_id, 0);
        position_add_missing_balances(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::vec_map::get_idx<0x1::type_name::TypeName, PositionBalance>(&arg1.balances, &v0);
        update_position_single(arg0, arg1, v1);
        let (_, v3) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, PositionBalance>(&mut arg1.balances, v1);
        v3.available_rewards = 0;
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), v3.available_rewards)
    }

    public fun withdraw_rewards<T0>(arg0: &mut AccumulationDistributor, arg1: &mut Position, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::object::uid_as_inner(&arg0.id) == &arg1.ad_id, 0);
        position_add_missing_balances(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::vec_map::get_idx<0x1::type_name::TypeName, PositionBalance>(&arg1.balances, &v0);
        let (_, v3) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, PositionBalance>(&mut arg1.balances, v1);
        if (v3.available_rewards < arg2) {
            update_position_single(arg0, arg1, v1);
        };
        let (_, v5) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, PositionBalance>(&mut arg1.balances, v1);
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(v5.available_rewards >= arg2, 1);
        v5.available_rewards = v5.available_rewards - arg2;
        0x2::balance::split<T0>(v6, arg2)
    }

    public fun withdraw_rewards_direct<T0>(arg0: &mut AccumulationDistributor, arg1: &mut Position, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::object::uid_as_inner(&arg0.id) == &arg1.ad_id, 0);
        position_add_missing_balances(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, PositionBalance>(&mut arg1.balances, 0x2::vec_map::get_idx<0x1::type_name::TypeName, PositionBalance>(&arg1.balances, &v0));
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(v2.available_rewards >= arg2, 1);
        v2.available_rewards = v2.available_rewards - arg2;
        0x2::balance::split<T0>(v3, arg2)
    }

    public fun withdraw_shares(arg0: &mut AccumulationDistributor, arg1: &mut Position, arg2: u64) {
        assert!(0x2::object::uid_as_inner(&arg0.id) == &arg1.ad_id, 0);
        assert!(arg1.shares >= arg2, 1);
        update_position(arg0, arg1);
        arg0.total_shares = arg0.total_shares - arg2;
        arg1.shares = arg1.shares - arg2;
    }

    // decompiled from Move bytecode v6
}

