module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house {
    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
        rebate_table: 0x2::table::Table<address, RebateData>,
    }

    struct GameConfig has drop, store {
        max_risk: u64,
        min_bet_size: u64,
        max_bet_size: u64,
        player_rebate_rate: u64,
        referrer_rebate_rate: u64,
    }

    struct RebateData has store {
        total_rebate: u64,
        claimed_rebate: u64,
    }

    public(friend) fun join<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, arg1);
    }

    public(friend) fun split<T0, T1: drop>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(game_config_exists<T0, T1>(arg0), 1);
        assert!(arg1 <= max_risk<T0, T1>(arg0), 2);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.pool), 3);
        0x2::balance::split<T0>(&mut arg0.pool, arg1)
    }

    public(friend) fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : House<T0> {
        House<T0>{
            id           : 0x2::object::new(arg1),
            pool         : arg0,
            rebate_table : 0x2::table::new<address, RebateData>(arg1),
        }
    }

    public(friend) fun add_game_config<T0, T1: drop>(arg0: &mut House<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 0);
        let v1 = GameConfig{
            max_risk             : arg1,
            min_bet_size         : arg2,
            max_bet_size         : arg3,
            player_rebate_rate   : arg4,
            referrer_rebate_rate : arg5,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, GameConfig>(&mut arg0.id, v0, v1);
    }

    public(friend) fun add_volume<T0, T1: drop>(arg0: &mut House<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: u64) {
        let (v0, v1) = rebate_rates<T0, T1>(arg0);
        let v2 = &mut arg0.rebate_table;
        let v3 = mul_rate(arg3, v0);
        if (!0x2::table::contains<address, RebateData>(v2, arg1)) {
            let v4 = RebateData{
                total_rebate   : 0,
                claimed_rebate : 0,
            };
            0x2::table::add<address, RebateData>(v2, arg1, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, RebateData>(v2, arg1);
        v5.total_rebate = v5.total_rebate + v3;
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_earn_playing_rebate<T0, T1>(arg1, v3);
        if (0x1::option::is_none<address>(&arg2)) {
            return
        };
        let v6 = 0x1::option::destroy_some<address>(arg2);
        let v7 = mul_rate(arg3, v1);
        if (!0x2::table::contains<address, RebateData>(v2, v6)) {
            let v8 = RebateData{
                total_rebate   : 0,
                claimed_rebate : 0,
            };
            0x2::table::add<address, RebateData>(v2, v6, v8);
        };
        let v9 = 0x2::table::borrow_mut<address, RebateData>(v2, v6);
        v9.total_rebate = v9.total_rebate + v7;
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_earn_referral_rebate<T0, T1>(v6, v7);
    }

    public fun bet_size_range<T0, T1: drop>(arg0: &House<T0>) : (u64, u64) {
        let v0 = borrow_config<T0, T1>(arg0);
        (v0.min_bet_size, v0.max_bet_size)
    }

    fun borrow_config<T0, T1: drop>(arg0: &House<T0>) : &GameConfig {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 1);
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, GameConfig>(&arg0.id, v0)
    }

    public(friend) fun claim_rebate<T0>(arg0: &mut House<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.rebate_table;
        let v2 = if (0x2::table::contains<address, RebateData>(v1, v0)) {
            let v3 = 0x2::table::borrow_mut<address, RebateData>(v1, v0);
            v3.claimed_rebate = v3.total_rebate;
            v3.total_rebate - v3.claimed_rebate
        } else {
            0
        };
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::events::emit_claim_rebate<T0>(v0, v2);
        0x2::balance::split<T0>(&mut arg0.pool, v2)
    }

    public fun claimable_rebate<T0>(arg0: &House<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, RebateData>(&arg0.rebate_table, arg1)) {
            let v1 = 0x2::table::borrow<address, RebateData>(&arg0.rebate_table, arg1);
            v1.total_rebate - v1.claimed_rebate
        } else {
            0
        }
    }

    public fun game_config_exists<T0, T1: drop>(arg0: &House<T0>) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T1>())
    }

    public fun max_risk<T0, T1: drop>(arg0: &House<T0>) : u64 {
        borrow_config<T0, T1>(arg0).max_risk
    }

    public fun mul_rate(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    public fun pool_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun precision() : u64 {
        (1000000000 as u64)
    }

    public fun rebate_rates<T0, T1: drop>(arg0: &House<T0>) : (u64, u64) {
        let v0 = borrow_config<T0, T1>(arg0);
        (v0.player_rebate_rate, v0.referrer_rebate_rate)
    }

    public(friend) fun remove_game_config<T0, T1: drop>(arg0: &mut House<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 1);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, GameConfig>(&mut arg0.id, v0);
    }

    public(friend) fun split_for_voucher<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.pool, arg1)
    }

    public fun total_rebate<T0>(arg0: &House<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, RebateData>(&arg0.rebate_table, arg1)) {
            0x2::table::borrow<address, RebateData>(&arg0.rebate_table, arg1).total_rebate
        } else {
            0
        }
    }

    public(friend) fun update_game_config<T0, T1: drop>(arg0: &mut House<T0>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, GameConfig>(&mut arg0.id, v0);
        if (0x1::option::is_some<u64>(&arg1)) {
            v1.max_risk = 0x1::option::destroy_some<u64>(arg1);
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            v1.min_bet_size = 0x1::option::destroy_some<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            v1.max_bet_size = 0x1::option::destroy_some<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v1.player_rebate_rate = 0x1::option::destroy_some<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v1.referrer_rebate_rate = 0x1::option::destroy_some<u64>(arg5);
        };
    }

    public(friend) fun withdraw<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.pool, arg1)
    }

    // decompiled from Move bytecode v6
}

