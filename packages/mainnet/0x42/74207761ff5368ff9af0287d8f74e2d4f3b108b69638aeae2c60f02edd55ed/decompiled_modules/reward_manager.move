module 0x81c2ae708afabfcf04ee68d8002ec33cf7a56bbc7dfeda57951f7ead43865508::reward_manager {
    struct RewarderManager has store {
        types: vector<0x1::type_name::TypeName>,
        balances: 0x2::bag::Bag,
        available_balance: 0x2::table::Table<0x1::type_name::TypeName, u128>,
        emissions_per_second: 0x2::table::Table<0x1::type_name::TypeName, u128>,
        growth_global: 0x2::table::Table<0x1::type_name::TypeName, u128>,
        last_update_growth_time: u64,
    }

    struct DepositEvent has copy, drop, store {
        port_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        after_amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        port_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        after_amount: u64,
        available_balance: u128,
    }

    struct EmergentWithdrawEvent has copy, drop, store {
        port_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    struct RewardBalanceDepletedEvent has copy, drop, store {
        port_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        emission_rate: u128,
    }

    struct UpdateEmissionEvent has copy, drop {
        port_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        new_emission_rate: u128,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : RewarderManager {
        RewarderManager{
            types                   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            balances                : 0x2::bag::new(arg0),
            available_balance       : 0x2::table::new<0x1::type_name::TypeName, u128>(arg0),
            emissions_per_second    : 0x2::table::new<0x1::type_name::TypeName, u128>(arg0),
            growth_global           : 0x2::table::new<0x1::type_name::TypeName, u128>(arg0),
            last_update_growth_time : 0,
        }
    }

    public fun available_balance_of<T0>(arg0: &RewarderManager) : u128 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.available_balance, v0)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.available_balance, v0)
    }

    public fun balance_of<T0>(arg0: &RewarderManager) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public(friend) fun deposit_reward<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.types, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.types, v0);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.emissions_per_second, v0, 0);
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.growth_global, v0, 0);
        };
        let v1 = 0x2::balance::value<T0>(&arg2);
        if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.available_balance, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v0, (v1 as u128) << 64);
        } else {
            let (v2, v3) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add(0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v0), (v1 as u128) << 64);
            if (v3) {
                abort 0x81c2ae708afabfcf04ee68d8002ec33cf7a56bbc7dfeda57951f7ead43865508::error::available_balance_overflow()
            };
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v0, v2);
        };
        let v4 = 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2);
        let v5 = DepositEvent{
            port_id        : arg1,
            reward_type    : v0,
            deposit_amount : v1,
            after_amount   : v4,
        };
        0x2::event::emit<DepositEvent>(v5);
        v4
    }

    public(friend) fun emergent_withdraw<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        settle(arg0, arg1, arg3, arg4);
        assert!((arg2 as u128) << 64 <= *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.available_balance, v0), 0x81c2ae708afabfcf04ee68d8002ec33cf7a56bbc7dfeda57951f7ead43865508::error::incorrect_withdraw_amount());
        0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v0, 0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v0) - ((arg2 as u128) << 64));
        let v1 = EmergentWithdrawEvent{
            port_id         : arg1,
            reward_type     : 0x1::type_name::with_defining_ids<T0>(),
            withdraw_amount : arg2,
        };
        0x2::event::emit<EmergentWithdrawEvent>(v1);
        withdraw_reward<T0>(arg0, arg1, arg2)
    }

    public fun emissions_per_second<T0>(arg0: &RewarderManager) : u128 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.emissions_per_second, 0x1::type_name::with_defining_ids<T0>())) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.emissions_per_second, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun get_rewards_info(arg0: &RewarderManager) : (vector<0x1::type_name::TypeName>, vector<u128>, vector<u128>) {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.types)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.types, v2);
            0x1::vector::push_back<u128>(&mut v0, *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.emissions_per_second, v3));
            0x1::vector::push_back<u128>(&mut v1, *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.growth_global, v3));
            v2 = v2 + 1;
        };
        (arg0.types, v0, v1)
    }

    public fun growth_global<T0>(arg0: &RewarderManager) : u128 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.growth_global, 0x1::type_name::with_defining_ids<T0>())) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.growth_global, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun last_update_growth_time(arg0: &RewarderManager) : u64 {
        arg0.last_update_growth_time
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public(friend) fun settle(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = arg0.last_update_growth_time;
        assert!(v0 <= arg3, 0x81c2ae708afabfcf04ee68d8002ec33cf7a56bbc7dfeda57951f7ead43865508::error::invalid_time());
        arg0.last_update_growth_time = arg3;
        if (arg2 == 0 || v0 == arg3) {
            return
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.types)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.types, v1);
            let v3 = if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.available_balance, v2)) {
                true
            } else if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.emissions_per_second, v2)) {
                true
            } else {
                *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.emissions_per_second, v2) == 0
            };
            if (v3) {
                v1 = v1 + 1;
                continue
            };
            let v4 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(((arg3 - v0) as u128), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(*0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.emissions_per_second, v2), 1, (arg2 as u128)), 1);
            let v5 = v4;
            let v6 = 0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v2);
            if (v6 <= v4 * (arg2 as u128)) {
                0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg0.emissions_per_second, v2);
                0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.emissions_per_second, v2, 0);
                v5 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v6, 1, (arg2 as u128));
                0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v2, 0);
                let v7 = RewardBalanceDepletedEvent{
                    port_id       : arg1,
                    reward_type   : v2,
                    emission_rate : 0,
                };
                0x2::event::emit<RewardBalanceDepletedEvent>(v7);
            } else {
                0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v2, v6 - v4 * (arg2 as u128));
            };
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.growth_global, v2, 0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg0.growth_global, v2) + v5);
            v1 = v1 + 1;
        };
    }

    public(friend) fun update_emission<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.types, &v0), 0x81c2ae708afabfcf04ee68d8002ec33cf7a56bbc7dfeda57951f7ead43865508::error::incentive_reward_not_found());
        settle(arg0, arg1, arg2, arg4);
        if (arg3 > 0) {
            assert!(0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.available_balance, v0) && *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.available_balance, v0) >= 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr((86400 as u128) << 64, arg3, 64), 0x81c2ae708afabfcf04ee68d8002ec33cf7a56bbc7dfeda57951f7ead43865508::error::insufficient_incentive_balance());
        };
        0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg0.emissions_per_second, v0);
        0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.emissions_per_second, v0, arg3);
        let v1 = UpdateEmissionEvent{
            port_id           : arg1,
            reward_type       : v0,
            new_emission_rate : arg3,
        };
        0x2::event::emit<UpdateEmissionEvent>(v1);
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = WithdrawEvent{
            port_id           : arg1,
            reward_type       : 0x1::type_name::with_defining_ids<T0>(),
            withdraw_amount   : arg2,
            after_amount      : balance_of<T0>(arg0),
            available_balance : available_balance_of<T0>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::with_defining_ids<T0>()), arg2)
    }

    // decompiled from Move bytecode v6
}

