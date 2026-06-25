module 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset {
    struct User has drop, store {
        inviter: 0x1::option::Option<address>,
        invitees: vector<address>,
        level: u8,
        appoint_level: u8,
        repurchase_points: u64,
        dividend_asset: u64,
        release_asset: u64,
        reward_asset: u64,
        join_amount: u64,
        performance: u64,
        today_earning: u64,
        total_earning: u64,
        pre_balance: u64,
        pst_balance: u64,
        state: u8,
        invest_amount: u64,
        team_invest_amount: u64,
        static_power: u64,
        underway_power: u64,
        dynamic_power: u64,
        area_performance: u64,
        area_invest_amount: u64,
        last_distribution_time: u64,
        last_pre_caimed_time: u64,
        last_pst_caimed_time: u64,
        total_caimed_amount: u64,
        studio_level: bool,
        pre_amount: u64,
        orders: vector<Order>,
        stake_orders: vector<StakeOrder>,
    }

    struct Order has drop, store {
        id: u64,
        start_time: u64,
        amount: u64,
        pay_type: u8,
        sui_amount: u64,
        pst_amount: u64,
        pre_amount: u64,
        static_power: u64,
        total_static_power: u64,
        status: u8,
    }

    struct StakeOrder has copy, drop, store {
        id: u64,
        start_time: u64,
        status: u8,
        cycle: u64,
        pre_amount: u64,
        amount: u64,
        interest: u64,
        unclaimed_interest: u64,
    }

    struct PreReward has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct Contract<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        pre_balance: 0x2::balance::Balance<T0>,
        pst_balance: 0x2::balance::Balance<T1>,
        burst_ratio: u8,
        global_network_data: 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData,
        admin: address,
        rebot: address,
        burn_address: address,
        withdraw_fee_recipient: address,
        version: u64,
    }

    struct Router has key {
        id: 0x2::object::UID,
        cap: 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::implements::SwapCap,
    }

    public fun adminDeposit_pre<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        0x2::balance::join<T0>(&mut arg0.pre_balance, 0x2::coin::into_balance<T0>(arg1));
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pre_deposit_amount(&mut arg0.global_network_data, 0x2::coin::value<T0>(&arg1));
    }

    public fun adminDeposit_pst<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        0x2::balance::join<T1>(&mut arg0.pst_balance, 0x2::coin::into_balance<T1>(arg1));
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pst_deposit_amount(&mut arg0.global_network_data, 0x2::coin::value<T1>(&arg1));
    }

    fun apply_reward(arg0: &mut User, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData, arg2: u64, arg3: bool) {
        let v0 = arg0.static_power - arg0.total_earning;
        let v1 = if (arg2 < v0) {
            arg2
        } else {
            v0
        };
        if (arg3) {
            arg0.dividend_asset = arg0.dividend_asset + v1;
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_dividend_asset(arg1, v1);
        } else {
            arg0.release_asset = arg0.release_asset + v1;
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_release_asset(arg1, v1);
        };
        arg0.total_earning = arg0.total_earning + v1;
        arg0.today_earning = arg0.today_earning + v1;
        if (arg3) {
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_static_power_distributed(arg1, v1);
        } else {
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_dynamic_power_distributed_amount(arg1, v1);
        };
    }

    public fun appointUserLevel<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::updateLevel(&mut arg0.global_network_data, get_user_level(v0), arg2);
        v0.appoint_level = arg2;
    }

    public(friend) fun batch_import_user_base_data<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: vector<address>, arg2: vector<address>, arg3: vector<vector<address>>, arg4: vector<u8>) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<address>(&arg2), 403);
        assert!(v0 == 0x1::vector::length<vector<address>>(&arg3), 404);
        assert!(v0 == 0x1::vector::length<u8>(&arg4), 405);
        let v1 = &mut arg0.users;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            let v4 = *0x1::vector::borrow<address>(&arg2, v2);
            if (0x2::table::contains<address, User>(v1, v3)) {
                let v5 = 0x2::table::borrow_mut<address, User>(v1, v3);
                let v6 = if (v4 == @0x0) {
                    0x1::option::none<address>()
                } else {
                    0x1::option::some<address>(v4)
                };
                v5.inviter = v6;
                v5.invitees = *0x1::vector::borrow<vector<address>>(&arg3, v2);
                v5.appoint_level = *0x1::vector::borrow<u8>(&arg4, v2);
            } else {
                let v7 = if (v4 == @0x0) {
                    0x1::option::none<address>()
                } else {
                    0x1::option::some<address>(v4)
                };
                let v8 = User{
                    inviter                : v7,
                    invitees               : *0x1::vector::borrow<vector<address>>(&arg3, v2),
                    level                  : 0,
                    appoint_level          : *0x1::vector::borrow<u8>(&arg4, v2),
                    repurchase_points      : 0,
                    dividend_asset         : 0,
                    release_asset          : 0,
                    reward_asset           : 0,
                    join_amount            : 0,
                    performance            : 0,
                    today_earning          : 0,
                    total_earning          : 0,
                    pre_balance            : 0,
                    pst_balance            : 0,
                    state                  : 0,
                    invest_amount          : 0,
                    team_invest_amount     : 0,
                    static_power           : 0,
                    underway_power         : 0,
                    dynamic_power          : 0,
                    area_performance       : 0,
                    area_invest_amount     : 0,
                    last_distribution_time : 0,
                    last_pre_caimed_time   : 0,
                    last_pst_caimed_time   : 0,
                    total_caimed_amount    : 0,
                    studio_level           : false,
                    pre_amount             : 0,
                    orders                 : 0x1::vector::empty<Order>(),
                    stake_orders           : 0x1::vector::empty<StakeOrder>(),
                };
                0x2::table::add<address, User>(v1, v3, v8);
                0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_user(&mut arg0.global_network_data, 1);
            };
            v2 = v2 + 1;
        };
    }

    public fun batch_update_area_stats_v2<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        assert!(arg0.rebot == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 401);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 402);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, *0x1::vector::borrow<address>(&arg1, v1));
            v3.area_performance = v2;
            v3.area_invest_amount = *0x1::vector::borrow<u64>(&arg3, v1);
            let v4 = get_level_by_performance(v2);
            let v5 = get_user_level(v3);
            if (v4 > v5) {
                0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::updateLevel(&mut arg0.global_network_data, v5, v4);
                v3.level = v4;
            };
            v1 = v1 + 1;
        };
    }

    public fun bind_inviter<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v0, arg1), 0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, User>(v0, v1), 0);
        assert!(arg1 != v1, 400);
        let v2 = User{
            inviter                : 0x1::option::some<address>(arg1),
            invitees               : vector[],
            level                  : 0,
            appoint_level          : 0,
            repurchase_points      : 0,
            dividend_asset         : 0,
            release_asset          : 0,
            reward_asset           : 0,
            join_amount            : 0,
            performance            : 0,
            today_earning          : 0,
            total_earning          : 0,
            pre_balance            : 0,
            pst_balance            : 0,
            state                  : 0,
            invest_amount          : 0,
            team_invest_amount     : 0,
            static_power           : 0,
            underway_power         : 0,
            dynamic_power          : 0,
            area_performance       : 0,
            area_invest_amount     : 0,
            last_distribution_time : 0,
            last_pre_caimed_time   : 0,
            last_pst_caimed_time   : 0,
            total_caimed_amount    : 0,
            studio_level           : false,
            pre_amount             : 0,
            orders                 : 0x1::vector::empty<Order>(),
            stake_orders           : 0x1::vector::empty<StakeOrder>(),
        };
        0x2::table::add<address, User>(v0, v1, v2);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<address, User>(v0, arg1).invitees, v1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_user(&mut arg0.global_network_data, 1);
    }

    fun calc_claim_fee_rate(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 <= arg0) {
            return 10
        };
        let v0 = (arg1 - arg0) / 86400000;
        let v1 = if (v0 >= 100) {
            10
        } else {
            v0 / 20 * 2
        };
        if (v1 >= 10) {
            0
        } else {
            10 - v1
        }
    }

    fun calc_level_diff(arg0: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        let v2 = vector[];
        let v3 = vector[];
        let v4 = b"";
        let v5 = vector[];
        while (0x1::option::is_some<address>(&v0) && v1 <= 100) {
            let v6 = 0x1::option::extract<address>(&mut v0);
            let v7 = 0x2::table::borrow_mut<address, User>(arg1, v6);
            let v8 = get_user_level(v7);
            if (v8 == 0) {
                v0 = v7.inviter;
                v1 = v1 + 1;
                continue
            };
            if (v8 > 0) {
                let v9 = arg3 * (get_reward_percentage(v8) - 0) / 100;
                if (v7.invest_amount > 0) {
                    let v10 = v7.static_power - v7.total_earning;
                    let v11 = if (v10 > v9) {
                        v9
                    } else {
                        v10
                    };
                    v7.reward_asset = v7.reward_asset + v11;
                    v7.total_earning = v7.total_earning + v11;
                    v7.today_earning = v7.today_earning + v11;
                    0x1::vector::push_back<address>(&mut v2, v6);
                    0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::addTeamReward(arg0, v11);
                    0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_reward_asset(arg0, v11);
                    let v12 = v11 * 2 / 100;
                    if (v12 > 0) {
                        0x1::vector::push_back<address>(&mut v3, v6);
                        0x1::vector::push_back<u8>(&mut v4, v8);
                        0x1::vector::push_back<u64>(&mut v5, v12);
                    };
                };
            };
            v0 = v7.inviter;
            v1 = v1 + 1;
        };
        let v13 = 0;
        while (v13 < 0x1::vector::length<address>(&v3)) {
            let v14 = 0x2::table::borrow<address, User>(arg1, *0x1::vector::borrow<address>(&v3, v13)).inviter;
            let v15 = &mut v2;
            distribute_same_level_team_reward(arg0, arg1, v14, *0x1::vector::borrow<u8>(&v4, v13), *0x1::vector::borrow<u64>(&v5, v13), v15);
            v13 = v13 + 1;
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<address>(&v2)) {
            handler_out(arg0, *0x1::vector::borrow<address>(&v2, v16), arg1);
            v16 = v16 + 1;
        };
    }

    fun calc_static_power(arg0: u64) : u64 {
        if (arg0 >= 10000000000) {
            arg0 * 25 / 10
        } else if (arg0 >= 6000000000) {
            arg0 * 22 / 10
        } else if (arg0 >= 3000000000) {
            arg0 * 20 / 10
        } else if (arg0 >= 1000000000) {
            arg0 * 19 / 10
        } else if (arg0 >= 100000000) {
            arg0 * 18 / 10
        } else {
            arg0 * 18 / 10
        }
    }

    fun calc_static_release_ratio(arg0: &User, arg1: u64) : u64 {
        let v0 = if (arg0.invest_amount > 10000000000) {
            80
        } else if (arg0.invest_amount >= 6000000000) {
            75
        } else if (arg0.invest_amount >= 3000000000) {
            70
        } else if (arg0.invest_amount >= 1000000000) {
            65
        } else if (arg0.invest_amount >= 100000000) {
            60
        } else {
            0
        };
        let v1 = if (v0 == 0) {
            true
        } else if (arg0.last_pre_caimed_time == 0) {
            true
        } else {
            arg1 <= arg0.last_pre_caimed_time
        };
        if (v1) {
            return v0
        };
        let v2 = (arg1 - arg0.last_pre_caimed_time) / 86400000;
        let v3 = if (v2 >= 80) {
            20
        } else if (v2 >= 60) {
            15
        } else if (v2 >= 40) {
            10
        } else if (v2 >= 20) {
            5
        } else {
            0
        };
        let v4 = v0 + v3;
        if (v4 > 80) {
            80
        } else {
            v4
        }
    }

    fun check_stake_pre_amount_by_level(arg0: &User, arg1: u8) : bool {
        let v0 = &arg1;
        let v1 = if (*v0 == 1) {
            100000000
        } else if (*v0 == 2) {
            200000000
        } else if (*v0 == 3) {
            300000000
        } else if (*v0 == 4) {
            400000000
        } else if (*v0 == 5) {
            500000000
        } else if (*v0 == 6) {
            600000000
        } else if (*v0 == 7) {
            700000000
        } else if (*v0 == 8) {
            800000000
        } else if (*v0 == 9) {
            900000000
        } else {
            0
        };
        if (v1 == 0) {
            return false
        };
        get_user_active_stake_pre_amount(arg0) >= v1
    }

    public fun claimInterest<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: u64, arg2: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg4));
        assert!(v1.state == 0, 303);
        let v2 = 0x1::vector::length<StakeOrder>(&v1.stake_orders);
        assert!(v2 > 0 && arg1 <= v2, 1);
        let v3 = &mut arg0.global_network_data;
        let v4 = 0x1::vector::borrow_mut<StakeOrder>(&mut v1.stake_orders, arg1 - 1);
        assert!(v4.status == 0, 3);
        let v5 = (0x2::clock::timestamp_ms(arg3) - v4.start_time) / 86400000;
        let v6 = if (v5 > v4.cycle) {
            v4.cycle
        } else {
            v5
        };
        let v7 = v4.amount * get_daily_interest_rate(v4.cycle) * v6 / 10000 - v4.interest;
        assert!(v7 > 0, 2);
        v4.interest = v4.interest + v7;
        let v8 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pre_amount(arg2, v7);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_caimed_stake_interest(v3, v8, v7);
        withdraw_pre<T0, T1>(arg0, v0, v8, arg4);
        distribute_pre_level_reward<T0, T1>(v0, v7, arg2, arg0, arg4);
    }

    public fun claim_pre_asset<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > 0, 202);
        assert!(0x2::balance::value<T0>(&arg0.pre_balance) >= arg1, 204);
        let v2 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        assert!(v2.pre_balance >= arg1, 203);
        assert!(v2.state == 0, 303);
        let v3 = arg1 * calc_claim_fee_rate(v2.last_pre_caimed_time, v1) / 100;
        v2.pre_balance = v2.pre_balance - arg1;
        v2.last_pre_caimed_time = v1;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_pre_balance(&mut arg0.global_network_data, arg1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_claimed_amount(&mut arg0.global_network_data, arg1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pre_claimed_amount(&mut arg0.global_network_data, arg1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pre_claimed_handling_fee(&mut arg0.global_network_data, v3);
        withdraw_pre<T0, T1>(arg0, v0, arg1 - v3, arg3);
        transfer_project_pre<T0, T1>(arg0, v3, arg3);
    }

    public fun claim_pst_asset<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 202);
        assert!(0x2::balance::value<T1>(&arg0.pst_balance) >= arg1, 205);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        assert!(v1.pst_balance >= arg1, 203);
        assert!(v1.state == 0, 303);
        v1.pst_balance = v1.pst_balance - arg1;
        v1.last_pst_caimed_time = 0x2::clock::timestamp_ms(arg2);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_pst_balance(&mut arg0.global_network_data, arg1);
        let v2 = arg1 * 10 / 100;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_claimed_amount(&mut arg0.global_network_data, arg1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pst_claimed_amount(&mut arg0.global_network_data, arg1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pst_claimed_handling_fee(&mut arg0.global_network_data, v2);
        withdraw_pst<T0, T1>(arg0, v0, arg1 - v2, arg3);
        transfer_project_pst<T0, T1>(arg0, v2, arg3);
    }

    fun distribute_burst_reward(arg0: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64, arg4: u8) {
        if (arg4 == 0) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        let v2 = 0x1::option::none<address>();
        while (0x1::option::is_some<address>(&v0) && v1 <= 50) {
            let v3 = 0x1::option::extract<address>(&mut v0);
            let v4 = 0x2::table::borrow_mut<address, User>(arg1, v3);
            if (v4.studio_level) {
                let v5 = arg3 * (arg4 as u64) / 100;
                let v6 = if (v5 > 0) {
                    if (v4.invest_amount > 0) {
                        v4.total_earning < v4.static_power
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v6) {
                    let v7 = v4.static_power - v4.total_earning;
                    let v8 = if (v5 < v7) {
                        v5
                    } else {
                        v7
                    };
                    if (v8 > 0) {
                        v4.reward_asset = v4.reward_asset + v8;
                        v4.total_earning = v4.total_earning + v8;
                        v4.today_earning = v4.today_earning + v8;
                        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_explosion_order_reward(arg0, v8);
                        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_reward_asset(arg0, v8);
                        v2 = 0x1::option::some<address>(v3);
                        break
                    } else {
                        break
                    };
                } else {
                    break
                };
            };
            v0 = v4.inviter;
            v1 = v1 + 1;
        };
        if (0x1::option::is_some<address>(&v2)) {
            handler_out(arg0, 0x1::option::extract<address>(&mut v2), arg1);
        };
    }

    fun distribute_pre_level_reward<T0, T1>(arg0: address, arg1: u64, arg2: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg3: &mut Contract<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg3.global_network_data;
        let v1 = &mut arg3.users;
        let v2 = 0x2::table::borrow_mut<address, User>(v1, arg0).inviter;
        let v3 = 1;
        let v4 = 0x1::vector::empty<PreReward>();
        while (0x1::option::is_some<address>(&v2) && v3 <= 50) {
            let v5 = 0x1::option::extract<address>(&mut v2);
            let v6 = 0x2::table::borrow_mut<address, User>(v1, v5);
            let v7 = get_user_level(v6);
            if (v7 == 0) {
                v2 = v6.inviter;
                v3 = v3 + 1;
                continue
            };
            if (v7 > 0 && check_stake_pre_amount_by_level(v6, v7)) {
                let v8 = arg1 * (get_reward_percentage(v7) - 0) / 100;
                let v9 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pre_amount(arg2, v8);
                let v10 = PreReward{
                    user   : v5,
                    amount : v9,
                };
                0x1::vector::push_back<PreReward>(&mut v4, v10);
                0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_team_stake_team_reward(v0, v9, v8);
            };
            v2 = v6.inviter;
            v3 = v3 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<PreReward>(&v4)) {
            let v12 = 0x1::vector::borrow<PreReward>(&v4, v11);
            withdraw_pre<T0, T1>(arg3, v12.user, v12.amount, arg4);
            v11 = v11 + 1;
        };
    }

    fun distribute_same_level_team_reward(arg0: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: 0x1::option::Option<address>, arg3: u8, arg4: u64, arg5: &mut vector<address>) {
        let v0 = 1;
        while (0x1::option::is_some<address>(&arg2) && v0 <= 50) {
            let v1 = 0x1::option::extract<address>(&mut arg2);
            let v2 = 0x2::table::borrow_mut<address, User>(arg1, v1);
            let v3 = if (get_user_level(v2) >= arg3) {
                if (v2.invest_amount > 0) {
                    v2.total_earning < v2.static_power
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                let v4 = v2.static_power - v2.total_earning;
                let v5 = if (arg4 < v4) {
                    arg4
                } else {
                    v4
                };
                v2.reward_asset = v2.reward_asset + v5;
                v2.total_earning = v2.total_earning + v5;
                v2.today_earning = v2.today_earning + v5;
                0x1::vector::push_back<address>(arg5, v1);
                0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_same_level_reward(arg0, v5);
                0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_reward_asset(arg0, v5);
                break
            };
            arg2 = v2.inviter;
            v0 = v0 + 1;
        };
    }

    public fun exchange_dividend_asset<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pre_amount(arg1, arg2);
        assert!(arg2 > 0 && v0 > 0, 202);
        assert!(0x2::balance::value<T0>(&arg0.pre_balance) >= v0, 204);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        assert!(v1.dividend_asset >= arg2, 203);
        assert!(v1.state == 0, 303);
        v1.dividend_asset = v1.dividend_asset - arg2;
        v1.pre_balance = v1.pre_balance + v0;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_dividend_asset(&mut arg0.global_network_data, arg2);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pre_balance(&mut arg0.global_network_data, v0);
    }

    public fun exchange_release_asset<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        assert!(arg2 > 0, 202);
        let v0 = arg2 * 80 / 100;
        let v1 = arg2 * 10 / 100;
        let v2 = arg2 - v0 - v1;
        let v3 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pst_amount(arg1, v0);
        let v4 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pst_amount(arg1, v1);
        assert!(0x2::balance::value<T1>(&arg0.pst_balance) >= v3 + v4, 205);
        let v5 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        assert!(v5.release_asset >= arg2, 203);
        assert!(v5.state == 0, 303);
        v5.release_asset = v5.release_asset - arg2;
        v5.pst_balance = v5.pst_balance + v3;
        v5.repurchase_points = v5.repurchase_points + v2;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_release_asset(&mut arg0.global_network_data, arg2);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pst_balance(&mut arg0.global_network_data, v3);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_repurchase_points(&mut arg0.global_network_data, v2);
        transfer_project_pst<T0, T1>(arg0, v4, arg3);
    }

    public fun exchange_reward_asset<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        assert!(arg2 > 0, 202);
        let v0 = arg2 * 80 / 100;
        let v1 = arg2 * 10 / 100;
        let v2 = arg2 - v0 - v1;
        let v3 = v0 * 80 / 100;
        let v4 = v1 * 80 / 100;
        let v5 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pre_amount(arg1, v3);
        let v6 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pst_amount(arg1, v0 - v3);
        let v7 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pre_amount(arg1, v4);
        let v8 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pst_amount(arg1, v1 - v4);
        assert!(0x2::balance::value<T0>(&arg0.pre_balance) >= v5 + v7, 204);
        assert!(0x2::balance::value<T1>(&arg0.pst_balance) >= v6 + v8, 205);
        let v9 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        assert!(v9.reward_asset >= arg2, 203);
        assert!(v9.state == 0, 303);
        v9.reward_asset = v9.reward_asset - arg2;
        v9.pre_balance = v9.pre_balance + v5;
        v9.pst_balance = v9.pst_balance + v6;
        v9.repurchase_points = v9.repurchase_points + v2;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_reward_asset(&mut arg0.global_network_data, arg2);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pre_balance(&mut arg0.global_network_data, v5);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pst_balance(&mut arg0.global_network_data, v6);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_repurchase_points(&mut arg0.global_network_data, v2);
        transfer_project_pre<T0, T1>(arg0, v7, arg3);
        transfer_project_pst<T0, T1>(arg0, v8, arg3);
    }

    public fun freezeUser<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).state = arg2;
        if (arg2 == 1) {
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_freeze_user(&mut arg0.global_network_data, 1);
        } else {
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_freeze_user(&mut arg0.global_network_data, 1);
        };
    }

    fun get_daily_interest_rate(arg0: u64) : u64 {
        if (arg0 == 7) {
            10
        } else if (arg0 == 30) {
            20
        } else if (arg0 == 90) {
            30
        } else if (arg0 == 180) {
            40
        } else {
            50
        }
    }

    fun get_level_by_performance(arg0: u64) : u8 {
        if (arg0 < 10000000000) {
            0
        } else if (arg0 < 50000000000) {
            1
        } else if (arg0 < 100000000000) {
            2
        } else if (arg0 < 200000000000) {
            3
        } else if (arg0 < 500000000000) {
            4
        } else if (arg0 < 1000000000000) {
            5
        } else if (arg0 < 2000000000000) {
            6
        } else if (arg0 < 5000000000000) {
            7
        } else if (arg0 < 10000000000000) {
            8
        } else {
            9
        }
    }

    fun get_reward_percentage(arg0: u8) : u64 {
        let v0 = &arg0;
        if (*v0 == 1) {
            2
        } else if (*v0 == 2) {
            4
        } else if (*v0 == 3) {
            6
        } else if (*v0 == 4) {
            8
        } else if (*v0 == 5) {
            10
        } else if (*v0 == 6) {
            12
        } else if (*v0 == 7) {
            13
        } else if (*v0 == 8) {
            14
        } else if (*v0 == 9) {
            15
        } else {
            0
        }
    }

    fun get_share_reward_percent(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 > 30) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = if (arg1 > 12) {
            12
        } else {
            arg1
        };
        if (arg0 == 1) {
            return 30
        };
        if (arg0 >= 2 && arg0 <= 10) {
            if (arg0 == 2 && v1 > 1) {
                return 20
            };
            if (arg0 == 3 && v1 > 2) {
                return 20
            };
            if (arg0 == 4 && v1 > 3) {
                return 20
            };
            if (arg0 == 5 && v1 > 4) {
                return 20
            };
            if (arg0 == 6 && v1 > 5) {
                return 10
            };
            if (arg0 == 7 && v1 > 6) {
                return 10
            };
            if (arg0 == 8 && v1 > 7) {
                return 10
            };
            if (arg0 == 9 && v1 > 8) {
                return 10
            };
            if (arg0 == 10 && v1 > 9) {
                return 10
            };
        };
        if (arg0 >= 11 && arg0 <= 20) {
            return if (v1 >= 11) {
                3
            } else {
                0
            }
        };
        if (arg0 >= 21 && arg0 <= 30) {
            return if (v1 >= 12) {
                1
            } else {
                0
            }
        };
        0
    }

    public fun get_stake_order<T0, T1>(arg0: &Contract<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : vector<StakeOrder> {
        let v0 = &0x2::table::borrow<address, User>(&arg0.users, 0x2::tx_context::sender(arg2)).stake_orders;
        let v1 = 0x1::vector::empty<StakeOrder>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeOrder>(v0)) {
            let v3 = 0x1::vector::borrow<StakeOrder>(v0, v2);
            let v4 = (0x2::clock::timestamp_ms(arg1) - v3.start_time) / 86400000;
            let v5 = if (v4 > v3.cycle) {
                v3.cycle
            } else {
                v4
            };
            let v6 = StakeOrder{
                id                 : v3.id,
                start_time         : v3.start_time,
                status             : v3.status,
                cycle              : v3.cycle,
                pre_amount         : v3.pre_amount,
                amount             : v3.amount,
                interest           : v3.interest,
                unclaimed_interest : v3.amount * get_daily_interest_rate(v3.cycle) * v5 / 10000 - v3.interest,
            };
            0x1::vector::push_back<StakeOrder>(&mut v1, v6);
            v2 = v2 + 1;
        };
        v1
    }

    fun get_user_active_stake_pre_amount(arg0: &User) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<StakeOrder>(&arg0.stake_orders)) {
            let v2 = 0x1::vector::borrow<StakeOrder>(&arg0.stake_orders, v0);
            if (v2.status == 0) {
                v1 = v1 + v2.pre_amount;
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun get_user_level(arg0: &User) : u8 {
        if (arg0.level > arg0.appoint_level) {
            arg0.level
        } else {
            arg0.appoint_level
        }
    }

    fun handler_out(arg0: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData, arg1: address, arg2: &mut 0x2::table::Table<address, User>) {
        let v0 = 0;
        let v1 = 0x2::table::borrow_mut<address, User>(arg2, arg1);
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<Order>(&v1.orders)) {
            let v4 = 0x1::vector::borrow_mut<Order>(&mut v1.orders, v2);
            let v5 = v3 + v4.static_power;
            v3 = v5;
            if (v4.status == 0 && v1.total_earning >= v5) {
                v4.status = 1;
                v1.invest_amount = v1.invest_amount - v4.amount;
                v1.underway_power = v1.underway_power - v4.static_power;
                v0 = v0 + v4.amount;
            };
            v2 = v2 + 1;
        };
        if (v0 > 0) {
            sub_team_invest_amount(arg2, arg1, v0);
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_asset_invested(arg0, v0);
        };
    }

    public(friend) fun init_contract<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = User{
            inviter                : 0x1::option::none<address>(),
            invitees               : vector[],
            level                  : 0,
            appoint_level          : 0,
            repurchase_points      : 0,
            dividend_asset         : 0,
            release_asset          : 0,
            reward_asset           : 0,
            join_amount            : 0,
            performance            : 0,
            today_earning          : 0,
            total_earning          : 0,
            pre_balance            : 0,
            pst_balance            : 0,
            state                  : 0,
            invest_amount          : 0,
            team_invest_amount     : 0,
            static_power           : 0,
            underway_power         : 0,
            dynamic_power          : 0,
            area_performance       : 0,
            area_invest_amount     : 0,
            last_distribution_time : 0,
            last_pre_caimed_time   : 0,
            last_pst_caimed_time   : 0,
            total_caimed_amount    : 0,
            studio_level           : false,
            pre_amount             : 0,
            orders                 : 0x1::vector::empty<Order>(),
            stake_orders           : 0x1::vector::empty<StakeOrder>(),
        };
        let v1 = 0x2::table::new<address, User>(arg1);
        0x2::table::add<address, User>(&mut v1, @0x7d6cb078ddcd34f99af3f12d47642611f0a4aa5d918decdf0519f830307648b8, v0);
        let v2 = Contract<T0, T1>{
            id                     : 0x2::object::new(arg1),
            users                  : v1,
            pre_balance            : 0x2::balance::zero<T0>(),
            pst_balance            : 0x2::balance::zero<T1>(),
            burst_ratio            : 1,
            global_network_data    : 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::new(),
            admin                  : @0x24bf000d6a960e9ae200582b27190bdd808663b61d433f819d386d6603a5185b,
            rebot                  : @0xe0d6f7629f6bbbfd73c36b706b2b78d3e7f5d734207e7e05684b352f0a3017eb,
            burn_address           : @0x0,
            withdraw_fee_recipient : @0xa7685c75f68472ac7d8cf6a0924c88053e2e8f5ccf6a576e8e93f5b777e4b955,
            version                : 1,
        };
        0x2::transfer::share_object<Contract<T0, T1>>(v2);
    }

    public fun init_router(arg0: 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::implements::SwapCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Router{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::share_object<Router>(v0);
    }

    public fun investment_v1<T0, T1, T2>(arg0: &mut Contract<T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::implements::Global, arg9: &Router, arg10: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.global_network_data;
        let v3 = arg0.burn_address;
        assert!(arg5 >= 100000000, 302);
        let v4 = if (arg6 == 1) {
            true
        } else if (arg6 == 2) {
            true
        } else {
            arg6 == 3
        };
        assert!(v4, 304);
        assert!(0x2::table::contains<address, User>(v1, v0), 1);
        assert!(0x2::table::borrow_mut<address, User>(v1, v0).state == 0, 303);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = &arg9.cap;
        if (arg6 == 1) {
            let v9 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_sui_amount(arg4, arg5);
            let v10 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_sui_amount(arg4, arg5 * 70 / 100);
            v5 = v9;
            assert!(0x2::coin::value<T0>(&arg1) >= v9, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::interface::swap_coin<T0, T1>(arg8, 0x2::coin::split<T0>(&mut arg1, v10, arg10), 0, v8, arg10), v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::interface::swap_coin<T0, T2>(arg8, 0x2::coin::split<T0>(&mut arg1, v9 - v10, arg10), 0, v8, arg10), v3);
            0x2::coin::send_funds<T0>(arg1, v0);
            0x2::coin::send_funds<T1>(arg2, v0);
            0x2::coin::send_funds<T2>(arg3, v0);
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_sui_invested(v2, v9, arg5);
        } else if (arg6 == 2) {
            let v11 = arg5 * 70 / 100;
            let v12 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pst_amount(arg4, v11);
            let v13 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pst_amount(arg4, arg5 - v11);
            let v14 = v12 + v13;
            v7 = v14;
            assert!(0x2::coin::value<T2>(&arg3) >= v14, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::interface::swap_coin<T0, T1>(arg8, 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::interface::swap_coin<T2, T0>(arg8, 0x2::coin::split<T2>(&mut arg3, v12, arg10), 0, v8, arg10), 0, v8, arg10), v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut arg3, v13, arg10), v3);
            0x2::coin::send_funds<T0>(arg1, v0);
            0x2::coin::send_funds<T1>(arg2, v0);
            0x2::coin::send_funds<T2>(arg3, v0);
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pst_invested(v2, v14, arg5);
        } else {
            let v15 = arg5 * 70 / 100;
            let v16 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pre_amount(arg4, v15);
            let v17 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_pre_amount(arg4, arg5 - v15);
            let v18 = v16 + v17;
            v6 = v18;
            assert!(0x2::coin::value<T1>(&arg2) >= v18, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v16, arg10), v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::interface::swap_coin<T0, T2>(arg8, 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::interface::swap_coin<T1, T0>(arg8, 0x2::coin::split<T1>(&mut arg2, v17, arg10), 0, v8, arg10), 0, v8, arg10), v3);
            0x2::coin::send_funds<T0>(arg1, v0);
            0x2::coin::send_funds<T1>(arg2, v0);
            0x2::coin::send_funds<T2>(arg3, v0);
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_pre_invested(v2, v18, arg5);
        };
        let v19 = calc_static_power(arg5);
        let v20 = 0x2::table::borrow_mut<address, User>(v1, v0);
        v20.static_power = v20.static_power + v19;
        v20.underway_power = v20.underway_power + v19;
        v20.join_amount = v20.join_amount + arg5;
        v20.invest_amount = v20.invest_amount + arg5;
        let v21 = v20.static_power;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_asset_invested(v2, arg5);
        if (v20.invest_amount == 0) {
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_effective_user(v2, 1);
        };
        let v22 = 0x2::table::borrow_mut<address, User>(v1, v0);
        let v23 = Order{
            id                 : (0x1::vector::length<Order>(&v22.orders) as u64) + 1,
            start_time         : 0x2::clock::timestamp_ms(arg7),
            amount             : arg5,
            pay_type           : arg6,
            sui_amount         : v5,
            pst_amount         : v7,
            pre_amount         : v6,
            static_power       : v19,
            total_static_power : v21,
            status             : 0,
        };
        0x1::vector::push_back<Order>(&mut v22.orders, v23);
        update_performance(v1, v0, arg5);
        update_dynamic_power(v2, v1, v0, arg5);
        calc_level_diff(v2, v1, v0, arg5);
        distribute_burst_reward(v2, v1, v0, arg5, arg0.burst_ratio);
    }

    public fun releaseReward<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = &mut arg0.users;
        let v1 = &mut arg0.global_network_data;
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            let v4 = *0x1::vector::borrow<address>(&arg1, v3);
            let v5 = 0x2::table::borrow_mut<address, User>(v0, v4);
            assert!(v5.last_distribution_time + 21600000 <= v2, 0);
            v5.today_earning = 0;
            v5.last_distribution_time = v2;
            if (v5.last_pre_caimed_time == 0) {
                v5.last_pre_caimed_time = v2;
            };
            release_static_power(v5, v1, v2);
            release_dynamic_power(v5, v1);
            handler_out(v1, v4, v0);
            v3 = v3 + 1;
        };
    }

    fun release_dynamic_power(arg0: &mut User, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData) {
        if (arg0.dynamic_power == 0 || arg0.total_earning >= arg0.static_power) {
            return
        };
        let v0 = arg0.dynamic_power / 500;
        arg0.dynamic_power = arg0.dynamic_power - v0;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_dynamic_power(arg1, v0);
        apply_reward(arg0, arg1, v0, false);
    }

    fun release_static_power(arg0: &mut User, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData, arg2: u64) {
        if (arg0.total_earning >= arg0.static_power) {
            return
        };
        let v0 = calc_static_release_ratio(arg0, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = arg0.invest_amount * v0 / 10000;
        apply_reward(arg0, arg1, v1, true);
    }

    public fun repurchase<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.global_network_data;
        assert!(0x2::table::contains<address, User>(v1, v0), 1);
        let v3 = 0x2::table::borrow_mut<address, User>(v1, v0);
        assert!(v3.state == 0, 303);
        let v4 = v3.repurchase_points;
        assert!(v4 >= 100000000, 302);
        v3.repurchase_points = 0;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_repurchase_points(v2, v4);
        let v5 = calc_static_power(v4);
        let v6 = 0x2::table::borrow_mut<address, User>(v1, v0);
        v6.static_power = v6.static_power + v5;
        v6.underway_power = v6.underway_power + v5;
        v6.join_amount = v6.join_amount + v4;
        v6.invest_amount = v6.invest_amount + v4;
        let v7 = v6.static_power;
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_asset_invested(v2, v4);
        let v8 = 0x2::table::borrow_mut<address, User>(v1, v0);
        let v9 = Order{
            id                 : (0x1::vector::length<Order>(&v8.orders) as u64) + 1,
            start_time         : 0x2::clock::timestamp_ms(arg1),
            amount             : v4,
            pay_type           : 4,
            sui_amount         : 0,
            pst_amount         : 0,
            pre_amount         : 0,
            static_power       : v5,
            total_static_power : v7,
            status             : 0,
        };
        0x1::vector::push_back<Order>(&mut v8.orders, v9);
        update_performance(v1, v0, v4);
    }

    public fun setDynamicPower<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        let v1 = v0.dynamic_power;
        v0.dynamic_power = arg2;
        if (arg2 > v1) {
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_dynamic_power(&mut arg0.global_network_data, arg2 - v1);
        } else if (v1 > arg2) {
            0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::sub_total_dynamic_power(&mut arg0.global_network_data, v1 - arg2);
        };
    }

    public fun setStudioLevel<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).studio_level = arg2;
    }

    public(friend) fun set_admin<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun set_rebot<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        arg0.rebot = arg1;
    }

    public(friend) fun set_withdraw_fee_recipient<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        arg0.withdraw_fee_recipient = arg1;
    }

    public fun stake<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = if (arg3 == 7) {
            true
        } else if (arg3 == 30) {
            true
        } else if (arg3 == 90) {
            true
        } else if (arg3 == 180) {
            true
        } else {
            arg3 == 360
        };
        assert!(v1, 4);
        let v2 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg5));
        assert!(v2.state == 0, 303);
        let v3 = 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::get_usdt_from_pre(arg1, v0);
        0x2::balance::join<T0>(&mut arg0.pre_balance, 0x2::coin::into_balance<T0>(arg2));
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_cumulative_stake(&mut arg0.global_network_data, v0, v3);
        let v4 = StakeOrder{
            id                 : 0x1::vector::length<StakeOrder>(&v2.stake_orders) + 1,
            start_time         : 0x2::clock::timestamp_ms(arg4),
            status             : 0,
            cycle              : arg3,
            pre_amount         : v0,
            amount             : v3,
            interest           : 0,
            unclaimed_interest : 0,
        };
        0x1::vector::push_back<StakeOrder>(&mut v2.stake_orders, v4);
    }

    fun sub_team_invest_amount(arg0: &mut 0x2::table::Table<address, User>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg0, arg1).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 100) {
            let v2 = 0x2::table::borrow_mut<address, User>(arg0, 0x1::option::extract<address>(&mut v0));
            if (v2.team_invest_amount >= arg2) {
                v2.team_invest_amount = v2.team_invest_amount - arg2;
            };
            v1 = v1 + 1;
            v0 = v2.inviter;
        };
    }

    fun transfer_project_pre<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pre_balance, arg1), arg2), arg0.withdraw_fee_recipient);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_project_pre_amount(&mut arg0.global_network_data, arg1);
    }

    fun transfer_project_pst<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pst_balance, arg1), arg2), arg0.withdraw_fee_recipient);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_project_pst_amount(&mut arg0.global_network_data, arg1);
    }

    public fun unStake<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        let v2 = 0x1::vector::length<StakeOrder>(&v1.stake_orders);
        assert!(v2 > 0 && arg1 <= v2, 1);
        let v3 = 0x1::vector::borrow_mut<StakeOrder>(&mut v1.stake_orders, arg1 - 1);
        assert!(v3.status == 0, 1);
        assert!((0x2::clock::timestamp_ms(arg2) - v3.start_time) / 86400000 >= v3.cycle, 1);
        let v4 = v3.pre_amount;
        withdraw_pre<T0, T1>(arg0, v0, v4, arg3);
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_redemption_pre(&mut arg0.global_network_data, v4);
        let v5 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        assert!(v5.state == 0, 303);
        0x1::vector::borrow_mut<StakeOrder>(&mut v5.stake_orders, arg1 - 1).status = 1;
    }

    fun update_dynamic_power(arg0: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 30) {
            let v2 = 0x1::option::extract<address>(&mut v0);
            let v3 = 0;
            let v4 = &0x2::table::borrow<address, User>(arg1, v2).invitees;
            let v5 = 0;
            while (v5 < 0x1::vector::length<address>(v4)) {
                let v6 = *0x1::vector::borrow<address>(v4, v5);
                if (0x2::table::contains<address, User>(arg1, v6)) {
                    if (0x2::table::borrow<address, User>(arg1, v6).invest_amount > 0) {
                        v3 = v3 + 1;
                    };
                };
                v5 = v5 + 1;
            };
            let v7 = get_share_reward_percent(v1, v3);
            let v8 = 0x2::table::borrow_mut<address, User>(arg1, v2);
            if (v8.invest_amount > 0 && v7 > 0) {
                let v9 = arg3 / 100 * v7;
                v8.dynamic_power = v8.dynamic_power + v9;
                0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::admin::add_total_dynamic_power_distributed(arg0, v9);
            };
            v0 = v8.inviter;
            v1 = v1 + 1;
        };
    }

    fun update_performance(arg0: &mut 0x2::table::Table<address, User>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg0, arg1).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 100) {
            let v2 = 0x2::table::borrow_mut<address, User>(arg0, 0x1::option::extract<address>(&mut v0));
            v2.performance = v2.performance + arg2;
            v2.team_invest_amount = v2.team_invest_amount + arg2;
            v1 = v1 + 1;
            v0 = v2.inviter;
        };
    }

    fun withdraw_pre<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.pre_balance) >= arg2, 204);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pre_balance, arg2), arg3), arg1);
    }

    fun withdraw_pst<T0, T1>(arg0: &mut Contract<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        assert!(0x2::balance::value<T1>(&arg0.pst_balance) >= arg2, 205);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pst_balance, arg2), arg3), arg1);
    }

    // decompiled from Move bytecode v7
}

