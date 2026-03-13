module 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder {
    struct RewarderManager has store {
        rewarders: vector<Rewarder>,
        points_released: u128,
        points_growth_global: u128,
        last_updated_time: u64,
    }

    struct Rewarder has copy, drop, store {
        reward_coin: 0x1::type_name::TypeName,
        emissions_per_second: u128,
        growth_global: u128,
    }

    struct RewarderGlobalVault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        available_balance: 0x2::table::Table<0x1::type_name::TypeName, u128>,
    }

    struct RewarderInitEvent has copy, drop {
        global_vault_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        after_amount: u64,
    }

    struct EmergentWithdrawEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        after_amount: u64,
    }

    struct RewardBalanceDepletedEvent has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        emission_rate: u128,
    }

    public(friend) fun new() : RewarderManager {
        RewarderManager{
            rewarders            : 0x1::vector::empty<Rewarder>(),
            points_released      : 0,
            points_growth_global : 0,
            last_updated_time    : 0,
        }
    }

    public(friend) fun add_rewarder<T0>(arg0: &mut RewarderManager) {
        let v0 = rewarder_index<T0>(arg0);
        assert!(0x1::option::is_none<u64>(&v0), 934862304673206987);
        assert!(0x1::vector::length<Rewarder>(&arg0.rewarders) <= 5, 934062834076983206);
        let v1 = Rewarder{
            reward_coin          : 0x1::type_name::get<T0>(),
            emissions_per_second : 0,
            growth_global        : 0,
        };
        0x1::vector::push_back<Rewarder>(&mut arg0.rewarders, v1);
    }

    public fun balance_of<T0>(arg0: &RewarderGlobalVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun balances(arg0: &RewarderGlobalVault) : &0x2::bag::Bag {
        &arg0.balances
    }

    public(friend) fun borrow_mut_rewarder<T0>(arg0: &mut RewarderManager) : &mut Rewarder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == 0x1::type_name::get<T0>()) {
                return 0x1::vector::borrow_mut<Rewarder>(&mut arg0.rewarders, v0)
            };
            v0 = v0 + 1;
        };
        abort 923867923457032960
    }

    public fun borrow_rewarder<T0>(arg0: &RewarderManager) : &Rewarder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == 0x1::type_name::get<T0>()) {
                return 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0)
            };
            v0 = v0 + 1;
        };
        abort 923867923457032960
    }

    public fun deposit_reward<T0>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut RewarderGlobalVault, arg2: 0x2::balance::Balance<T0>) : u64 {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::balance::value<T0>(&arg2);
        if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg1.available_balance, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg1.available_balance, v0, (v1 as u128) << 64);
        } else {
            let (v2, v3) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add(0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg1.available_balance, v0), (v1 as u128) << 64);
            if (v3) {
                abort 92394823577283472
            };
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg1.available_balance, v0, v2);
        };
        let v4 = 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), arg2);
        let v5 = DepositEvent{
            reward_type    : v0,
            deposit_amount : v1,
            after_amount   : v4,
        };
        0x2::event::emit<DepositEvent>(v5);
        v4
    }

    public fun emergent_withdraw<T0>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::AdminCap, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut RewarderGlobalVault, arg3: u64) : 0x2::balance::Balance<T0> {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::checked_package_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!((arg3 as u128) << 64 <= *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg2.available_balance, v0), 94368340613806333);
        0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg2.available_balance, v0, 0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg2.available_balance, v0) - ((arg3 as u128) << 64));
        let v1 = EmergentWithdrawEvent{
            reward_type     : 0x1::type_name::get<T0>(),
            withdraw_amount : arg3,
            after_amount    : balance_of<T0>(arg2),
        };
        0x2::event::emit<EmergentWithdrawEvent>(v1);
        withdraw_reward<T0>(arg2, arg3)
    }

    public fun emissions_per_second(arg0: &Rewarder) : u128 {
        arg0.emissions_per_second
    }

    public fun get_available_balance<T0>(arg0: &RewarderGlobalVault) : u128 {
        *0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.available_balance, 0x1::type_name::get<T0>())
    }

    public fun growth_global(arg0: &Rewarder) : u128 {
        arg0.growth_global
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewarderGlobalVault{
            id                : 0x2::object::new(arg0),
            balances          : 0x2::bag::new(arg0),
            available_balance : 0x2::table::new<0x1::type_name::TypeName, u128>(arg0),
        };
        0x2::transfer::share_object<RewarderGlobalVault>(v0);
        let v1 = RewarderInitEvent{global_vault_id: 0x2::object::id<RewarderGlobalVault>(&v0)};
        0x2::event::emit<RewarderInitEvent>(v1);
    }

    public fun last_update_time(arg0: &RewarderManager) : u64 {
        arg0.last_updated_time
    }

    public fun points_growth_global(arg0: &RewarderManager) : u128 {
        arg0.points_growth_global
    }

    public fun points_released(arg0: &RewarderManager) : u128 {
        arg0.points_released
    }

    public fun reward_coin(arg0: &Rewarder) : 0x1::type_name::TypeName {
        arg0.reward_coin
    }

    public fun rewarder_index<T0>(arg0: &RewarderManager) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == 0x1::type_name::get<T0>()) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun rewarders(arg0: &RewarderManager) : vector<Rewarder> {
        arg0.rewarders
    }

    public fun rewards_growth_global(arg0: &RewarderManager) : vector<u128> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u128>();
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            0x1::vector::push_back<u128>(&mut v1, 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).growth_global);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun settle(arg0: &mut RewarderGlobalVault, arg1: &mut RewarderManager, arg2: u128, arg3: u64) {
        let v0 = arg1.last_updated_time;
        arg1.last_updated_time = arg3;
        assert!(v0 <= arg3, 923872347632063063);
        if (arg2 == 0 || v0 == arg3) {
            return
        };
        let v1 = arg3 - v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Rewarder>(&arg1.rewarders)) {
            let v3 = 0x1::vector::borrow_mut<Rewarder>(&mut arg1.rewarders, v2);
            if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.available_balance, v3.reward_coin) || v3.emissions_per_second == 0) {
                v2 = v2 + 1;
                continue
            };
            let v4 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((v1 as u128), v3.emissions_per_second, arg2);
            let v5 = v4;
            let v6 = 0x2::table::remove<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v3.reward_coin);
            if (v6 <= v4 * arg2) {
                v3.emissions_per_second = 0;
                v5 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v6, 1, arg2);
                0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v3.reward_coin, 0);
                let v7 = RewardBalanceDepletedEvent{
                    reward_type   : v3.reward_coin,
                    emission_rate : v3.emissions_per_second,
                };
                0x2::event::emit<RewardBalanceDepletedEvent>(v7);
            } else {
                0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.available_balance, v3.reward_coin, v6 - v4 * arg2);
            };
            0x1::vector::borrow_mut<Rewarder>(&mut arg1.rewarders, v2).growth_global = 0x1::vector::borrow<Rewarder>(&arg1.rewarders, v2).growth_global + v5;
            v2 = v2 + 1;
        };
        arg1.points_released = arg1.points_released + (v1 as u128) * 18446744073709551616000000;
        arg1.points_growth_global = arg1.points_growth_global + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((v1 as u128), 18446744073709551616000000, arg2);
    }

    public(friend) fun update_emission<T0>(arg0: &mut RewarderGlobalVault, arg1: &mut RewarderManager, arg2: u128, arg3: u128, arg4: u64) {
        settle(arg0, arg1, arg2, arg4);
        if (arg3 > 0) {
            let v0 = 0x1::type_name::get<T0>();
            assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 923867923457032960);
            assert!(*0x2::table::borrow<0x1::type_name::TypeName, u128>(&arg0.available_balance, v0) >= 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_shr((86400 as u128) << 64, arg3, 64), 928307230473046907);
        };
        borrow_mut_rewarder<T0>(arg1).emissions_per_second = arg3;
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), arg1)
    }

    // decompiled from Move bytecode v6
}

