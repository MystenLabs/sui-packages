module 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge {
    struct Gauge has store, key {
        id: 0x2::object::UID,
        config: 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::GaugeConfig,
        current_epoch_id: u64,
        total_vote_power: u64,
        vote_power_unlocks: 0x2::vec_map::VecMap<u64, u64>,
        fee_x_amount: u64,
        fee_y_amount: u64,
        incentive_amount: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        epoch_history: 0x2::vec_map::VecMap<u64, GaugeEpochState>,
        incentive_epoch_start: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        fee_last_claimed_ms: u64,
        balances: 0x2::bag::Bag,
    }

    struct GaugeEpochState has store, key {
        id: 0x2::object::UID,
        epoch_id: u64,
        total_vote_power: u64,
        fee_x_amount: u64,
        fee_y_amount: u64,
        incentive_amount: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public(friend) fun add_fees<T0, T1>(arg0: &mut Gauge, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64) {
        check_fee_types<T0, T1>(arg0);
        arg0.fee_x_amount = arg0.fee_x_amount + 0x2::balance::value<T0>(&arg1);
        arg0.fee_y_amount = arg0.fee_y_amount + 0x2::balance::value<T1>(&arg2);
        set_fee_last_claimed(arg0, arg3);
        put_balance<T0>(arg0, arg1);
        put_balance<T1>(arg0, arg2);
    }

    public(friend) fun add_incentive<T0>(arg0: &mut Gauge, arg1: 0x2::balance::Balance<T0>) {
        set_incentive_start_if_not_exist<T0>(arg0);
        add_incentive_amount<T0>(arg0, 0x2::balance::value<T0>(&arg1));
        put_balance<T0>(arg0, arg1);
    }

    fun add_incentive_amount<T0>(arg0: &mut Gauge, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.incentive_amount, v0, *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0) + arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.incentive_amount, v0, arg1);
        };
    }

    public(friend) fun add_vote_max_bond(arg0: &mut Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: u64) {
        add_vote_unlock_at(arg0, arg1, arg2, arg3, 18446744073709551615);
    }

    fun add_vote_power_unlocks(arg0: &mut Gauge, arg1: u64, arg2: u64) {
        if (0x2::vec_map::contains<u64, u64>(&arg0.vote_power_unlocks, &arg2)) {
            0x2::vec_map::insert<u64, u64>(&mut arg0.vote_power_unlocks, arg2, *0x2::vec_map::get_mut<u64, u64>(&mut arg0.vote_power_unlocks, &arg2) + arg1);
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.vote_power_unlocks, arg2, arg1);
        };
    }

    public(friend) fun add_vote_unlock_at(arg0: &mut Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: u64, arg4: u64) {
        arg0.total_vote_power = arg0.total_vote_power + 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_epoch_id(arg1, arg2, arg3, arg0.current_epoch_id, arg4);
        add_vote_power_unlocks(arg0, arg3, arg4);
    }

    public(friend) fun advance_epoch(arg0: &mut Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_epoch_id + 1;
        let v1 = GaugeEpochState{
            id               : 0x2::object::new(arg3),
            epoch_id         : v0,
            total_vote_power : arg0.total_vote_power,
            fee_x_amount     : arg0.fee_x_amount,
            fee_y_amount     : arg0.fee_y_amount,
            incentive_amount : arg0.incentive_amount,
        };
        0x2::vec_map::insert<u64, GaugeEpochState>(&mut arg0.epoch_history, arg0.current_epoch_id, v1);
        arg0.current_epoch_id = v0;
        arg0.total_vote_power = calculate_total_vote_power_at_epoch_id(arg0, arg1, arg2, v0);
        arg0.fee_x_amount = 0;
        arg0.fee_y_amount = 0;
        arg0.incentive_amount = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
    }

    public fun all_incentive_types(arg0: &Gauge) : vector<0x1::type_name::TypeName> {
        0x2::vec_map::keys<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch_start)
    }

    public(friend) fun assert_not_paused(arg0: &Gauge) {
        assert!(0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::is_paused(&arg0.config) == false, 7);
    }

    fun calculate_total_vote_power_at_epoch_id(arg0: &Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::vec_map::size<u64, u64>(&arg0.vote_power_unlocks)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u64, u64>(&arg0.vote_power_unlocks, v0);
            let v4 = *v2;
            let v5 = if (v4 == 18446744073709551615) {
                0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_max_bond(arg1, *v3)
            } else {
                0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_epoch_id(arg1, arg2, *v3, arg3, v4)
            };
            v1 = v1 + v5;
            v0 = v0 + 1;
        };
        v1
    }

    fun check_fee_types<T0, T1>(arg0: &Gauge) {
        let (v0, v1) = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::coin_xy(&arg0.config);
        assert!(v0 == 0x1::type_name::get<T0>(), 0);
        assert!(v1 == 0x1::type_name::get<T1>(), 0);
    }

    fun check_finished_epoch_range(arg0: &Gauge, arg1: u64, arg2: u64) {
        assert!(arg1 <= arg2, 5);
        assert!(0x2::vec_map::contains<u64, GaugeEpochState>(&arg0.epoch_history, &arg1), 5);
        assert!(0x2::vec_map::contains<u64, GaugeEpochState>(&arg0.epoch_history, &arg2), 5);
    }

    fun check_incentive_available(arg0: &Gauge, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch_start, &arg1), 6);
    }

    public fun coin_xy(arg0: &Gauge) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::coin_xy(&arg0.config)
    }

    public(friend) fun create<T0, T1>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Gauge {
        Gauge{
            id                    : 0x2::object::new(arg2),
            config                : 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::create<T0, T1>(arg0, arg2),
            current_epoch_id      : arg1,
            total_vote_power      : 0,
            vote_power_unlocks    : 0x2::vec_map::empty<u64, u64>(),
            fee_x_amount          : 0,
            fee_y_amount          : 0,
            incentive_amount      : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            epoch_history         : 0x2::vec_map::empty<u64, GaugeEpochState>(),
            incentive_epoch_start : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            fee_last_claimed_ms   : 0,
            balances              : 0x2::bag::new(arg2),
        }
    }

    public fun current_epoch_id(arg0: &Gauge) : u64 {
        arg0.current_epoch_id
    }

    public fun fee_last_claimed_ms(arg0: &Gauge) : u64 {
        arg0.fee_last_claimed_ms
    }

    public fun gauge_id(arg0: &Gauge) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_balance<T0>(arg0: &Gauge) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 1);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun get_current_fee_x(arg0: &Gauge) : u64 {
        arg0.fee_x_amount
    }

    public fun get_current_fee_y(arg0: &Gauge) : u64 {
        arg0.fee_y_amount
    }

    public fun get_current_incentive_amount<T0>(arg0: &Gauge) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0)
        } else {
            0
        }
    }

    public fun get_fee_last_claimed_ms(arg0: &Gauge) : u64 {
        arg0.fee_last_claimed_ms
    }

    public fun get_incentive_epoch_start<T0>(arg0: &Gauge) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch_start, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch_start, &v0)
        } else {
            0
        }
    }

    public(friend) fun incentive_types(arg0: &Gauge) : vector<0x1::type_name::TypeName> {
        0x2::vec_map::keys<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch_start)
    }

    public fun paused(arg0: &Gauge) : bool {
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::is_paused(&arg0.config)
    }

    public(friend) fun pending_fees_max_bond(arg0: &Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        check_finished_epoch_range(arg0, arg3, arg4);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_max_bond(arg1, arg2);
        while (arg3 <= arg4) {
            let v3 = 0x2::vec_map::get<u64, GaugeEpochState>(&arg0.epoch_history, &arg3);
            v0 = v0 + 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::full_math_u64::mul_div_floor(v3.fee_x_amount, v2, v3.total_vote_power);
            v1 = v1 + 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::full_math_u64::mul_div_floor(v3.fee_y_amount, v2, v3.total_vote_power);
            arg3 = arg3 + 1;
        };
        (v0, v1)
    }

    public(friend) fun pending_fees_normal(arg0: &Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64) {
        check_finished_epoch_range(arg0, arg5, arg6);
        let v0 = 0;
        let v1 = 0;
        while (arg5 <= arg6) {
            let v2 = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_epoch_id(arg1, arg2, arg3, arg5, arg4);
            if (v2 == 0) {
                break
            };
            let v3 = 0x2::vec_map::get<u64, GaugeEpochState>(&arg0.epoch_history, &arg5);
            v0 = v0 + 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::full_math_u64::mul_div_floor(v3.fee_x_amount, v2, v3.total_vote_power);
            v1 = v1 + 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::full_math_u64::mul_div_floor(v3.fee_y_amount, v2, v3.total_vote_power);
            arg5 = arg5 + 1;
        };
        (v0, v1)
    }

    public(friend) fun pending_incentive_max_bond<T0>(arg0: &Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        check_finished_epoch_range(arg0, arg3, arg4);
        check_incentive_available(arg0, v0);
        let v1 = 0;
        while (arg3 <= arg4) {
            let v2 = 0x2::vec_map::get<u64, GaugeEpochState>(&arg0.epoch_history, &arg3);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0)) {
                continue
            };
            v1 = v1 + 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::full_math_u64::mul_div_floor(*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0), 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_max_bond(arg1, arg2), v2.total_vote_power);
            arg3 = arg3 + 1;
        };
        v1
    }

    public(friend) fun pending_incentive_unlock_at<T0>(arg0: &Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        check_finished_epoch_range(arg0, arg5, arg6);
        check_incentive_available(arg0, v0);
        let v1 = 0;
        while (arg5 <= arg6) {
            let v2 = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_epoch_id(arg1, arg2, arg3, arg5, arg4);
            if (v2 == 0) {
                break
            };
            let v3 = 0x2::vec_map::get<u64, GaugeEpochState>(&arg0.epoch_history, &arg5);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0)) {
                continue
            };
            v1 = v1 + 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::full_math_u64::mul_div_floor(*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.incentive_amount, &v0), v2, v3.total_vote_power);
            arg5 = arg5 + 1;
        };
        v1
    }

    public fun pool_id(arg0: &Gauge) : address {
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::pool_id(&arg0.config)
    }

    public(friend) fun put_balance<T0>(arg0: &mut Gauge, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public(friend) fun remove_vote_max_bound(arg0: &mut Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: u64) {
        remove_vote_unlock_at(arg0, arg1, arg2, arg3, 18446744073709551615);
    }

    fun remove_vote_power_unlocks(arg0: &mut Gauge, arg1: u64, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.vote_power_unlocks, &arg2), 2);
        let v0 = *0x2::vec_map::get<u64, u64>(&arg0.vote_power_unlocks, &arg2);
        assert!(v0 >= arg1, 4);
        0x2::vec_map::insert<u64, u64>(&mut arg0.vote_power_unlocks, arg2, v0 - arg1);
    }

    public(friend) fun remove_vote_unlock_at(arg0: &mut Gauge, arg1: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::VotePowerConfig, arg2: &0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::epoch::EpochConfig, arg3: u64, arg4: u64) {
        let v0 = 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::vote_power::vote_power_for_epoch_id(arg1, arg2, arg3, arg0.current_epoch_id, arg4);
        assert!(arg0.total_vote_power >= v0, 3);
        arg0.total_vote_power = arg0.total_vote_power - v0;
        remove_vote_power_unlocks(arg0, arg3, arg4);
    }

    fun set_fee_last_claimed(arg0: &mut Gauge, arg1: u64) {
        arg0.fee_last_claimed_ms = arg1;
    }

    fun set_incentive_start_if_not_exist<T0>(arg0: &mut Gauge) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch_start, &v0)) {
            return
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.incentive_epoch_start, v0, arg0.current_epoch_id);
    }

    public(friend) fun set_paused(arg0: &mut Gauge, arg1: bool) {
        0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::gauge_config::set_paused(&mut arg0.config, arg1);
    }

    public(friend) fun take_balance<T0>(arg0: &mut Gauge, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 1);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
    }

    public fun total_vote_power(arg0: &Gauge) : u64 {
        arg0.total_vote_power
    }

    // decompiled from Move bytecode v6
}

