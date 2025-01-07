module 0xd16c90342051794fc6efe4666828ba26bfaa367c935dc05e0a8dc8017046b95d::newapp {
    struct Global_NetworkStatistics has copy, store {
        total_static_power_invested: u64,
        total_dynamic_power_invested: u64,
        total_static_power_released: u64,
        total_dynamic_power_released: u64,
        total_invested_amount: u64,
        total_withdrawn_amount: u64,
        total_user_balance: u64,
        yu_li_bao_unredeemed_amount: u64,
        total_asset_invested: u64,
    }

    struct User has store {
        id: 0x2::object::UID,
        inviter: 0x1::option::Option<address>,
        invitees: vector<address>,
        total_revenue: u64,
        total_amount: u64,
        performance: u64,
        total_static_power: u64,
        dynamic_power: u64,
        level: u8,
        appoint_level: u8,
        balance: u64,
        underway_power: u64,
        underway_amount: u64,
        daily_static_revenue: u64,
        release_static_power: u64,
        release_dynamic_power: u64,
        orders: vector<Order>,
        stake_orders: vector<StakeOrder>,
    }

    struct Order has store {
        id: u64,
        start_time: u64,
        amount: u64,
        rate: u8,
        sui_amount: u64,
        yy_amount: u64,
        static_power: u64,
        status: u8,
    }

    struct StakeOrder has store {
        id: u64,
        start_time: u64,
        status: u8,
        amount: u64,
        interest: u64,
    }

    struct PrizePool has store {
        level5_gross: u64,
        level5_issued: u64,
        level5_ratio: u8,
        level6_gross: u64,
        level6_issued: u64,
        level6_ratio: u8,
        level7_gross: u64,
        level7_issued: u64,
        level7_ratio: u8,
        market_gross: u64,
        market_addr: address,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        user_list: vector<address>,
        yy_balace: 0x2::balance::Balance<T0>,
        withdraw_charges: u8,
        withdraw_ratio: u8,
        pay_ratio: u8,
        prize_pool: PrizePool,
        global_network_statistics: Global_NetworkStatistics,
        vault: Vault,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct Share has copy, drop {
        addr: address,
        max_level: u8,
        total_amount: u64,
        underway_amount: u64,
        direct_total_amount: u64,
        direct_underway_amount: u64,
        community_total_amount: u64,
        community_underway_amount: u64,
    }

    struct StakeOrderTemp has copy, drop {
        id: u64,
        start_time: u64,
        status: u8,
        amount: u64,
        interest: u64,
    }

    fun swap<T0, T1>(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::interface::swapCoin<T0, T1>(arg0, arg1, 0, arg2)
    }

    public entry fun bindInviter<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v0, arg1), 0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, User>(v0, v1), 0);
        let v2 = User{
            id                    : 0x2::object::new(arg2),
            inviter               : 0x1::option::some<address>(arg1),
            invitees              : vector[],
            total_revenue         : 0,
            total_amount          : 0,
            performance           : 0,
            total_static_power    : 0,
            dynamic_power         : 0,
            level                 : 0,
            appoint_level         : 0,
            balance               : 0,
            underway_power        : 0,
            underway_amount       : 0,
            daily_static_revenue  : 0,
            release_static_power  : 0,
            release_dynamic_power : 0,
            orders                : 0x1::vector::empty<Order>(),
            stake_orders          : 0x1::vector::empty<StakeOrder>(),
        };
        0x2::table::add<address, User>(v0, v1, v2);
        0x1::vector::push_back<address>(&mut arg0.user_list, v1);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<address, User>(v0, arg1).invitees, v1);
    }

    fun calc_all_amount(arg0: &0x2::table::Table<address, User>, arg1: &User) : (u64, u64, u8) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1.invitees) && v3 < 20) {
            let v4 = 0x2::table::borrow<address, User>(arg0, *0x1::vector::borrow<address>(&arg1.invitees, v3));
            let (v5, v6, v7) = calc_all_amount(arg0, v4);
            let v8 = v0 + v4.total_amount;
            v0 = v8 + v5;
            let v9 = v1 + v4.underway_amount;
            v1 = v9 + v6;
            if (v7 > v2) {
                v2 = v7;
            };
            if (v4.level > v2) {
                v2 = v4.level;
            };
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    fun calc_all_underway_amount(arg0: &0x2::table::Table<address, User>, arg1: address) : u64 {
        let v0 = 0x2::table::borrow<address, User>(arg0, arg1);
        let v1 = 0;
        let v2 = 0;
        while (0x1::vector::length<address>(&v0.invitees) > v1) {
            let v3 = 0x1::vector::borrow<address>(&v0.invitees, v1);
            let v4 = v2 + 0x2::table::borrow<address, User>(arg0, *v3).underway_amount;
            v2 = v4 + calc_all_underway_amount(arg0, *v3);
            v1 = v1 + 1;
        };
        v2
    }

    fun calc_amount(arg0: &0x2::table::Table<address, User>, arg1: &User) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1.invitees)) {
            let v3 = 0x2::table::borrow<address, User>(arg0, *0x1::vector::borrow<address>(&arg1.invitees, v2));
            v0 = v0 + v3.total_amount;
            v1 = v1 + v3.underway_amount;
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun calc_effective_user(arg0: &0x2::table::Table<address, User>, arg1: address) : u64 {
        let v0 = 0x2::table::borrow<address, User>(arg0, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<address>(&v0.invitees)) {
            if (0x2::table::borrow<address, User>(arg0, *0x1::vector::borrow<address>(&v0.invitees, v1)).underway_power > 0) {
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        v2
    }

    fun calc_static_power(arg0: u64) : u64 {
        if (arg0 >= 1000) {
            arg0 * 4
        } else if (arg0 >= 500) {
            arg0 * 3
        } else if (arg0 >= 100) {
            arg0 * 2
        } else {
            0
        }
    }

    fun check_lower_level(arg0: &User, arg1: &0x2::table::Table<address, User>, arg2: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.invitees)) {
            let v1 = 0x2::table::borrow<address, User>(arg1, *0x1::vector::borrow<address>(&arg0.invitees, v0));
            if (v1.level >= arg2) {
                return true
            };
            if (check_lower_level(v1, arg1, arg2)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun check_user_up_level(arg0: &User, arg1: &0x2::table::Table<address, User>, arg2: u8, arg3: u8) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.invitees)) {
            let v2 = 0x2::table::borrow<address, User>(arg1, *0x1::vector::borrow<address>(&arg0.invitees, v0));
            if (v2.level >= arg3) {
                v1 = v1 + 1;
            } else if (check_lower_level(v2, arg1, arg3)) {
                v1 = v1 + 1;
            };
            if (v1 == arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun clac_level_diff(arg0: &mut Global_NetworkStatistics, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        0x1::option::none<address>();
        while (0x1::option::is_some<address>(&v0) && v1 <= 20) {
            let v2 = 0x2::table::borrow_mut<address, User>(arg1, 0x1::option::extract<address>(&mut v0));
            let v3 = get_user_level(v2);
            if (v3 == 0) {
                v0 = v2.inviter;
                v1 = v1 + 1;
                continue
            };
            if (v3 > 0) {
                let v4 = arg3 * (get_reward_percentage(v3) - 0) / 100;
                if (v2.underway_power > 0) {
                    let v5 = v2.total_static_power - v2.total_revenue;
                    let v6 = if (v5 > v4) {
                        v4
                    } else {
                        v5
                    };
                    v2.balance = v2.balance + v6;
                    v2.total_revenue = v2.total_revenue + v6;
                    v2.daily_static_revenue = v2.daily_static_revenue + v6;
                    handler_out(arg0, v2);
                };
            };
            v0 = v2.inviter;
            v1 = v1 + 1;
        };
    }

    public fun clac_level_number<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg0.user_list)) {
            let v4 = 0x1::vector::borrow<address>(&arg0.user_list, v0);
            let v5 = 0x2::table::borrow<address, User>(&arg0.users, *v4);
            if (v5.underway_power <= 0) {
                v0 = v0 + 1;
                continue
            };
            let v6 = get_user_level(v5);
            if (v6 == 5) {
                0x1::vector::push_back<address>(&mut v1, *v4);
            } else if (v6 == 6) {
                0x1::vector::push_back<address>(&mut v2, *v4);
            } else if (v6 == 7) {
                0x1::vector::push_back<address>(&mut v3, *v4);
            };
            v0 = v0 + 1;
        };
        (0x1::vector::length<address>(&v1), 0x1::vector::length<address>(&v2), 0x1::vector::length<address>(&v3))
    }

    public fun deposit<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public entry fun distribution<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        let v1 = &arg0.user_list;
        let v2 = 0;
        let v3 = &mut arg0.global_network_statistics;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v7 = 0x2::table::borrow_mut<address, User>(v0, *0x1::vector::borrow<address>(v1, v2));
            if (v7.underway_power <= 0) {
                v2 = v2 + 1;
                continue
            };
            let v8 = v7.underway_power / 500;
            let v9 = v7.dynamic_power / 500;
            if (v9 > 0) {
                v6 = v6 + v9;
                v7.dynamic_power = v7.dynamic_power - v9;
            };
            let v10 = v8 + v9;
            let v11 = v7.total_static_power - v7.total_revenue;
            let v12 = if (v11 > v10) {
                v10
            } else {
                v11
            };
            v4 = v4 + v8;
            v5 = v5 + v9;
            v7.release_static_power = v7.release_static_power + v8;
            v7.release_dynamic_power = v7.release_dynamic_power + v9;
            v7.balance = v7.balance + v12;
            v7.total_revenue = v7.total_revenue + v12;
            v7.daily_static_revenue = v7.daily_static_revenue + v12;
            handler_out(v3, v7);
            v2 = v2 + 1;
        };
        v3.total_dynamic_power_invested = v3.total_dynamic_power_invested - v6;
        v3.total_static_power_released = v3.total_static_power_released + v4;
        v3.total_dynamic_power_released = v3.total_dynamic_power_released + v5;
    }

    public fun dividend<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.prize_pool;
        let v1 = 0;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut arg0.global_network_statistics;
        while (v1 < 0x1::vector::length<address>(&arg0.user_list)) {
            let v6 = 0x1::vector::borrow<address>(&arg0.user_list, v1);
            let v7 = 0x2::table::borrow<address, User>(&arg0.users, *v6);
            if (v7.underway_power <= 0) {
                v1 = v1 + 1;
                continue
            };
            let v8 = get_user_level(v7);
            if (v8 == 5) {
                0x1::vector::push_back<address>(&mut v2, *v6);
            } else if (v8 == 6) {
                0x1::vector::push_back<address>(&mut v3, *v6);
            } else if (v8 == 7) {
                0x1::vector::push_back<address>(&mut v4, *v6);
            };
            v1 = v1 + 1;
        };
        if (v0.level5_gross > 0) {
            let v9 = v0.level5_gross * (v0.level5_ratio as u64) / 100;
            let v10 = 0x1::vector::length<address>(&v2);
            if (v9 > 0 && v10 > 0) {
                let v11 = 0;
                let v12 = v9 / v10;
                while (v11 < v10) {
                    let v13 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, *0x1::vector::borrow<address>(&v2, v11));
                    v13.balance = v13.balance + v12;
                    v13.total_revenue = v13.total_revenue + v12;
                    v13.daily_static_revenue = v13.daily_static_revenue + v12;
                    handler_out(v5, v13);
                    v11 = v11 + 1;
                };
            };
            v0.level5_issued = v0.level5_issued + v9;
            let v14 = v0.level5_gross - v9;
            if (v14 > 0) {
                v0.market_gross = v0.market_gross + v14;
            };
            v0.level5_gross = 0;
        };
        if (v0.level6_gross > 0) {
            let v15 = v0.level6_gross * (v0.level6_ratio as u64) / 100;
            let v16 = 0x1::vector::length<address>(&v3);
            if (v15 > 0 && v16 > 0) {
                let v17 = 0;
                let v18 = v15 / v16;
                while (v17 < v16) {
                    let v19 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, *0x1::vector::borrow<address>(&v3, v17));
                    v19.balance = v19.balance + v18;
                    v19.total_revenue = v19.total_revenue + v18;
                    v19.daily_static_revenue = v19.daily_static_revenue + v18;
                    handler_out(v5, v19);
                    v17 = v17 + 1;
                };
            };
            v0.level6_issued = v0.level6_issued + v15;
            let v20 = v0.level6_gross - v15;
            if (v20 > 0) {
                v0.market_gross = v0.market_gross + v20;
            };
            v0.level6_gross = 0;
        };
        if (v0.level7_gross > 0) {
            let v21 = v0.level7_gross * (v0.level7_ratio as u64) / 100;
            let v22 = 0x1::vector::length<address>(&v4);
            if (v21 > 0 && v22 > 0) {
                let v23 = 0;
                let v24 = v21 / v22;
                while (v23 < v22) {
                    let v25 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, *0x1::vector::borrow<address>(&v4, v23));
                    v25.balance = v25.balance + v24;
                    v25.total_revenue = v25.total_revenue + v24;
                    v25.daily_static_revenue = v25.daily_static_revenue + v24;
                    handler_out(v5, v25);
                    v23 = v23 + 1;
                };
            };
            v0.level7_issued = v0.level7_issued + v21;
            let v26 = v0.level7_gross - v21;
            if (v26 > 0) {
                v0.market_gross = v0.market_gross + v26;
            };
            v0.level7_gross = 0;
        };
    }

    public fun extract_sui<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg1);
    }

    public fun extract_sui_new<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg1);
    }

    public fun extract_yy<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.yy_balace;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, arg2, arg3), arg1);
    }

    public fun findSui<T0, T1>(arg0: &Contract<T1>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = &arg0.vault;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v0.sui_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v0.account_cap)) as u64))
    }

    public fun getNetworkBalance<T0>(arg0: &Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.user_list)) {
            v1 = v1 + 0x2::table::borrow<address, User>(&arg0.users, *0x1::vector::borrow<address>(&arg0.user_list, v0)).balance;
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_ShareList<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : vector<Share> {
        let v0 = &mut arg0.users;
        let v1 = 0x2::table::borrow<address, User>(v0, 0x2::tx_context::sender(arg1));
        let v2 = 0;
        let v3 = 0x1::vector::empty<Share>();
        while (v2 < 0x1::vector::length<address>(&v1.invitees)) {
            let v4 = 0x1::vector::borrow<address>(&v1.invitees, v2);
            let v5 = 0x2::table::borrow<address, User>(v0, *v4);
            let v6 = v5.level;
            let v7 = v6;
            let (v8, v9) = calc_amount(v0, v5);
            let (v10, v11, v12) = calc_all_amount(v0, v5);
            if (v12 > v6) {
                v7 = v12;
            };
            let v13 = Share{
                addr                      : *v4,
                max_level                 : v7,
                total_amount              : v5.total_amount,
                underway_amount           : v5.underway_amount,
                direct_total_amount       : v8,
                direct_underway_amount    : v9,
                community_total_amount    : v10,
                community_underway_amount : v11,
            };
            0x1::vector::push_back<Share>(&mut v3, v13);
            v2 = v2 + 1;
        };
        v3
    }

    fun get_daily_interest_rate(arg0: u64) : u64 {
        if (arg0 <= 10) {
            return 10
        };
        if (arg0 <= 20) {
            return 11
        };
        if (arg0 <= 30) {
            return 12
        };
        if (arg0 <= 40) {
            return 13
        };
        if (arg0 <= 50) {
            return 14
        };
        if (arg0 <= 60) {
            return 15
        };
        if (arg0 <= 70) {
            return 16
        };
        if (arg0 <= 80) {
            return 17
        };
        if (arg0 <= 90) {
            return 18
        };
        if (arg0 <= 100) {
            return 19
        };
        if (arg0 <= 110) {
            return 20
        };
        if (arg0 <= 120) {
            return 21
        };
        if (arg0 <= 130) {
            return 22
        };
        if (arg0 <= 140) {
            return 23
        };
        24
    }

    public fun get_effective_user<T0>(arg0: &Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        calc_effective_user(&arg0.users, 0x2::tx_context::sender(arg1))
    }

    public fun get_power_center<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : Share {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &arg0.users;
        let v2 = 0x2::table::borrow<address, User>(v1, v0);
        let (v3, v4) = calc_amount(v1, v2);
        let (v5, v6, v7) = calc_all_amount(v1, v2);
        Share{
            addr                      : v0,
            max_level                 : v7,
            total_amount              : v2.total_amount,
            underway_amount           : v2.underway_amount,
            direct_total_amount       : v3,
            direct_underway_amount    : v4,
            community_total_amount    : v5,
            community_underway_amount : v6,
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
            14
        } else {
            0
        }
    }

    public fun get_stake_ordersV2<T0>(arg0: &Contract<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<StakeOrderTemp> {
        let v0 = 0x2::table::borrow<address, User>(&arg0.users, 0x2::tx_context::sender(arg2));
        let v1 = 0x1::vector::empty<StakeOrderTemp>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeOrder>(&v0.stake_orders)) {
            let v3 = 0x1::vector::borrow<StakeOrder>(&v0.stake_orders, v2);
            let v4 = if (v3.status == 0) {
                let v5 = (0x2::clock::timestamp_ms(arg1) - v3.start_time) / 600000;
                v3.amount * get_daily_interest_rate(v5) * v5 / 10000
            } else {
                v3.interest
            };
            let v6 = StakeOrderTemp{
                id         : v3.id,
                start_time : v3.start_time,
                status     : v3.status,
                amount     : v3.amount,
                interest   : v4,
            };
            0x1::vector::push_back<StakeOrderTemp>(&mut v1, v6);
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_info<T0>(arg0: &Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : &User {
        0x2::table::borrow<address, User>(&arg0.users, 0x2::tx_context::sender(arg1))
    }

    fun get_user_level(arg0: &User) : u8 {
        if (arg0.level > arg0.appoint_level) {
            arg0.level
        } else {
            arg0.appoint_level
        }
    }

    fun handler_out(arg0: &mut Global_NetworkStatistics, arg1: &mut User) {
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<Order>(&arg1.orders) > v0) {
            let v2 = 0x1::vector::borrow_mut<Order>(&mut arg1.orders, v0);
            let v3 = v1 + v2.static_power;
            v1 = v3;
            if (v2.status == 0 && arg1.total_revenue >= v3) {
                v2.status = 1;
                arg1.underway_amount = arg1.underway_amount - v2.amount;
                arg1.underway_power = arg1.underway_power - v2.static_power;
                arg0.total_static_power_invested = arg0.total_static_power_invested - v2.static_power;
                arg0.total_asset_invested = arg0.total_asset_invested - v2.amount;
            };
            v0 = v0 + 1;
        };
    }

    public fun info<T0>(arg0: &Vault, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg0.sui_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{
            id    : 0x2::object::new(arg0),
            admin : @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797,
        };
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_contract<T0>(arg0: &Owner, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v1 = PrizePool{
            level5_gross  : 0,
            level5_issued : 0,
            level5_ratio  : 100,
            level6_gross  : 0,
            level6_issued : 0,
            level6_ratio  : 100,
            level7_gross  : 0,
            level7_issued : 0,
            level7_ratio  : 100,
            market_gross  : 0,
            market_addr   : @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797,
        };
        let v2 = Global_NetworkStatistics{
            total_static_power_invested  : 0,
            total_dynamic_power_invested : 0,
            total_static_power_released  : 0,
            total_dynamic_power_released : 0,
            total_invested_amount        : 0,
            total_withdrawn_amount       : 0,
            total_user_balance           : 0,
            yu_li_bao_unredeemed_amount  : 0,
            total_asset_invested         : 0,
        };
        let v3 = Contract<T0>{
            id                        : 0x2::object::new(arg1),
            users                     : 0x2::table::new<address, User>(arg1),
            user_list                 : vector[],
            yy_balace                 : 0x2::balance::zero<T0>(),
            withdraw_charges          : 10,
            withdraw_ratio            : 80,
            pay_ratio                 : 100,
            prize_pool                : v1,
            global_network_statistics : v2,
            vault                     : v0,
        };
        let v4 = User{
            id                    : 0x2::object::new(arg1),
            inviter               : 0x1::option::none<address>(),
            invitees              : vector[],
            total_revenue         : 0,
            total_amount          : 0,
            performance           : 0,
            total_static_power    : 0,
            dynamic_power         : 0,
            level                 : 0,
            appoint_level         : 0,
            balance               : 0,
            underway_power        : 0,
            underway_amount       : 0,
            daily_static_revenue  : 0,
            release_static_power  : 0,
            release_dynamic_power : 0,
            orders                : 0x1::vector::empty<Order>(),
            stake_orders          : 0x1::vector::empty<StakeOrder>(),
        };
        0x1::vector::push_back<address>(&mut v3.user_list, @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797);
        0x2::table::add<address, User>(&mut v3.users, @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797, v4);
        0x2::transfer::share_object<Contract<T0>>(v3);
    }

    public fun insertOrder<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.global_network_statistics;
        let v1 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v1, arg1), 9223373943820255231);
        let v2 = 0x2::table::borrow_mut<address, User>(v1, arg1);
        let v3 = calc_static_power(arg2);
        v2.total_amount = v2.total_amount + arg2;
        v2.total_static_power = v2.total_static_power + v3;
        v2.underway_power = v2.underway_power + v3;
        v2.underway_amount = v2.underway_amount + arg2;
        v0.total_invested_amount = v0.total_invested_amount + arg2;
        v0.total_static_power_invested = v0.total_static_power_invested + v3;
        v0.total_asset_invested = v0.total_asset_invested + arg2;
        let v4 = 0;
        let v5 = 0;
        let v6 = Order{
            id           : (0x1::vector::length<Order>(&v2.orders) as u64) + 1,
            start_time   : 0x2::clock::timestamp_ms(arg3),
            amount       : arg2,
            rate         : arg0.pay_ratio,
            sui_amount   : v4,
            yy_amount    : v5,
            static_power : v3,
            status       : 0,
        };
        0x1::vector::push_back<Order>(&mut v2.orders, v6);
        update_performance(v1, arg1, arg2);
        0xd16c90342051794fc6efe4666828ba26bfaa367c935dc05e0a8dc8017046b95d::event::purchase_event(arg1, arg2, v3, v4, v5);
    }

    public fun preSwap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public entry fun purchase<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.vault;
        assert!(0x2::table::contains<address, User>(v1, v0), 4);
        let v3 = 0x2::table::borrow_mut<address, User>(v1, v0);
        let v4 = arg0.pay_ratio;
        assert!(v4 >= 0 && v4 <= 100, 3);
        let v5 = 0;
        if (v4 > 0) {
            let v6 = 0x2::coin::value<T0>(&arg1);
            v5 = v6;
            assert!(v6 >= preSwap<T2, T0>(arg4, arg3 * (v4 as u64) / 100), 4);
            deposit<T0>(v2, arg1, arg6, arg7, arg8, arg9, arg10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let v7 = 100 - v4;
        let v8 = 0;
        if (v7 > 0) {
            let v9 = 0x2::coin::value<T1>(&arg2);
            v8 = v9;
            assert!(v9 >= yy_swap_out<T0, T1>(arg5, preSwap<T2, T0>(arg4, arg3 * (v7 as u64) / 100)), 4);
        };
        0x2::balance::join<T1>(&mut arg0.yy_balace, 0x2::coin::into_balance<T1>(arg2));
        let v10 = calc_static_power(arg3);
        let v11 = &mut arg0.global_network_statistics;
        v3.total_amount = v3.total_amount + arg3;
        v3.total_static_power = v3.total_static_power + v10;
        v3.underway_power = v3.underway_power + v10;
        v3.underway_amount = v3.underway_amount + arg3;
        v11.total_invested_amount = v11.total_invested_amount + arg3;
        v11.total_static_power_invested = v11.total_static_power_invested + v10;
        v11.total_asset_invested = v11.total_asset_invested + arg3;
        let v12 = Order{
            id           : (0x1::vector::length<Order>(&v3.orders) as u64) + 1,
            start_time   : 0x2::clock::timestamp_ms(arg10),
            amount       : arg3,
            rate         : v4,
            sui_amount   : v5,
            yy_amount    : v8,
            static_power : v10,
            status       : 0,
        };
        0x1::vector::push_back<Order>(&mut v3.orders, v12);
        update_dynamic_power(v11, v1, v0, arg3);
        update_performance(v1, v0, arg3);
        clac_level_diff(v11, v1, v0, arg3);
        0xd16c90342051794fc6efe4666828ba26bfaa367c935dc05e0a8dc8017046b95d::event::purchase_event(v0, arg3, v10, v5, v8);
    }

    public fun recharge_sui<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun recharge_yy<T0>(arg0: &mut Contract<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.yy_balace, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun set_appoint_level<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg2).appoint_level = arg1;
    }

    public fun set_balance<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).balance = arg2;
    }

    public entry fun set_level_pool<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.prize_pool;
        v0.level5_ratio = arg1;
        v0.level6_ratio = arg2;
        v0.level7_ratio = arg3;
    }

    public entry fun set_pay_ratio<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.pay_ratio = arg1;
    }

    public entry fun set_pool_market<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.prize_pool.market_addr = arg1;
    }

    public entry fun set_withdraw_conf<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.withdraw_charges = arg1;
        arg0.withdraw_ratio = arg2;
    }

    public entry fun stake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        assert!(v0.balance >= arg1, 1);
        let v1 = &mut arg0.global_network_statistics;
        v1.yu_li_bao_unredeemed_amount = v1.yu_li_bao_unredeemed_amount + arg1;
        v0.balance = v0.balance - arg1;
        let v2 = StakeOrder{
            id         : 0x1::vector::length<StakeOrder>(&v0.stake_orders) + 1,
            start_time : 0x2::clock::timestamp_ms(arg2),
            status     : 0,
            amount     : arg1,
            interest   : 0,
        };
        0x1::vector::push_back<StakeOrder>(&mut v0.stake_orders, v2);
    }

    public fun transter_owner(arg0: Owner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Owner>(arg0, arg1);
    }

    public entry fun unstake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        let v1 = 0x1::vector::length<StakeOrder>(&v0.stake_orders);
        assert!(v1 > 0 && arg1 <= v1, 1);
        let v2 = 0x1::vector::borrow_mut<StakeOrder>(&mut v0.stake_orders, arg1 - 1);
        let v3 = &mut arg0.global_network_statistics;
        v3.yu_li_bao_unredeemed_amount = v3.yu_li_bao_unredeemed_amount - v2.amount;
        assert!(v2.status == 0, 1);
        let v4 = (0x2::clock::timestamp_ms(arg2) - v2.start_time) / 600000;
        let v5 = v2.amount * get_daily_interest_rate(v4) * v4 / 10000;
        v2.interest = v5;
        v2.status = 1;
        v0.balance = v0.balance + v5 + v2.amount;
    }

    fun update_dynamic_power(arg0: &mut Global_NetworkStatistics, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 10) {
            let v2 = 0x1::option::extract<address>(&mut v0);
            let v3 = 0x2::table::borrow_mut<address, User>(arg1, v2);
            let v4 = &v1;
            let v5 = if (*v4 == 1) {
                let v6 = calc_effective_user(arg1, v2);
                let v7 = &v6;
                if (*v7 == 0) {
                    0
                } else if (*v7 == 1) {
                    60
                } else if (*v7 == 2) {
                    70
                } else if (*v7 == 3) {
                    80
                } else if (*v7 == 4) {
                    90
                } else {
                    100
                }
            } else if (*v4 == 2) {
                if (calc_effective_user(arg1, v2) >= 2) {
                    40
                } else {
                    0
                }
            } else if (*v4 == 3) {
                if (calc_effective_user(arg1, v2) >= 3) {
                    30
                } else {
                    0
                }
            } else if (*v4 == 4) {
                if (calc_effective_user(arg1, v2) >= 4) {
                    20
                } else {
                    0
                }
            } else if (*v4 == 5) {
                if (calc_effective_user(arg1, v2) >= 5) {
                    10
                } else {
                    0
                }
            } else if (*v4 == 6) {
                if (calc_effective_user(arg1, v2) >= 6) {
                    10
                } else {
                    0
                }
            } else if (*v4 == 7) {
                if (calc_effective_user(arg1, v2) >= 7) {
                    10
                } else {
                    0
                }
            } else if (*v4 == 8) {
                if (calc_effective_user(arg1, v2) >= 8) {
                    20
                } else {
                    0
                }
            } else if (*v4 == 9) {
                if (calc_effective_user(arg1, v2) >= 9) {
                    30
                } else {
                    0
                }
            } else if (*v4 == 10) {
                if (calc_effective_user(arg1, v2) >= 10) {
                    40
                } else {
                    0
                }
            } else {
                0
            };
            if (v5 > 0 && v3.underway_power > 0) {
                let v8 = arg3 * v5 / 100;
                v3.dynamic_power = v3.dynamic_power + v8;
                arg0.total_dynamic_power_invested = arg0.total_dynamic_power_invested + v8;
            };
            v1 = v1 + 1;
            v0 = v3.inviter;
        };
    }

    fun update_performance(arg0: &mut 0x2::table::Table<address, User>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg0, arg1).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 30) {
            let v2 = 0x1::option::extract<address>(&mut v0);
            let v3 = 0x2::table::borrow_mut<address, User>(arg0, v2);
            v3.level = update_user_level(arg0, v2);
            v3.performance = v3.performance + arg2;
            v1 = v1 + 1;
            v0 = v3.inviter;
        };
    }

    fun update_user_level(arg0: &0x2::table::Table<address, User>, arg1: address) : u8 {
        let v0 = 0x2::table::borrow<address, User>(arg0, arg1);
        let v1 = calc_all_underway_amount(arg0, arg1);
        let v2 = if (v1 >= 100000) {
            3
        } else if (v1 >= 50000) {
            2
        } else if (v1 >= 10000) {
            1
        } else {
            0
        };
        let v3 = v2;
        if (v2 == 3) {
            if (check_user_up_level(v0, arg0, 2, 3)) {
                v3 = 4;
            };
        };
        if (v3 == 4) {
            if (check_user_up_level(v0, arg0, 2, 4)) {
                v3 = 5;
            };
        };
        if (v3 == 5) {
            if (check_user_up_level(v0, arg0, 2, 5)) {
                v3 = 6;
            };
        };
        if (v3 == 6) {
            if (check_user_up_level(v0, arg0, 3, 6)) {
                v3 = 7;
            };
        };
        v3
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.vault;
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg10));
        assert!(arg1 > 0, 0);
        assert!(v1.balance >= arg1, 1);
        v1.balance = v1.balance - arg1;
        let v2 = arg1 * (arg0.withdraw_charges as u64) / 100;
        let v3 = arg1 - v2;
        let v4 = v3 * (arg0.withdraw_ratio as u64) / 100;
        let v5 = v3 - v4;
        let v6 = &mut arg0.global_network_statistics;
        v6.total_withdrawn_amount = v6.total_withdrawn_amount + arg1;
        if (v4 > 0) {
            let v7 = withdrawSui<T0>(v0, preSwap<T2, T0>(arg2, v4), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg10));
        };
        if (v5 > 0) {
            let v8 = &mut arg0.yy_balace;
            let v9 = yy_swap_out<T0, T1>(arg3, preSwap<T2, T0>(arg2, v5));
            assert!(v9 <= 0x2::balance::value<T1>(v8), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(v8, v9, arg10), 0x2::tx_context::sender(arg10));
        };
        let v10 = v2 / 2;
        if (v10 > 0) {
            let v11 = withdrawSui<T0>(v0, preSwap<T2, T0>(arg2, v10), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            let v12 = swap<T0, T1>(arg3, v11, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, @0x0);
        };
        let v13 = &mut arg0.prize_pool;
        v13.level5_gross = v13.level5_gross + v10 * 50 / 100;
        v13.level6_gross = v13.level6_gross + v10 * 30 / 100;
        v13.level7_gross = v13.level7_gross + v10 * 20 / 100;
        0xd16c90342051794fc6efe4666828ba26bfaa367c935dc05e0a8dc8017046b95d::event::withdraw_event(0x2::tx_context::sender(arg10), arg1, v10, v4, v5);
    }

    public fun withdrawSui<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg6, arg7, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap), arg8)
    }

    public fun yy_swap_out<T0, T1>(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: u64) : u64 {
        if (arg1 <= 0) {
            0
        } else {
            let (v1, v2, _) = 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::interface::getLpliquidity<T0, T1>(arg0);
            arg1 * v2 / v1
        }
    }

    // decompiled from Move bytecode v6
}

