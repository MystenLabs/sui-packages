module 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset {
    struct User has drop, store {
        inviter: 0x1::option::Option<address>,
        invitees: vector<address>,
        level: u8,
        appoint_level: u8,
        join_amount: u64,
        performance: u64,
        benefit_expiry: u64,
        today_earning: u64,
        total_earning: u64,
        balance: u64,
        state: u8,
        invest_amount: u64,
        team_invest_amount: u64,
        static_power: u64,
        underway_power: u64,
        dynamic_power: u64,
        quota: u64,
        today_share_performance: u64,
        area_performance: u64,
        area_invest_amount: u64,
        last_distribution_time: u64,
        last_buy_time: u64,
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
        rate: u8,
        sui_amount: u64,
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

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        pre_balance: 0x2::balance::Balance<T0>,
        pay_ratio: u8,
        up_time: u64,
        burst_ratio: u8,
        withdraw_charges: u8,
        withdraw_ratio: u8,
        global_network_data: 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData,
        vault: Vault,
        admin: address,
        rebot: address,
        version: u64,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    public(friend) fun add_contract_balance<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        v0.balance = v0.balance + arg2;
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user_balance(&mut arg0.global_network_data, arg2);
    }

    public(friend) fun add_contract_balance_by_rebot<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 1);
        add_contract_balance<T0>(arg0, arg1, arg2);
    }

    fun add_user_balance(arg0: address, arg1: u64, arg2: &mut 0x2::table::Table<address, User>, arg3: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg2, arg0);
        let v1 = v0.static_power - v0.total_earning;
        let v2 = if (arg1 < v1) {
            arg1
        } else {
            v1
        };
        if (v2 == 0) {
            return
        };
        v0.balance = v0.balance + v2;
        v0.today_earning = v0.today_earning + v2;
        v0.total_earning = v0.total_earning + v2;
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user_balance(arg3, v2);
        handler_out(arg3, arg0, arg2);
    }

    public fun adminDeposit_pre<T0>(arg0: &mut Contract<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        0x2::balance::join<T0>(&mut arg0.pre_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun adminWithdrawAmount<T0, T1>(arg0: &mut Contract<T1>, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg9), 1);
        assert!(arg1 > 0 && arg1 <= 5000000000000, 2);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = withdrawSui<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::coin::send_funds<T0>(v0, 0x2::tx_context::sender(arg9));
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_admin_sui_amount(&mut arg0.global_network_data, arg1);
    }

    public fun adminWithdraw_pre<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 > 0 && arg1 <= 200000000, 2);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = arg0.admin;
        withdraw_pre<T0>(arg0, v0, arg1, arg2);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_admin_pre_amount(&mut arg0.global_network_data, arg1);
    }

    fun apply_reward(arg0: &mut User, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData, arg2: u64, arg3: bool) {
        let v0 = arg0.static_power - arg0.total_earning;
        let v1 = if (arg2 < v0) {
            arg2
        } else {
            v0
        };
        arg0.balance = arg0.balance + v1;
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user_balance(arg1, v1);
        arg0.total_earning = arg0.total_earning + v1;
        arg0.today_earning = arg0.today_earning + v1;
        if (arg3) {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_static_power_distributed(arg1, v1);
        } else {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_dynamic_power_distributed_amount(arg1, v1);
        };
    }

    public fun appointUserLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::LevelDividend, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(@0x8c5eb0a151f6a8261c7478a92484d6f457b80eb500c1787bce25e813d010a796 == 0x2::tx_context::sender(arg4), 1);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        let v1 = get_user_level(v0);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::update_user_level(arg3, arg1, v1, arg2);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::updateLevel(&mut arg0.global_network_data, v1, arg2);
        v0.appoint_level = arg2;
    }

    public(friend) fun batch_import_stake_orders<T0>(arg0: &mut Contract<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 410);
        assert!(v0 == 0x1::vector::length<u8>(&arg3), 411);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 412);
        assert!(v0 == 0x1::vector::length<u64>(&arg5), 413);
        assert!(v0 == 0x1::vector::length<u64>(&arg6), 414);
        assert!(v0 == 0x1::vector::length<u64>(&arg7), 415);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.global_network_data;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg1, v3);
            let v5 = *0x1::vector::borrow<u8>(&arg3, v3);
            let v6 = *0x1::vector::borrow<u64>(&arg4, v3);
            let v7 = *0x1::vector::borrow<u64>(&arg5, v3);
            let v8 = *0x1::vector::borrow<u64>(&arg6, v3);
            assert!(0x2::table::contains<address, User>(v1, v4), 416);
            assert!(v7 > 0, 417);
            let v9 = if (v6 == 7) {
                true
            } else if (v6 == 30) {
                true
            } else if (v6 == 90) {
                true
            } else if (v6 == 180) {
                true
            } else {
                v6 == 360
            };
            assert!(v9, 418);
            assert!(v5 == 0 || v5 == 1, 419);
            let v10 = 0x2::table::borrow_mut<address, User>(v1, v4);
            let v11 = StakeOrder{
                id                 : 0x1::vector::length<StakeOrder>(&v10.stake_orders) + 1,
                start_time         : *0x1::vector::borrow<u64>(&arg2, v3),
                status             : v5,
                cycle              : v6,
                pre_amount         : v7,
                amount             : v8,
                interest           : *0x1::vector::borrow<u64>(&arg7, v3),
                unclaimed_interest : 0,
            };
            0x1::vector::push_back<StakeOrder>(&mut v10.stake_orders, v11);
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_cumulative_stake(v2, v7, v8);
            if (v5 == 1) {
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_redemption_pre(v2, v7);
            };
            v3 = v3 + 1;
        };
    }

    public(friend) fun batch_import_user_base_data<T0>(arg0: &mut Contract<T0>, arg1: vector<address>, arg2: vector<address>, arg3: vector<vector<address>>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun batch_update_area_stats_v2<T0>(arg0: &mut Contract<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::LevelDividend, arg6: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        assert!(arg0.rebot == 0x2::tx_context::sender(arg6), 1);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 401);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 402);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v2);
            v4.area_performance = v3;
            v4.area_invest_amount = *0x1::vector::borrow<u64>(&arg3, v1);
            let v5 = get_level_by_performance(v3);
            let v6 = get_user_level(v4);
            if (v5 > v6) {
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::update_user_level(arg5, v2, v6, v5);
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::updateLevel(&mut arg0.global_network_data, v6, v5);
                v4.level = v5;
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun batch_update_stake_orders_amount<T0>(arg0: &mut Contract<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 430);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 431);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 432);
        let v1 = &mut arg0.users;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg2, v2);
            assert!(0x2::table::contains<address, User>(v1, v3), 433);
            assert!(v4 > 0, 434);
            let v5 = 0x2::table::borrow_mut<address, User>(v1, v3);
            assert!(v4 <= 0x1::vector::length<StakeOrder>(&v5.stake_orders), 435);
            let v6 = 0x1::vector::borrow_mut<StakeOrder>(&mut v5.stake_orders, v4 - 1);
            v6.amount = *0x1::vector::borrow<u64>(&arg3, v2);
            v6.interest = *0x1::vector::borrow<u64>(&arg4, v2);
            v2 = v2 + 1;
        };
    }

    public(friend) fun batch_update_user_level<T0>(arg0: &mut Contract<T0>, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::LevelDividend, arg2: vector<address>, arg3: vector<u8>) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u8>(&arg3), 405);
        let v1 = &mut arg0.users;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg3, v2);
            assert!(0x2::table::contains<address, User>(v1, v3), 404);
            let v5 = 0x2::table::borrow_mut<address, User>(v1, v3);
            let v6 = get_user_level(v5);
            if (v4 != v6) {
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::update_user_level(arg1, v3, v6, v4);
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::updateLevel(&mut arg0.global_network_data, v6, v4);
                v5.appoint_level = v4;
            };
            v2 = v2 + 1;
        };
    }

    public fun bind_inviter<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v0, arg1), 0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, User>(v0, v1), 0);
        assert!(arg1 != v1, 400);
        let v2 = User{
            inviter                 : 0x1::option::some<address>(arg1),
            invitees                : vector[],
            level                   : 0,
            appoint_level           : 0,
            join_amount             : 0,
            performance             : 0,
            benefit_expiry          : 0,
            today_earning           : 0,
            total_earning           : 0,
            balance                 : 0,
            state                   : 0,
            invest_amount           : 0,
            team_invest_amount      : 0,
            static_power            : 0,
            underway_power          : 0,
            dynamic_power           : 0,
            quota                   : 0,
            today_share_performance : 0,
            area_performance        : 0,
            area_invest_amount      : 0,
            last_distribution_time  : 0,
            last_buy_time           : 0,
            total_caimed_amount     : 0,
            studio_level            : false,
            pre_amount              : 0,
            orders                  : 0x1::vector::empty<Order>(),
            stake_orders            : 0x1::vector::empty<StakeOrder>(),
        };
        0x2::table::add<address, User>(v0, v1, v2);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<address, User>(v0, arg1).invitees, v1);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user(&mut arg0.global_network_data, 1);
    }

    fun calc_level_diff(arg0: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
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
                    v7.balance = v7.balance + v11;
                    v7.total_earning = v7.total_earning + v11;
                    v7.today_earning = v7.today_earning + v11;
                    0x1::vector::push_back<address>(&mut v2, v6);
                    0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::addTeamReward(arg0, v11);
                    0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user_balance(arg0, v11);
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
        if (arg0 >= 1000000000) {
            arg0 * 4
        } else if (arg0 >= 500000000) {
            arg0 * 3
        } else if (arg0 >= 100000000) {
            arg0 * 2
        } else {
            arg0 * 2
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

    public fun claimInterest<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
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
        let v8 = 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_pre_amount(arg2, v7);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_caimed_stake_interest(v3, v8, v7);
        withdraw_pre<T0>(arg0, v0, v8, arg4);
        distribute_pre_level_reward<T0>(v0, v7, arg2, arg0, arg4);
    }

    public fun claim_balance<T0, T1>(arg0: &mut Contract<T1>, arg1: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::PriceOracle, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::implements::Global, arg11: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        assert!(arg2 > 0, 202);
        assert!(v1.balance >= arg2, 203);
        assert!(v1.state == 0, 303);
        v1.balance = v1.balance - arg2;
        v1.total_caimed_amount = v1.total_caimed_amount + arg2;
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::sub_total_user_balance(&mut arg0.global_network_data, arg2);
        let v2 = arg2 * 50 / 100;
        let v3 = 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_sui_amount(arg1, arg2 * 40 / 100);
        let v4 = 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_pre_amount(arg1, v2);
        let v5 = 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_sui_amount(arg1, arg2 * 5 / 100);
        let v6 = withdrawSui<T0>(&arg0.vault, v3 + v5, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::interface::swapCoin<T0, T1>(arg10, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v5), arg11), 0, arg11), @0x0);
        0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(v7, arg11), v0);
        withdraw_pre<T1>(arg0, v0, v4, arg11);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_claimed_amount(&mut arg0.global_network_data, arg2, v3, arg2 * 10 / 100);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_pre_burn_usdt_amount(&mut arg0.global_network_data, v2);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_pre_burn_pre_amount(&mut arg0.global_network_data, v4);
        if (0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::get_current_rank_reward(&arg0.global_network_data) < 5000000000) {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_share_rank_dividend_amount(&mut arg0.global_network_data, arg2 * 5 / 100);
        };
    }

    fun depositSui<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    fun distribute_burst_reward(arg0: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64, arg4: u8) {
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
                        v4.balance = v4.balance + v8;
                        v4.total_earning = v4.total_earning + v8;
                        v4.today_earning = v4.today_earning + v8;
                        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_explosion_order_reward(arg0, v8);
                        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user_balance(arg0, v8);
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

    public fun distribute_level_share<T0>(arg0: &mut Contract<T0>, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::LevelDividend, arg2: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        assert!(arg0.rebot == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::distribute(arg1, 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::get_current_rank_reward(&arg0.global_network_data));
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::clean_rank_reward(&mut arg0.global_network_data);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::DividendItem>(&v0)) {
            let v2 = 0x1::vector::borrow<0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::DividendItem>(&v0, v1);
            let v3 = &mut arg0.users;
            let v4 = &mut arg0.global_network_data;
            add_user_balance(0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::get_user(v2), 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::get_amount(v2), v3, v4);
            v1 = v1 + 1;
        };
    }

    fun distribute_pre_level_reward<T0>(arg0: address, arg1: u64, arg2: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::PriceOracle, arg3: &mut Contract<T0>, arg4: &mut 0x2::tx_context::TxContext) {
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
                let v9 = 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_pre_amount(arg2, v8);
                let v10 = PreReward{
                    user   : v5,
                    amount : v9,
                };
                0x1::vector::push_back<PreReward>(&mut v4, v10);
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_team_stake_team_reward(v0, v9, v8);
            };
            v2 = v6.inviter;
            v3 = v3 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<PreReward>(&v4)) {
            let v12 = 0x1::vector::borrow<PreReward>(&v4, v11);
            withdraw_pre<T0>(arg3, v12.user, v12.amount, arg4);
            v11 = v11 + 1;
        };
    }

    fun distribute_same_level_team_reward(arg0: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: 0x1::option::Option<address>, arg3: u8, arg4: u64, arg5: &mut vector<address>) {
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
                v2.balance = v2.balance + v5;
                v2.total_earning = v2.total_earning + v5;
                v2.today_earning = v2.today_earning + v5;
                0x1::vector::push_back<address>(arg5, v1);
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::addTeamReward(arg0, v5);
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user_balance(arg0, v5);
                break
            };
            arg2 = v2.inviter;
            v0 = v0 + 1;
        };
    }

    public fun freezeUser<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x8c5eb0a151f6a8261c7478a92484d6f457b80eb500c1787bce25e813d010a796 == 0x2::tx_context::sender(arg3), 1);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).state = arg2;
        if (arg2 == 1) {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_freeze_user(&mut arg0.global_network_data, 1);
        } else {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::sub_total_freeze_user(&mut arg0.global_network_data, 1);
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
            return 50
        };
        if (arg0 >= 2 && arg0 <= 10) {
            if (arg0 == 2 && v1 > 1) {
                return 30
            };
            if (arg0 == 3 && v1 > 2) {
                return 30
            };
            if (arg0 == 4 && v1 > 3) {
                return 30
            };
            if (arg0 == 5 && v1 > 4) {
                return 20
            };
            if (arg0 == 6 && v1 > 5) {
                return 20
            };
            if (arg0 == 7 && v1 > 6) {
                return 20
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
                5
            } else {
                0
            }
        };
        if (arg0 >= 21 && arg0 <= 30) {
            return if (v1 >= 12) {
                2
            } else {
                0
            }
        };
        0
    }

    public fun get_stake_order<T0>(arg0: &Contract<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : vector<StakeOrder> {
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

    fun handler_out(arg0: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData, arg1: address, arg2: &mut 0x2::table::Table<address, User>) {
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
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::sub_total_asset_invested(arg0, v0);
        };
    }

    public(friend) fun init_contract<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = User{
            inviter                 : 0x1::option::none<address>(),
            invitees                : vector[],
            level                   : 0,
            appoint_level           : 0,
            join_amount             : 0,
            performance             : 0,
            benefit_expiry          : 0,
            today_earning           : 0,
            total_earning           : 0,
            balance                 : 0,
            state                   : 0,
            invest_amount           : 0,
            team_invest_amount      : 0,
            static_power            : 0,
            underway_power          : 0,
            dynamic_power           : 0,
            quota                   : 0,
            today_share_performance : 0,
            area_performance        : 0,
            area_invest_amount      : 0,
            last_distribution_time  : 0,
            last_buy_time           : 0,
            total_caimed_amount     : 0,
            studio_level            : false,
            pre_amount              : 0,
            orders                  : 0x1::vector::empty<Order>(),
            stake_orders            : 0x1::vector::empty<StakeOrder>(),
        };
        let v1 = 0x2::table::new<address, User>(arg1);
        0x2::table::add<address, User>(&mut v1, @0x7d6cb078ddcd34f99af3f12d47642611f0a4aa5d918decdf0519f830307648b8, v0);
        let v2 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v3 = Contract<T0>{
            id                  : 0x2::object::new(arg1),
            users               : v1,
            pre_balance         : 0x2::balance::zero<T0>(),
            pay_ratio           : 100,
            up_time             : 0x2::clock::timestamp_ms(arg0),
            burst_ratio         : 1,
            withdraw_charges    : 10,
            withdraw_ratio      : 100,
            global_network_data : 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::new(),
            vault               : v2,
            admin               : @0x29133ab324f14e250c74a2a9529f1c69856f859e0f29c219cc5c3764a2f0c89b,
            rebot               : @0x29133ab324f14e250c74a2a9529f1c69856f859e0f29c219cc5c3764a2f0c89b,
            version             : 1,
        };
        0x2::transfer::share_object<Contract<T0>>(v3);
    }

    public fun investment<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::PriceOracle, arg4: u64, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::Lottery<T1>, arg12: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = &mut arg0.users;
        let v2 = &arg0.vault;
        let v3 = &mut arg0.global_network_data;
        assert!(arg4 >= 100000000, 302);
        assert!(arg5 <= 100, 304);
        assert!(0x2::table::contains<address, User>(v1, v0), 1);
        assert!(0x2::table::borrow_mut<address, User>(v1, v0).state == 0, 303);
        let v4 = 0;
        if (arg5 > 0) {
            let v5 = arg4 * (arg5 as u64) / 100;
            let v6 = 0x2::coin::value<T0>(&arg1);
            v4 = v6;
            assert!(v6 >= 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_sui_amount(arg3, v5), 2);
            depositSui<T0>(v2, arg1, arg6, arg7, arg8, arg9, arg10);
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_sui_invested(v3, v6, v5);
        } else {
            0x2::coin::send_funds<T0>(arg1, v0);
        };
        let v7 = 100 - arg5;
        let v8 = 0;
        if (v7 > 0) {
            let v9 = arg4 * (v7 as u64) / 100;
            let v10 = 0x2::coin::value<T1>(&arg2);
            v8 = v10;
            assert!(v10 >= 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_pre_amount(arg3, v9), 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, @0x0);
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_pre_invested(v3, v10, v9);
        } else {
            0x2::coin::send_funds<T1>(arg2, v0);
        };
        let v11 = calc_static_power(arg4);
        let v12 = 0x2::table::borrow_mut<address, User>(v1, v0);
        v12.static_power = v12.static_power + v11;
        v12.underway_power = v12.underway_power + v11;
        v12.join_amount = v12.join_amount + arg4;
        v12.invest_amount = v12.invest_amount + arg4;
        let v13 = v12.static_power;
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_asset_invested(v3, arg4);
        if (v12.invest_amount == 0) {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_effective_user(v3, 1);
            update_share_performance(v3, v1, v0, arg4);
        };
        let v14 = 0x2::table::borrow_mut<address, User>(v1, v0);
        let v15 = Order{
            id                 : (0x1::vector::length<Order>(&v14.orders) as u64) + 1,
            start_time         : 0x2::clock::timestamp_ms(arg10),
            amount             : arg4,
            rate               : arg5,
            sui_amount         : v4,
            pre_amount         : v8,
            static_power       : v11,
            total_static_power : v13,
            status             : 0,
        };
        0x1::vector::push_back<Order>(&mut v14.orders, v15);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::add_chances_by_amount<T1>(arg11, arg4, arg12);
        update_performance(v1, v0, arg4);
        update_dynamic_power(v3, v1, v0, arg4);
        calc_level_diff(v3, v1, v0, arg4);
        distribute_burst_reward(v3, v1, v0, arg4, arg0.burst_ratio);
    }

    public fun releaseReward<T0>(arg0: &mut Contract<T0>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 1);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = &mut arg0.users;
        let v1 = &mut arg0.global_network_data;
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            let v4 = *0x1::vector::borrow<address>(&arg1, v3);
            let v5 = 0x2::table::borrow_mut<address, User>(v0, v4);
            assert!(v5.last_distribution_time + 21600000 <= v2, 0);
            v5.today_earning = 0;
            v5.today_share_performance = 0;
            v5.last_distribution_time = v2;
            release_static_power(v5, v1);
            release_dynamic_power(v5, v1);
            handler_out(v1, v4, v0);
            v3 = v3 + 1;
        };
    }

    fun release_dynamic_power(arg0: &mut User, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData) {
        if (arg0.dynamic_power == 0 || arg0.total_earning >= arg0.static_power) {
            return
        };
        let v0 = arg0.dynamic_power / 500;
        arg0.dynamic_power = arg0.dynamic_power - v0;
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::sub_total_dynamic_power(arg1, v0);
        apply_reward(arg0, arg1, v0, false);
    }

    fun release_static_power(arg0: &mut User, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData) {
        if (arg0.total_earning >= arg0.static_power) {
            return
        };
        let v0 = if (arg0.invest_amount < 500000000) {
            4
        } else if (arg0.invest_amount < 1000000000) {
            6
        } else if (arg0.total_earning > arg0.join_amount) {
            6
        } else {
            8
        };
        let v1 = arg0.invest_amount * v0 / 1000;
        apply_reward(arg0, arg1, v1, true);
    }

    public fun setDynamicPower<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x8c5eb0a151f6a8261c7478a92484d6f457b80eb500c1787bce25e813d010a796 == 0x2::tx_context::sender(arg3), 1);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        let v1 = v0.dynamic_power;
        v0.dynamic_power = arg2;
        if (arg2 > v1) {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_dynamic_power(&mut arg0.global_network_data, arg2 - v1);
        } else if (v1 > arg2) {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::sub_total_dynamic_power(&mut arg0.global_network_data, v1 - arg2);
        };
    }

    public fun setStudioLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x8c5eb0a151f6a8261c7478a92484d6f457b80eb500c1787bce25e813d010a796 == 0x2::tx_context::sender(arg3), 1);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).studio_level = arg2;
    }

    public fun setUserLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::LevelDividend, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        let v1 = get_user_level(v0);
        if (arg2 > v1) {
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::update_user_level(arg3, arg1, v1, arg2);
            0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::updateLevel(&mut arg0.global_network_data, v1, arg2);
        };
        v0.level = arg2;
    }

    public(friend) fun set_admin<T0>(arg0: &mut Contract<T0>, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun set_invitees<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: vector<address>) {
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).invitees = arg2;
    }

    public(friend) fun set_team_count<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u64) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::setTeamCount(&mut arg0.global_network_data, arg1, arg2);
    }

    public fun stake<T0>(arg0: &mut Contract<T0>, arg1: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::PriceOracle, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
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
        let v3 = 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::price_oracle::get_usdt_from_pre(arg1, v0);
        0x2::balance::join<T0>(&mut arg0.pre_balance, 0x2::coin::into_balance<T0>(arg2));
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_cumulative_stake(&mut arg0.global_network_data, v0, v3);
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

    public fun unStake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version::check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        let v2 = 0x1::vector::length<StakeOrder>(&v1.stake_orders);
        assert!(v2 > 0 && arg1 <= v2, 1);
        let v3 = 0x1::vector::borrow_mut<StakeOrder>(&mut v1.stake_orders, arg1 - 1);
        assert!(v3.status == 0, 1);
        assert!((0x2::clock::timestamp_ms(arg2) - v3.start_time) / 86400000 >= v3.cycle, 1);
        let v4 = v3.pre_amount;
        withdraw_pre<T0>(arg0, v0, v4, arg3);
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_redemption_pre(&mut arg0.global_network_data, v4);
        let v5 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        assert!(v5.state == 0, 303);
        0x1::vector::borrow_mut<StakeOrder>(&mut v5.stake_orders, arg1 - 1).status = 1;
    }

    fun update_dynamic_power(arg0: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
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
                    let v7 = 0x2::table::borrow<address, User>(arg1, v6);
                    if (v7.invest_amount > 0 || v7.total_caimed_amount > 0) {
                        v3 = v3 + 1;
                    };
                };
                v5 = v5 + 1;
            };
            let v8 = get_share_reward_percent(v1, v3);
            let v9 = 0x2::table::borrow_mut<address, User>(arg1, v2);
            if (v9.invest_amount > 0 && v8 > 0) {
                let v10 = arg3 / 100 * v8;
                v9.dynamic_power = v9.dynamic_power + v10;
                0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_dynamic_power_distributed(arg0, v10);
            };
            v0 = v9.inviter;
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

    fun update_share_performance(arg0: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 0x1::option::none<address>();
        if (0x1::option::is_some<address>(&v0)) {
            let v2 = 0x1::option::extract<address>(&mut v0);
            let v3 = 0x2::table::borrow_mut<address, User>(arg1, v2);
            let v4 = arg3 / 100 * 5;
            if (v3.invest_amount > 0 && v3.total_earning < v3.static_power) {
                let v5 = v3.static_power - v3.total_earning;
                let v6 = if (v4 < v5) {
                    v4
                } else {
                    v5
                };
                if (v6 > 0) {
                    v3.balance = v3.balance + v6;
                    v3.total_earning = v3.total_earning + v6;
                    v3.today_earning = v3.today_earning + v6;
                    0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_total_user_balance(arg0, v6);
                    0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::admin::add_direct_push_reward(arg0, v6);
                    v1 = 0x1::option::some<address>(v2);
                };
            };
        };
        if (0x1::option::is_some<address>(&v1)) {
            handler_out(arg0, 0x1::option::extract<address>(&mut v1), arg1);
        };
    }

    public fun viewSui<T0, T1>(arg0: &Contract<T1>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = &arg0.vault;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v0.sui_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v0.account_cap)) as u64))
    }

    fun withdrawSui<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg8, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap, arg7, arg9), arg9)
    }

    fun withdraw_pre<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.pre_balance) >= arg2, 1001);
        0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pre_balance, arg2), arg3), arg1);
    }

    // decompiled from Move bytecode v7
}

