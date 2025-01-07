module 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config {
    struct Config<phantom T0, phantom T1, phantom T2> has store {
        target_leverage: u64,
        withdrawal_fees: u64,
        performance_fees: u64,
        deposit_limit: u64,
        deposits_enabled: bool,
        vt_treasury_cap: 0x2::coin::TreasuryCap<T2>,
        seed_vt: 0x2::balance::Balance<T2>,
        collected_withdrawal_fees: 0x2::balance::Balance<T0>,
        collected_performance_fees: 0x2::balance::Balance<T0>,
        reward_swap_routes: 0x2::table::Table<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>,
    }

    public(friend) fun new<T0, T1, T2>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::TreasuryCap<T2>, arg5: &mut 0x2::tx_context::TxContext) : Config<T0, T1, T2> {
        Config<T0, T1, T2>{
            target_leverage            : arg0,
            withdrawal_fees            : arg1,
            performance_fees           : arg2,
            deposit_limit              : arg3,
            deposits_enabled           : true,
            vt_treasury_cap            : arg4,
            seed_vt                    : 0x2::balance::zero<T2>(),
            collected_withdrawal_fees  : 0x2::balance::zero<T0>(),
            collected_performance_fees : 0x2::balance::zero<T0>(),
            reward_swap_routes         : 0x2::table::new<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(arg5),
        }
    }

    public(friend) fun add_swap_route<T0, T1, T2, T3>(arg0: &mut Config<T0, T1, T2>, arg1: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        let v0 = 0x1::type_name::get<T3>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.reward_swap_routes, v0)) {
            let v1 = 0x2::table::remove<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.reward_swap_routes, v0);
            while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
                let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
            };
            0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        };
        0x2::table::add<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.reward_swap_routes, v0, arg1);
    }

    public fun assert_deposits_enabled<T0, T1, T2>(arg0: &Config<T0, T1, T2>, arg1: u64) {
        assert!(arg0.deposits_enabled && arg1 < arg0.deposit_limit, 1);
    }

    public(friend) fun burn_vt<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x2::coin::burn<T2>(&mut arg0.vt_treasury_cap, arg1);
    }

    public(friend) fun collect_performance_fees<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_performance_fees, arg1);
    }

    public(friend) fun collect_withdrawal_fees<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_withdrawal_fees, arg1);
    }

    public fun fee_scaling() : u64 {
        1000000
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Config<T0, T1, T2>) : vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value> {
        *0x2::table::borrow<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.reward_swap_routes, 0x1::type_name::get<T3>())
    }

    public fun leverage_scaling() : u64 {
        1000000
    }

    public(friend) fun mint_vt<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::mint<T2>(&mut arg0.vt_treasury_cap, arg1, arg2)
    }

    public fun performance_fees<T0, T1, T2>(arg0: &Config<T0, T1, T2>) : (u64, u64) {
        (arg0.performance_fees, 1000000)
    }

    public(friend) fun remove_swap_route<T0, T1, T2, T3>(arg0: &mut Config<T0, T1, T2>) {
        let v0 = 0x1::type_name::get<T3>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.reward_swap_routes, v0)) {
            let v1 = 0x2::table::remove<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.reward_swap_routes, v0);
            while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
                let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
            };
            0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        };
    }

    public(friend) fun seed_vt<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        0x2::balance::join<T2>(&mut arg0.seed_vt, arg1);
    }

    public fun seed_vt_amount<T0, T1, T2>(arg0: &Config<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.seed_vt)
    }

    public(friend) fun set_deposit_limit<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: u64) {
        arg0.deposit_limit = arg1;
    }

    public(friend) fun set_deposits_enabled<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: bool) {
        arg0.deposits_enabled = arg1;
    }

    public(friend) fun set_performance_fees<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: u64) {
        arg0.performance_fees = arg1;
    }

    public(friend) fun set_target_leverage<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: u64) {
        arg0.target_leverage = arg1;
    }

    public(friend) fun set_withdrawal_fees<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: u64) {
        arg0.withdrawal_fees = arg1;
    }

    public fun target_leverage<T0, T1, T2>(arg0: &Config<T0, T1, T2>) : (u64, u64) {
        (arg0.target_leverage, 1000000)
    }

    public fun total_vt_supply<T0, T1, T2>(arg0: &Config<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.vt_treasury_cap)
    }

    public(friend) fun withdraw_performance_fees<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_performance_fees, arg1)
    }

    public(friend) fun withdraw_withdrawal_fees<T0, T1, T2>(arg0: &mut Config<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_withdrawal_fees, arg1)
    }

    public fun withdrawal_fees<T0, T1, T2>(arg0: &Config<T0, T1, T2>) : (u64, u64) {
        (arg0.withdrawal_fees, 1000000)
    }

    // decompiled from Move bytecode v6
}

