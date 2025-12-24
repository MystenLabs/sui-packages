module 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::dapp {
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

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        pre_balance: 0x2::balance::Balance<T0>,
        pay_ratio: u8,
        up_time: u64,
        withdraw_charges: u8,
        withdraw_ratio: u8,
        global_network_data: 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::GlobalNetworkData,
        vault: Vault,
        admin: address,
        rebot: address,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun adminWithdrawAmount<T0, T1>(arg0: &mut Contract<T1>, arg1: u64, arg2: address, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg10), 1);
        assert!(arg1 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&arg0.vault, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), arg2);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_admin_sui_amount(&mut arg0.global_network_data, arg1);
    }

    public entry fun adminWithdraw_pre<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        withdraw_pre<T0>(arg0, arg1, arg2, arg3);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_admin_pre_amount(&mut arg0.global_network_data, arg2);
    }

    fun apply_reward(arg0: &mut User, arg1: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::GlobalNetworkData, arg2: u64, arg3: bool) {
        let v0 = arg0.static_power - arg0.total_earning;
        let v1 = if (arg2 < v0) {
            arg2
        } else {
            v0
        };
        arg0.balance = arg0.balance + v1;
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_user_balance(arg1, v1);
        arg0.total_earning = arg0.total_earning + v1;
        arg0.today_earning = arg0.today_earning + v1;
        handler_out(arg1, arg0);
        if (arg3) {
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_static_power_distributed(arg1, v1);
        } else {
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_dynamic_power_distributed_amount(arg1, v1);
        };
    }

    public fun appointUserLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::updateLevel(&mut arg0.global_network_data, get_user_level(v0), arg2);
        v0.appoint_level = arg2;
    }

    public entry fun bindInviter<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v0, arg1), 0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, User>(v0, v1), 0);
        let v2 = User{
            inviter                 : 0x1::option::some<address>(arg1),
            invitees                : 0x1::vector::empty<address>(),
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
            orders                  : 0x1::vector::empty<Order>(),
            stake_orders            : 0x1::vector::empty<StakeOrder>(),
        };
        0x2::table::add<address, User>(v0, v1, v2);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<address, User>(v0, arg1).invitees, v1);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_user(&mut arg0.global_network_data, 1);
    }

    public fun buyToken<T0, T1>(arg0: &mut Contract<T1>, arg1: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg2: &0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::PriceOracle, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 13906838026929045503);
        let v1 = 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::get_sui_amount(arg2, v0);
        let v2 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg5));
        let v3 = 0x2::clock::timestamp_ms(arg4);
        if (v2.last_buy_time != 0) {
            assert!(v3 >= v2.last_buy_time + 86400000, 1);
        };
        assert!(v1 <= v2.quota / 10, 2);
        v2.quota = v2.quota - v1;
        v2.last_buy_time = v3;
        let v4 = 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::interface::swapCoin<T0, T1>(arg1, arg3, 0, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg5));
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_use_pre_buy_quota(&mut arg0.global_network_data, v1, 0x2::coin::value<T1>(&v4));
    }

    fun calc_equity_level(arg0: u64) : u8 {
        if (arg0 >= 10000000000) {
            5
        } else if (arg0 >= 8000000000) {
            4
        } else if (arg0 >= 6000000000) {
            3
        } else if (arg0 >= 4000000000) {
            2
        } else if (arg0 >= 2000000000) {
            1
        } else {
            0
        }
    }

    fun calc_level_diff(arg0: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 100) {
            let v2 = 0x2::table::borrow_mut<address, User>(arg1, 0x1::option::extract<address>(&mut v0));
            let v3 = get_user_level(v2);
            if (v3 == 0) {
                v0 = v2.inviter;
                v1 = v1 + 1;
                continue
            };
            if (v3 > 0) {
                let v4 = arg3 * (get_reward_percentage(v3) - 0) / 100;
                if (v2.invest_amount > 0) {
                    let v5 = v2.static_power - v2.total_earning;
                    let v6 = if (v5 > v4) {
                        v4
                    } else {
                        v5
                    };
                    v2.balance = v2.balance + v6;
                    v2.total_earning = v2.total_earning + v6;
                    v2.today_earning = v2.today_earning + v6;
                    handler_out(arg0, v2);
                    0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::addTeamReward(arg0, v6);
                };
            };
            v0 = v2.inviter;
            v1 = v1 + 1;
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
            arg0 * 1
        }
    }

    public entry fun claimBalance<T0, T1>(arg0: &mut Contract<T1>, arg1: &0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::PriceOracle, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.global_network_data;
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg11));
        assert!(arg2 > 0, 202);
        assert!(v1.balance >= arg2, 203);
        assert!(v1.state == 0, 303);
        v1.balance = v1.balance - arg2;
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::sub_total_user_balance(v0, arg2);
        let v2 = arg2 / 10;
        let v3 = v2 / 2;
        let v4 = 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::get_sui_amount(arg1, arg2 - v2);
        let v5 = withdrawSui<T0>(&arg0.vault, v4, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        let v6 = withdrawSui<T0>(&arg0.vault, 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::get_sui_amount(arg1, v3), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::interface::swapCoin<T0, T1>(arg10, v6, 0, arg11), @0x0);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_claimed_amount(v0, arg2, v4, v2);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_pre_burn_usdt_amount(v0, v3);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_share_rank_dividend_amount(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun claimInterest<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg4));
        assert!(v1.state == 0, 303);
        let v2 = 0x1::vector::length<StakeOrder>(&v1.stake_orders);
        assert!(v2 > 0 && arg1 <= v2, 1);
        let v3 = &mut arg0.global_network_data;
        let v4 = 0x1::vector::borrow_mut<StakeOrder>(&mut v1.stake_orders, arg1 - 1);
        let v5 = (0x2::clock::timestamp_ms(arg3) - v4.start_time) / 86400000;
        let v6 = v4.amount * get_daily_interest_rate(v5) * v5 / 10000 - v4.interest;
        assert!(v6 > 0, 2);
        v4.interest = v4.interest + v6;
        let v7 = 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::get_usdt_from_pre(arg2, v6);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_caimed_stake_interest(v3, v6, v7);
        withdraw_pre<T0>(arg0, v0, v7, arg4);
    }

    fun depositSui<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public fun freezeUser<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).state = arg2;
        if (arg2 == 1) {
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_freeze_user(&mut arg0.global_network_data, 1);
        } else {
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::sub_total_freeze_user(&mut arg0.global_network_data, 1);
        };
    }

    fun get_daily_interest_rate(arg0: u64) : u64 {
        if (arg0 == 7) {
            return 10
        };
        if (arg0 == 30) {
            return 20
        };
        if (arg0 == 90) {
            return 30
        };
        if (arg0 == 180) {
            return 40
        };
        50
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
            14
        } else {
            0
        }
    }

    fun get_share_reward_percent(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 > 20) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = if (arg1 > 11) {
            11
        } else {
            arg1
        };
        if (arg0 == 1) {
            let v2 = 50 + (v1 - 1) * 10;
            return if (v2 > 100) {
                100
            } else {
                v2
            }
        };
        if (arg0 >= 2 && arg0 <= 10) {
            if (arg0 == 2) {
                return 50
            };
            if (arg0 == 3) {
                return 40
            };
            if (arg0 == 4) {
                return 30
            };
            if (arg0 == 5) {
                return 20
            };
            return 10
        };
        if (arg0 >= 11 && arg0 <= 20) {
            return if (v1 >= 11) {
                1
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
            let v5 = StakeOrder{
                id                 : v3.id,
                start_time         : v3.start_time,
                status             : v3.status,
                cycle              : v3.cycle,
                pre_amount         : v3.pre_amount,
                amount             : v3.amount,
                interest           : v3.interest,
                unclaimed_interest : v3.amount * get_daily_interest_rate(v4) * v4 / 10000 - v3.interest,
            };
            0x1::vector::push_back<StakeOrder>(&mut v1, v5);
            v2 = v2 + 1;
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

    fun handler_out(arg0: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::GlobalNetworkData, arg1: &mut User) {
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<Order>(&arg1.orders) > v0) {
            let v2 = 0x1::vector::borrow_mut<Order>(&mut arg1.orders, v0);
            let v3 = v1 + v2.static_power;
            v1 = v3;
            if (v2.status == 0 && arg1.total_earning >= v3) {
                v2.status = 1;
                arg1.invest_amount = arg1.invest_amount - v2.amount;
                arg1.underway_power = arg1.underway_power - v2.static_power;
                0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::sub_total_asset_invested(arg0, v2.amount);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public fun init_contract<T0>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        let v0 = @0x48a451b8a98f4e9cda542e4a87ab2449c9d3e53fbe1bac991ae38de4599143a0;
        let v1 = User{
            inviter                 : 0x1::option::none<address>(),
            invitees                : 0x1::vector::empty<address>(),
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
            orders                  : 0x1::vector::empty<Order>(),
            stake_orders            : 0x1::vector::empty<StakeOrder>(),
        };
        let v2 = 0x2::table::new<address, User>(arg2);
        0x2::table::add<address, User>(&mut v2, v0, v1);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v0);
        let v4 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v5 = Contract<T0>{
            id                  : 0x2::object::new(arg2),
            users               : v2,
            pre_balance         : 0x2::balance::zero<T0>(),
            pay_ratio           : 100,
            up_time             : 0x2::clock::timestamp_ms(arg1),
            withdraw_charges    : 10,
            withdraw_ratio      : 100,
            global_network_data : 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::new(),
            vault               : v4,
            admin               : @0xbe4924761cf5391ad7e9e2b59bbc25fac58462146f961cd37374a6b90be42174,
            rebot               : @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45,
        };
        0x2::transfer::share_object<Contract<T0>>(v5);
    }

    public entry fun investment<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::PriceOracle, arg4: u64, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::rank_list::TodayRank, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = &mut arg0.users;
        let v2 = &arg0.vault;
        let v3 = &mut arg0.global_network_data;
        assert!(arg4 >= 100000000, 302);
        assert!(0x2::table::contains<address, User>(v1, v0), 1);
        let v4 = 0x2::table::borrow_mut<address, User>(v1, v0);
        assert!(v4.state == 0, 303);
        let v5 = 0;
        if (arg5 > 0) {
            let v6 = 0x2::coin::value<T0>(&arg1);
            v5 = v6;
            depositSui<T0>(v2, arg1, arg6, arg7, arg8, arg9, arg11);
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_sui_invested(v3, v6, arg4 * (arg5 as u64) / 100);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let v7 = 100 - arg5;
        let v8 = 0;
        if (v7 > 0) {
            let v9 = 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::get_pre_amount(arg3, arg4 * (v7 as u64) / 100);
            let v10 = 0x2::coin::value<T1>(&arg2);
            v8 = v10;
            assert!(v10 >= v9, 2);
            0x2::balance::join<T1>(&mut arg0.pre_balance, 0x2::coin::into_balance<T1>(arg2));
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_pre_invested(v3, v10, v9);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
        };
        let v11 = v4.invest_amount == 0;
        let v12 = calc_static_power(arg4);
        v4.static_power = v4.static_power + v12;
        v4.underway_power = v4.underway_power + v12;
        v4.join_amount = v4.join_amount + arg4;
        v4.invest_amount = v4.invest_amount + arg4;
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_asset_invested(v3, arg4);
        if (v11) {
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_effective_user(v3, 1);
        };
        let v13 = Order{
            id                 : (0x1::vector::length<Order>(&v4.orders) as u64) + 1,
            start_time         : 0x2::clock::timestamp_ms(arg11),
            amount             : arg4,
            rate               : arg5,
            sui_amount         : v5,
            pre_amount         : v8,
            static_power       : v12,
            total_static_power : v4.static_power,
            status             : 0,
        };
        0x1::vector::push_back<Order>(&mut v4.orders, v13);
        if (v11 && arg0.up_time < 0x2::clock::timestamp_ms(arg11)) {
            let v14 = calc_equity_level(arg4);
            v4.level = v14;
            0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::updateLevel(v3, 0, v14);
            v4.benefit_expiry = 0x2::clock::timestamp_ms(arg11) + 8640000000;
        };
        update_share_performance(arg10, v1, v0, arg4, arg11);
        update_performance(v1, v0, arg4);
        update_dynamic_power(v3, v1, v0, arg4, v11);
        calc_level_diff(v3, v1, v0, arg4);
    }

    public fun releaseReward<T0>(arg0: &mut Contract<T0>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        let v1 = &mut arg0.global_network_data;
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            let v4 = 0x2::table::borrow_mut<address, User>(v0, *0x1::vector::borrow<address>(&arg1, v3));
            assert!(v4.last_distribution_time + 21600000 <= v2, 0);
            v4.today_earning = 0;
            v4.today_share_performance = 0;
            v4.last_distribution_time = v2;
            release_static_power(v4, v1);
            release_dynamic_power(v4, v1);
            v3 = v3 + 1;
        };
    }

    fun release_dynamic_power(arg0: &mut User, arg1: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::GlobalNetworkData) {
        if (arg0.dynamic_power == 0 || arg0.total_earning >= arg0.static_power) {
            return
        };
        let v0 = arg0.dynamic_power / 500;
        arg0.dynamic_power = arg0.dynamic_power - v0;
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::sub_total_dynamic_power(arg1, v0);
        apply_reward(arg0, arg1, v0, false);
    }

    fun release_static_power(arg0: &mut User, arg1: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::GlobalNetworkData) {
        if (arg0.total_earning >= arg0.static_power) {
            return
        };
        let v0 = if (arg0.total_earning >= arg0.join_amount) {
            6
        } else {
            10
        };
        let v1 = arg0.underway_power * v0 / 1000;
        apply_reward(arg0, arg1, v1, true);
    }

    public fun setAdmin<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45 == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    public fun setPayRatio<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 >= 0 && arg1 <= 100, 2);
        arg0.pay_ratio = arg1;
    }

    public fun setUserLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 2);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).level = arg2;
    }

    public entry fun stake<T0>(arg0: &mut Contract<T0>, arg1: &0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::PriceOracle, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
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
        0x2::balance::join<T0>(&mut arg0.pre_balance, 0x2::coin::into_balance<T0>(arg2));
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_cumulative_stake(&mut arg0.global_network_data, v0);
        let v3 = StakeOrder{
            id                 : 0x1::vector::length<StakeOrder>(&v2.stake_orders) + 1,
            start_time         : 0x2::clock::timestamp_ms(arg4),
            status             : 0,
            cycle              : arg3,
            pre_amount         : v0,
            amount             : 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::price_oracle::get_pre_amount(arg1, v0),
            interest           : 0,
            unclaimed_interest : 0,
        };
        0x1::vector::push_back<StakeOrder>(&mut v2.stake_orders, v3);
    }

    public entry fun unStake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        let v2 = 0x1::vector::length<StakeOrder>(&v1.stake_orders);
        assert!(v2 > 0 && arg1 <= v2, 1);
        let v3 = 0x1::vector::borrow_mut<StakeOrder>(&mut v1.stake_orders, arg1 - 1);
        assert!(v3.status == 0, 1);
        assert!((0x2::clock::timestamp_ms(arg2) - v3.start_time) / 86400000 >= v3.cycle, 1);
        let v4 = v3.pre_amount;
        withdraw_pre<T0>(arg0, v0, v4, arg3);
        0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_redemption_pre(&mut arg0.global_network_data, v4);
        let v5 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        assert!(v5.state == 0, 303);
        0x1::vector::borrow_mut<StakeOrder>(&mut v5.stake_orders, arg1 - 1).status = 1;
    }

    fun update_dynamic_power(arg0: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64, arg4: bool) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 20) {
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
                if (v1 == 1 && arg4) {
                    let v10 = v9 / 10;
                    0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_user_balance(arg0, v10);
                    v8.balance = v8.balance + v10;
                    v8.today_earning = v8.today_earning + v10;
                    v8.total_earning = v8.total_earning + v10;
                    handler_out(arg0, v8);
                    v8.dynamic_power = v8.dynamic_power + v9 - v10;
                    0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_dynamic_power_distributed(arg0, v9 - v10);
                    0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_share_reward(arg0, v10);
                } else {
                    v8.dynamic_power = v8.dynamic_power + v9;
                    0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_dynamic_power_distributed(arg0, v9);
                };
                if (v1 == 1) {
                    v8.quota = v8.quota + v9;
                    0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin::add_total_pre_buy_quota(arg0, v9);
                };
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

    fun update_share_performance(arg0: &mut 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::rank_list::TodayRank, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        if (0x1::option::is_some<address>(&v0)) {
            let v1 = 0x1::option::extract<address>(&mut v0);
            let v2 = 0x2::table::borrow_mut<address, User>(arg1, v1);
            if (v2.invest_amount > 0) {
                v2.today_share_performance = v2.today_share_performance + arg3;
                0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::rank_list::add_performance(arg0, v1, arg3, arg4);
            };
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pre_balance, arg2), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

