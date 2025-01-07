module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle {
    struct BottleTable has store, key {
        id: 0x2::object::UID,
        table: 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::LinkedTable<address, Bottle>,
        total_stake: u64,
        total_stake_snapshot: u64,
        total_collateral_snapshot: u64,
        debt_per_unit_stake: u128,
        reward_per_unit_stake: u128,
        last_reward_error: u128,
        last_debt_error: u128,
    }

    struct Bottle has store, key {
        id: 0x2::object::UID,
        collateral_amount: u64,
        buck_amount: u64,
        stake_amount: u64,
        reward_coll_snapshot: u128,
        reward_debt_snapshot: u128,
    }

    public(friend) fun new(arg0: &BottleTable, arg1: &mut 0x2::tx_context::TxContext) : Bottle {
        Bottle{
            id                   : 0x2::object::new(arg1),
            collateral_amount    : 0,
            buck_amount          : 0,
            stake_amount         : 0,
            reward_coll_snapshot : arg0.reward_per_unit_stake,
            reward_debt_snapshot : arg0.debt_per_unit_stake,
        }
    }

    public(friend) fun pop_front(arg0: &mut BottleTable) : (address, Bottle) {
        assert!(0x1::option::is_some<address>(0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::front<address, Bottle>(&arg0.table)), 4);
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::pop_front<address, Bottle>(&mut arg0.table)
    }

    public fun borrow_bottle(arg0: &BottleTable, arg1: address) : &Bottle {
        assert!(0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::contains<address, Bottle>(&arg0.table, arg1), 4);
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::borrow<address, Bottle>(&arg0.table, arg1)
    }

    public(friend) fun borrow_bottle_mut(arg0: &mut BottleTable, arg1: address) : &mut Bottle {
        assert!(0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::contains<address, Bottle>(&arg0.table, arg1), 4);
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::borrow_mut<address, Bottle>(&mut arg0.table, arg1)
    }

    public fun borrow_table(arg0: &BottleTable) : &0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::LinkedTable<address, Bottle> {
        &arg0.table
    }

    public fun bottle_exists(arg0: &BottleTable, arg1: address) : bool {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::contains<address, Bottle>(&arg0.table, arg1)
    }

    fun compute_buck_value_to_collateral(arg0: u64, arg1: u8, arg2: u64, arg3: u64) : u64 {
        if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal() >= arg1) {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, arg3, arg2) / 0x2::math::pow(10, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal() - arg1)
        } else {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, arg3, arg2) * 0x2::math::pow(10, arg1 - 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal())
        }
    }

    fun compute_new_stake(arg0: &mut BottleTable, arg1: u64) : u64 {
        if (arg0.total_collateral_snapshot == 0) {
            arg1
        } else {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, arg0.total_stake_snapshot, arg0.total_collateral_snapshot)
        }
    }

    public fun cr_greater(arg0: &BottleTable, arg1: &Bottle, arg2: &Bottle) : bool {
        let (v0, v1) = get_bottle_info(arg0, arg1);
        let (v2, v3) = get_bottle_info(arg0, arg2);
        (v0 as u128) * (v3 as u128) > (v2 as u128) * (v1 as u128)
    }

    public fun cr_less_or_equal(arg0: &BottleTable, arg1: &Bottle, arg2: &Bottle) : bool {
        let (v0, v1) = get_bottle_info(arg0, arg1);
        let (v2, v3) = get_bottle_info(arg0, arg2);
        (v0 as u128) * (v3 as u128) <= (v2 as u128) * (v1 as u128)
    }

    public fun destroy_bottle(arg0: &mut BottleTable, arg1: address) {
        let v0 = remove_bottle(arg0, arg1);
        let Bottle {
            id                   : v1,
            collateral_amount    : v2,
            buck_amount          : v3,
            stake_amount         : v4,
            reward_coll_snapshot : _,
            reward_debt_snapshot : _,
        } = v0;
        assert!(v2 == 0 && v3 == 0, 2);
        0x2::object::delete(v1);
        arg0.total_stake = arg0.total_stake - v4;
    }

    public(friend) fun destroy_surplus_bottle(arg0: Bottle) : u64 {
        let Bottle {
            id                   : v0,
            collateral_amount    : v1,
            buck_amount          : _,
            stake_amount         : _,
            reward_coll_snapshot : _,
            reward_debt_snapshot : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun find_downward_and_insert(arg0: &mut BottleTable, arg1: address, arg2: Bottle, arg3: 0x1::option::Option<address>) {
        while (0x1::option::is_some<address>(&arg3)) {
            let v0 = *0x1::option::borrow<address>(&arg3);
            if (cr_greater(arg0, &arg2, 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::borrow<address, Bottle>(&arg0.table, v0))) {
                0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::insert_back<address, Bottle>(&mut arg0.table, arg3, arg1, arg2);
                return
            };
            arg3 = *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::prev<address, Bottle>(&arg0.table, v0);
        };
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::insert_back<address, Bottle>(&mut arg0.table, arg3, arg1, arg2);
    }

    fun find_upward_and_insert(arg0: &mut BottleTable, arg1: address, arg2: Bottle, arg3: 0x1::option::Option<address>) {
        while (0x1::option::is_some<address>(&arg3)) {
            let v0 = *0x1::option::borrow<address>(&arg3);
            if (cr_less_or_equal(arg0, &arg2, 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::borrow<address, Bottle>(&arg0.table, v0))) {
                0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::insert_front<address, Bottle>(&mut arg0.table, arg3, arg1, arg2);
                return
            };
            arg3 = *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::next<address, Bottle>(&arg0.table, v0);
        };
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::insert_front<address, Bottle>(&mut arg0.table, arg3, arg1, arg2);
    }

    public fun get_bottle_info(arg0: &BottleTable, arg1: &Bottle) : (u64, u64) {
        (arg1.collateral_amount + get_pending_coll(arg1, arg0), arg1.buck_amount + get_pending_debt(arg1, arg0))
    }

    public(friend) fun get_bottle_info_after_update(arg0: &mut BottleTable, arg1: address) : (u64, u64) {
        let v0 = arg0.reward_per_unit_stake;
        let v1 = arg0.debt_per_unit_stake;
        let v2 = borrow_bottle(arg0, arg1);
        let v3 = get_pending_coll(v2, arg0);
        let v4 = get_pending_debt(v2, arg0);
        let v5 = borrow_bottle_mut(arg0, arg1);
        v5.collateral_amount = v5.collateral_amount + v3;
        v5.buck_amount = v5.buck_amount + v4;
        v5.reward_coll_snapshot = v0;
        v5.reward_debt_snapshot = v1;
        (v5.collateral_amount, v5.buck_amount)
    }

    public fun get_bottle_info_by_debtor(arg0: &BottleTable, arg1: address) : (u64, u64) {
        let v0 = borrow_bottle(arg0, arg1);
        (v0.collateral_amount + get_pending_coll(v0, arg0), v0.buck_amount + get_pending_debt(v0, arg0))
    }

    public fun get_bottle_raw_info(arg0: &Bottle) : (u64, u64) {
        (arg0.collateral_amount, arg0.buck_amount)
    }

    public fun get_bottle_raw_info_by_debator(arg0: &BottleTable, arg1: address) : (u64, u64) {
        let v0 = borrow_bottle(arg0, arg1);
        (v0.collateral_amount, v0.buck_amount)
    }

    public fun get_lowest_cr_debtor(arg0: &BottleTable) : 0x1::option::Option<address> {
        *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::front<address, Bottle>(&arg0.table)
    }

    public fun get_pending_coll(arg0: &Bottle, arg1: &BottleTable) : u64 {
        (0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor_u128((arg0.stake_amount as u128), ((arg1.reward_per_unit_stake - arg0.reward_coll_snapshot) as u128), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::distribution_precision()) as u64)
    }

    public fun get_pending_debt(arg0: &Bottle, arg1: &BottleTable) : u64 {
        (0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor_u128((arg0.stake_amount as u128), ((arg1.debt_per_unit_stake - arg0.reward_debt_snapshot) as u128), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::distribution_precision()) as u64)
    }

    public fun get_table_length(arg0: &BottleTable) : u64 {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::length<address, Bottle>(borrow_table(arg0))
    }

    public(friend) fun insert(arg0: &mut BottleTable, arg1: address, arg2: Bottle, arg3: 0x1::option::Option<address>) {
        if (0x1::option::is_none<address>(&arg3)) {
            let v0 = *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::front<address, Bottle>(&arg0.table);
            find_upward_and_insert(arg0, arg1, arg2, v0);
            return
        };
        let v1 = 0x1::option::destroy_some<address>(arg3);
        assert!(!0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::contains<address, Bottle>(&arg0.table, arg1), 5);
        if (cr_greater(arg0, &arg2, 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::borrow<address, Bottle>(&arg0.table, v1))) {
            let v2 = *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::next<address, Bottle>(&arg0.table, v1);
            find_upward_and_insert(arg0, arg1, arg2, v2);
        } else {
            let v3 = *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::prev<address, Bottle>(&arg0.table, v1);
            find_downward_and_insert(arg0, arg1, arg2, v3);
        };
    }

    public(friend) fun new_table(arg0: &mut 0x2::tx_context::TxContext) : BottleTable {
        BottleTable{
            id                        : 0x2::object::new(arg0),
            table                     : 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::new<address, Bottle>(arg0),
            total_stake               : 0,
            total_stake_snapshot      : 0,
            total_collateral_snapshot : 0,
            debt_per_unit_stake       : 0,
            reward_per_unit_stake     : 0,
            last_reward_error         : 0,
            last_debt_error           : 0,
        }
    }

    public fun re_insert(arg0: &mut BottleTable, arg1: address) {
        let v0 = *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::prev<address, Bottle>(&arg0.table, arg1);
        let v1 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::remove<address, Bottle>(&mut arg0.table, arg1);
        insert(arg0, arg1, v1, v0);
    }

    public(friend) fun record_borrow(arg0: &mut Bottle, arg1: u64, arg2: u64, arg3: u64) {
        arg0.collateral_amount = arg0.collateral_amount + arg1;
        arg0.buck_amount = arg0.buck_amount + arg2;
        assert!(arg0.buck_amount >= arg3, 3);
    }

    public(friend) fun record_redeem(arg0: &mut Bottle, arg1: u64, arg2: u64) {
        assert!(arg0.collateral_amount >= arg1, 1);
        arg0.collateral_amount = arg0.collateral_amount - arg1;
        arg0.buck_amount = arg0.buck_amount - arg2;
    }

    public(friend) fun record_redistribution(arg0: &mut BottleTable, arg1: u64, arg2: u64, arg3: address) {
        let v0 = (arg0.total_stake as u128);
        let v1 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor_u128((arg1 as u128), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::distribution_precision(), 1) + arg0.last_reward_error;
        let v2 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor_u128((arg2 as u128), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::distribution_precision(), 1) + arg0.last_debt_error;
        let v3 = v1 / v0;
        let v4 = v2 / v0;
        arg0.last_reward_error = v1 - v3 * v0;
        arg0.last_debt_error = v2 - v4 * v0;
        arg0.reward_per_unit_stake = arg0.reward_per_unit_stake + v3;
        arg0.debt_per_unit_stake = arg0.debt_per_unit_stake + v4;
        let v5 = borrow_bottle_mut(arg0, arg3);
        v5.buck_amount = 0;
        v5.collateral_amount = 0;
        v5.reward_coll_snapshot = 0;
        v5.reward_debt_snapshot = 0;
    }

    public(friend) fun record_repay(arg0: &mut Bottle, arg1: u64, arg2: u64, arg3: bool) : (bool, u64) {
        if (arg1 >= arg0.buck_amount) {
            arg0.collateral_amount = 0;
            arg0.buck_amount = 0;
            (true, arg0.collateral_amount)
        } else {
            let v2 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.collateral_amount, arg1, arg0.buck_amount);
            arg0.collateral_amount = arg0.collateral_amount - v2;
            arg0.buck_amount = arg0.buck_amount - arg1;
            if (arg3) {
                assert!(arg0.buck_amount >= arg2, 3);
            };
            (false, v2)
        }
    }

    public(friend) fun record_repay_capped<T0>(arg0: &mut Bottle, arg1: u64, arg2: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u8) : (bool, u64) {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg2, arg3);
        let v2 = compute_buck_value_to_collateral(arg1 * arg4 / 100, arg5, v0, v1);
        let v3 = v2;
        let v4 = if (arg1 >= arg0.buck_amount) {
            if (arg0.collateral_amount < v2) {
                v3 = arg0.collateral_amount;
            };
            arg0.collateral_amount = arg0.collateral_amount - v3;
            arg0.buck_amount = 0;
            true
        } else {
            let v5 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.collateral_amount, arg1, arg0.buck_amount);
            if (v5 < v2) {
                v3 = v5;
            };
            arg0.collateral_amount = arg0.collateral_amount - v3;
            arg0.buck_amount = arg0.buck_amount - arg1;
            false
        };
        (v4, v3)
    }

    public(friend) fun record_top_up(arg0: &mut Bottle, arg1: u64) {
        arg0.collateral_amount = arg0.collateral_amount + arg1;
    }

    public(friend) fun record_withdraw(arg0: &mut Bottle, arg1: u64) {
        arg0.collateral_amount = arg0.collateral_amount - arg1;
    }

    public(friend) fun remove_bottle(arg0: &mut BottleTable, arg1: address) : Bottle {
        assert!(0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::contains<address, Bottle>(&arg0.table, arg1), 4);
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::remove<address, Bottle>(&mut arg0.table, arg1)
    }

    public(friend) fun remove_bottle_stake(arg0: &mut BottleTable, arg1: address) {
        let v0 = borrow_bottle_mut(arg0, arg1);
        v0.stake_amount = 0;
        arg0.total_stake = arg0.total_stake - v0.stake_amount;
    }

    public(friend) fun update_snapshot(arg0: &mut BottleTable, arg1: u64) {
        arg0.total_stake_snapshot = arg0.total_stake;
        arg0.total_collateral_snapshot = arg1;
    }

    public(friend) fun update_stake_and_total_stake(arg0: &mut BottleTable, arg1: &mut Bottle) {
        let (v0, _) = get_bottle_raw_info(arg1);
        let v2 = compute_new_stake(arg0, v0);
        arg0.total_stake = arg0.total_stake + v2 - arg1.stake_amount;
        arg1.stake_amount = v2;
    }

    public(friend) fun update_stake_and_total_stake_by_debtor(arg0: &mut BottleTable, arg1: address) {
        let (v0, _) = get_bottle_raw_info_by_debator(arg0, arg1);
        let v2 = compute_new_stake(arg0, v0);
        let v3 = borrow_bottle_mut(arg0, arg1);
        v3.stake_amount = v2;
        arg0.total_stake = arg0.total_stake + v2 - v3.stake_amount;
    }

    // decompiled from Move bytecode v6
}

