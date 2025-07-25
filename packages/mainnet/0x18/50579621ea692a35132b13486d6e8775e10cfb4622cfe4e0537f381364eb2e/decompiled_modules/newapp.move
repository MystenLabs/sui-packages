module 0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::newapp {
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
        admin: address,
        rebot: address,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct NewNetData has store {
        in_sui: u64,
        out_sui: u64,
        consume_sui: u64,
        admin_sui: u64,
        user_yy: u64,
        admin_yy: u64,
        user_table: 0x2::table::Table<address, u64>,
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

    fun swap<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::interface::swapCoin<T0, T1>(arg0, arg1, 0, arg2)
    }

    public fun addFields<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<vector<u8>, vector<address>>(&mut arg1.id, b"userList3", 0x1::vector::empty<address>());
    }

    public fun addUser<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<address, User>(&arg1.users, arg2);
        0x2::table::add<address, u64>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg1.id, b"newNetData").user_table, arg2, v0.total_revenue - v0.balance);
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
        0x1::vector::push_back<address>(0x2::dynamic_field::borrow_mut<vector<u8>, vector<address>>(&mut arg0.id, b"userList3"), v1);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<address, User>(v0, arg1).invitees, v1);
        0x2::table::add<address, u64>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData").user_table, v1, 0);
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
        if (arg0 >= 1000000000) {
            arg0 * 4
        } else if (arg0 >= 500000000) {
            arg0 * 3
        } else if (arg0 >= 100000000) {
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

    public fun clac_level_address_page<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (vector<address>, vector<address>, vector<address>) {
        let v0 = get_all_user_list<T0>(arg0);
        assert!(arg1 <= arg2 && arg2 <= 0x1::vector::length<address>(&v0), 1002);
        let v1 = arg1;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x1::vector::empty<address>();
        while (v1 < arg2) {
            let v5 = 0x1::vector::borrow<address>(&v0, v1);
            let v6 = 0x2::table::borrow<address, User>(&arg0.users, *v5);
            if (v6.underway_power <= 0) {
                v1 = v1 + 1;
                continue
            };
            let v7 = get_user_level(v6);
            if (v7 == 5) {
                0x1::vector::push_back<address>(&mut v2, *v5);
            } else if (v7 == 6) {
                0x1::vector::push_back<address>(&mut v3, *v5);
            } else if (v7 == 7) {
                0x1::vector::push_back<address>(&mut v4, *v5);
            };
            v1 = v1 + 1;
        };
        (v2, v3, v4)
    }

    fun clac_level_diff(arg0: &mut Global_NetworkStatistics, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg1, arg2).inviter;
        let v1 = 1;
        0x1::option::none<address>();
        while (0x1::option::is_some<address>(&v0) && v1 <= 200) {
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

    public fun clac_level_number_page<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = get_all_user_list<T0>(arg0);
        assert!(arg1 <= arg2 && arg2 <= 0x1::vector::length<address>(&v0), 1002);
        let v1 = arg1;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x1::vector::empty<address>();
        while (v1 < arg2) {
            let v5 = 0x1::vector::borrow<address>(&v0, v1);
            let v6 = 0x2::table::borrow<address, User>(&arg0.users, *v5);
            if (v6.underway_power <= 0) {
                v1 = v1 + 1;
                continue
            };
            let v7 = get_user_level(v6);
            if (v7 == 5) {
                0x1::vector::push_back<address>(&mut v2, *v5);
            } else if (v7 == 6) {
                0x1::vector::push_back<address>(&mut v3, *v5);
            } else if (v7 == 7) {
                0x1::vector::push_back<address>(&mut v4, *v5);
            };
            v1 = v1 + 1;
        };
        (0x1::vector::length<address>(&v2), 0x1::vector::length<address>(&v3), 0x1::vector::length<address>(&v4))
    }

    public fun clean_daily_static_revenue<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg1), 201);
        let v0 = &mut arg0.users;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.user_list)) {
            0x2::table::borrow_mut<address, User>(v0, *0x1::vector::borrow<address>(&arg0.user_list, v1)).daily_static_revenue = 0;
            v1 = v1 + 1;
        };
    }

    public fun debug<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun deposit<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public entry fun distribution<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg1), 201);
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

    public entry fun distributionBatch<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 201);
        let v0 = get_all_user_list<T0>(arg0);
        assert!(arg1 <= arg2 && arg2 <= 0x1::vector::length<address>(&v0), 1002);
        let v1 = &mut arg0.users;
        let v2 = &v0;
        let v3 = arg1;
        let v4 = &mut arg0.global_network_statistics;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v3 < arg2) {
            let v8 = 0x2::table::borrow_mut<address, User>(v1, *0x1::vector::borrow<address>(v2, v3));
            if (v8.underway_power <= 0) {
                v3 = v3 + 1;
                continue
            };
            let v9 = v8.underway_power / 500;
            let v10 = v8.dynamic_power / 500;
            if (v10 > 0) {
                v7 = v7 + v10;
                v8.dynamic_power = v8.dynamic_power - v10;
            };
            let v11 = v9 + v10;
            let v12 = v8.total_static_power - v8.total_revenue;
            let v13 = if (v12 > v11) {
                v11
            } else {
                v12
            };
            v5 = v5 + v9;
            v6 = v6 + v10;
            v8.release_static_power = v8.release_static_power + v9;
            v8.release_dynamic_power = v8.release_dynamic_power + v10;
            v8.balance = v8.balance + v13;
            v8.total_revenue = v8.total_revenue + v13;
            v8.daily_static_revenue = v8.daily_static_revenue + v13;
            handler_out(v4, v8);
            v3 = v3 + 1;
        };
        v4.total_dynamic_power_invested = v4.total_dynamic_power_invested - v7;
        v4.total_static_power_released = v4.total_static_power_released + v5;
        v4.total_dynamic_power_released = v4.total_dynamic_power_released + v6;
    }

    public fun dividend<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg1), 201);
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

    public fun dividendAddress<T0>(arg0: &mut Contract<T0>, arg1: vector<address>, arg2: vector<address>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg4), 201);
        let v0 = &mut arg0.prize_pool;
        let v1 = &mut arg0.global_network_statistics;
        if (v0.level5_gross > 0) {
            let v2 = v0.level5_gross * (v0.level5_ratio as u64) / 100;
            let v3 = 0x1::vector::length<address>(&arg1);
            if (v2 > 0 && v3 > 0) {
                let v4 = 0;
                let v5 = v2 / v3;
                while (v4 < v3) {
                    let v6 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, *0x1::vector::borrow<address>(&arg1, v4));
                    v6.balance = v6.balance + v5;
                    v6.total_revenue = v6.total_revenue + v5;
                    v6.daily_static_revenue = v6.daily_static_revenue + v5;
                    handler_out(v1, v6);
                    v4 = v4 + 1;
                };
            };
            v0.level5_issued = v0.level5_issued + v2;
            let v7 = v0.level5_gross - v2;
            if (v7 > 0) {
                v0.market_gross = v0.market_gross + v7;
            };
            v0.level5_gross = 0;
        };
        if (v0.level6_gross > 0) {
            let v8 = v0.level6_gross * (v0.level6_ratio as u64) / 100;
            let v9 = 0x1::vector::length<address>(&arg2);
            if (v8 > 0 && v9 > 0) {
                let v10 = 0;
                let v11 = v8 / v9;
                while (v10 < v9) {
                    let v12 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, *0x1::vector::borrow<address>(&arg2, v10));
                    v12.balance = v12.balance + v11;
                    v12.total_revenue = v12.total_revenue + v11;
                    v12.daily_static_revenue = v12.daily_static_revenue + v11;
                    handler_out(v1, v12);
                    v10 = v10 + 1;
                };
            };
            v0.level6_issued = v0.level6_issued + v8;
            let v13 = v0.level6_gross - v8;
            if (v13 > 0) {
                v0.market_gross = v0.market_gross + v13;
            };
            v0.level6_gross = 0;
        };
        if (v0.level7_gross > 0) {
            let v14 = v0.level7_gross * (v0.level7_ratio as u64) / 100;
            let v15 = 0x1::vector::length<address>(&arg3);
            if (v14 > 0 && v15 > 0) {
                let v16 = 0;
                let v17 = v14 / v15;
                while (v16 < v15) {
                    let v18 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, *0x1::vector::borrow<address>(&arg3, v16));
                    v18.balance = v18.balance + v17;
                    v18.total_revenue = v18.total_revenue + v17;
                    v18.daily_static_revenue = v18.daily_static_revenue + v17;
                    handler_out(v1, v18);
                    v16 = v16 + 1;
                };
            };
            v0.level7_issued = v0.level7_issued + v14;
            let v19 = v0.level7_gross - v14;
            if (v19 > 0) {
                v0.market_gross = v0.market_gross + v19;
            };
            v0.level7_gross = 0;
        };
    }

    public fun extract_sui_new<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun extract_sui_newV1<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg9), 201);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
        v0.admin_sui = v0.admin_sui + arg2;
    }

    public fun extract_yy<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        let v0 = &mut arg0.yy_balace;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, arg2, arg3), arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
        v1.admin_yy = v1.admin_yy + arg2;
    }

    public fun findInviter<T0>(arg0: &Contract<T0>, arg1: address) : 0x1::option::Option<address> {
        0x2::table::borrow<address, User>(&arg0.users, arg1).inviter
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

    public fun getNetworkBalancePage<T0>(arg0: &Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = get_all_user_list<T0>(arg0);
        assert!(arg1 <= arg2 && arg2 <= 0x1::vector::length<address>(&v0), 1002);
        let v1 = 0;
        while (arg1 < arg2) {
            v1 = v1 + 0x2::table::borrow<address, User>(&arg0.users, *0x1::vector::borrow<address>(&v0, arg1)).balance;
            arg1 = arg1 + 1;
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

    fun get_all_user_list<T0>(arg0: &Contract<T0>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &arg0.user_list;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(v1, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::dynamic_field::borrow<vector<u8>, vector<address>>(&arg0.id, b"userList");
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(v3)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(v3, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::dynamic_field::borrow<vector<u8>, vector<address>>(&arg0.id, b"userList1");
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(v5)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(v5, v6));
            v6 = v6 + 1;
        };
        let v7 = 0x2::dynamic_field::borrow<vector<u8>, vector<address>>(&arg0.id, b"userList2");
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(v7)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(v7, v8));
            v8 = v8 + 1;
        };
        let v9 = 0x2::dynamic_field::borrow<vector<u8>, vector<address>>(&arg0.id, b"userList3");
        let v10 = 0;
        while (v10 < 0x1::vector::length<address>(v9)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(v9, v10));
            v10 = v10 + 1;
        };
        v0
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
        Share{
            addr                      : v0,
            max_level                 : v2.level,
            total_amount              : v2.total_amount,
            underway_amount           : v2.underway_amount,
            direct_total_amount       : v3,
            direct_underway_amount    : v4,
            community_total_amount    : v2.performance,
            community_underway_amount : v2.performance,
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
                let v5 = (0x2::clock::timestamp_ms(arg1) - v3.start_time) / 86400000;
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{
            id    : 0x2::object::new(arg0),
            admin : @0xae19bd71660b81394336758e6e47cd11cfca09fd0ef78efa442c12c8f85af61b,
        };
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initUsertable<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg1.id, b"newNetData");
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1.user_list)) {
            let v2 = 0x1::vector::borrow<address>(&arg1.user_list, v1);
            let v3 = 0x2::table::borrow<address, User>(&arg1.users, *v2);
            0x2::table::add<address, u64>(&mut v0.user_table, *v2, v3.total_revenue - v3.balance);
            v1 = v1 + 1;
        };
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
            market_addr   : @0xae19bd71660b81394336758e6e47cd11cfca09fd0ef78efa442c12c8f85af61b,
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
            admin                     : @0xae19bd71660b81394336758e6e47cd11cfca09fd0ef78efa442c12c8f85af61b,
            rebot                     : @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1,
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
        0x1::vector::push_back<address>(&mut v3.user_list, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1);
        0x2::table::add<address, User>(&mut v3.users, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1, v4);
        0x2::transfer::share_object<Contract<T0>>(v3);
    }

    public fun insertOrder<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 201);
        let v0 = &mut arg0.global_network_statistics;
        let v1 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v1, arg1), 9223374858648289279);
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
        0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::event::purchase_event(arg1, arg2, v3, v4, v5);
    }

    public fun preSwap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public entry fun purchase<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun purchaseV1<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun purchaseV2<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle::PriceOracle, arg5: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.vault;
        assert!(arg3 >= 100000000, 3);
        assert!(0x2::table::contains<address, User>(v1, v0), 4);
        let v3 = 0x2::table::borrow_mut<address, User>(v1, v0);
        let v4 = arg0.pay_ratio;
        assert!(v4 >= 0 && v4 <= 100, 3);
        let v5 = 0;
        if (v4 > 0) {
            let v6 = 0x2::coin::value<T0>(&arg1);
            v5 = v6;
            assert!(v6 >= 0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle::get_amount(arg4, arg3 * (v4 as u64) / 100), 4);
            deposit<T0>(v2, arg1, arg6, arg7, arg8, arg9, arg10);
            let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
            v7.in_sui = v7.in_sui + v6;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let v8 = 100 - v4;
        let v9 = 0;
        if (v8 > 0) {
            let v10 = 0x2::coin::value<T1>(&arg2);
            v9 = v10;
            assert!(v10 >= yy_swap_out<T0, T1>(arg5, 0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle::get_amount(arg4, arg3 * (v8 as u64) / 100)), 4);
        };
        0x2::balance::join<T1>(&mut arg0.yy_balace, 0x2::coin::into_balance<T1>(arg2));
        let v11 = calc_static_power(arg3);
        let v12 = &mut arg0.global_network_statistics;
        v3.total_amount = v3.total_amount + arg3;
        v3.total_static_power = v3.total_static_power + v11;
        v3.underway_power = v3.underway_power + v11;
        v3.underway_amount = v3.underway_amount + arg3;
        v12.total_invested_amount = v12.total_invested_amount + arg3;
        v12.total_static_power_invested = v12.total_static_power_invested + v11;
        v12.total_asset_invested = v12.total_asset_invested + arg3;
        let v13 = Order{
            id           : (0x1::vector::length<Order>(&v3.orders) as u64) + 1,
            start_time   : 0x2::clock::timestamp_ms(arg10),
            amount       : arg3,
            rate         : v4,
            sui_amount   : v5,
            yy_amount    : v9,
            static_power : v11,
            status       : 0,
        };
        0x1::vector::push_back<Order>(&mut v3.orders, v13);
        update_dynamic_power(v12, v1, v0, arg3);
        clac_level_diff(v12, v1, v0, arg3);
        0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::event::purchase_event(v0, arg3, v11, v5, v9);
    }

    public fun recharge_sui<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun recharge_suiV1<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg7), 201);
        deposit<T0>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun recharge_yy<T0>(arg0: &mut Contract<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 201);
        0x2::balance::join<T0>(&mut arg0.yy_balace, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun removeFields<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: &mut 0x2::tx_context::TxContext) : NewNetData {
        0x2::dynamic_field::remove<vector<u8>, NewNetData>(&mut arg1.id, b"newNetData")
    }

    public entry fun reset_daily_static_batch<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 201);
        let v0 = get_all_user_list<T0>(arg0);
        assert!(arg1 <= arg2 && arg2 <= 0x1::vector::length<address>(&v0), 1002);
        let v1 = &mut arg0.users;
        let v2 = &v0;
        while (arg1 < arg2) {
            0x2::table::borrow_mut<address, User>(v1, *0x1::vector::borrow<address>(v2, arg1)).daily_static_revenue = 0;
            arg1 = arg1 + 1;
        };
    }

    public fun reset_gross<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 400);
        let v0 = &mut arg0.prize_pool;
        v0.level5_gross = 0;
        v0.level6_gross = 0;
        v0.level7_gross = 0;
    }

    public fun setRebot<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rebot = arg2;
    }

    public fun setUserLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 201);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).level = arg2;
    }

    public entry fun set_appoint_level<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg2).appoint_level = arg1;
    }

    public fun set_balance<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).balance = arg2;
    }

    public entry fun set_level_pool<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 201);
        let v0 = &mut arg0.prize_pool;
        v0.level5_ratio = arg1;
        v0.level6_ratio = arg2;
        v0.level7_ratio = arg3;
    }

    public entry fun set_pay_ratio<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 201);
        arg0.pay_ratio = arg1;
    }

    public entry fun set_pool_market<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 201);
        arg0.prize_pool.market_addr = arg1;
    }

    public entry fun set_withdraw_conf<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        arg0.withdraw_charges = arg1;
        arg0.withdraw_ratio = arg2;
    }

    public fun setadmin<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
    }

    public entry fun stake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 100000000, 3);
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
        let v4 = (0x2::clock::timestamp_ms(arg2) - v2.start_time) / 86400000;
        let v5 = v2.amount * get_daily_interest_rate(v4) * v4 / 10000;
        v2.interest = v5;
        v2.status = 1;
        v0.balance = v0.balance + v5 + v2.amount;
    }

    public fun updateFields<T0>(arg0: &Owner, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut Contract<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg7.id, b"newNetData");
        v0.in_sui = arg1;
        v0.out_sui = arg2;
        v0.consume_sui = arg3;
        v0.admin_sui = arg4;
        v0.user_yy = arg5;
        v0.admin_yy = arg6;
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
        while (0x1::option::is_some<address>(&v0) && v1 <= 20) {
            let v2 = 0x2::table::borrow_mut<address, User>(arg0, 0x1::option::extract<address>(&mut v0));
            v2.performance = v2.performance + arg2;
            let v3 = v2.performance;
            let v4 = if (v3 >= 100000000000) {
                3
            } else if (v3 >= 50000000000) {
                2
            } else if (v3 >= 10000000000) {
                1
            } else {
                0
            };
            if (v4 > v2.level && v4 > v2.appoint_level) {
                v2.level = v4;
            };
            v1 = v1 + 1;
            v0 = v2.inviter;
        };
    }

    fun update_user_level(arg0: &0x2::table::Table<address, User>, arg1: address) : u8 {
        let v0 = calc_all_underway_amount(arg0, arg1);
        if (v0 >= 100000000000) {
            3
        } else if (v0 >= 50000000000) {
            2
        } else if (v0 >= 10000000000) {
            1
        } else {
            0
        }
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun withdrawSui<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg6, arg7, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap), arg8)
    }

    public entry fun withdrawV1<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdrawV2<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: u64, arg2: &0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle::PriceOracle, arg3: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) {
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
        let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
        let v8 = 0x2::table::borrow_mut<address, u64>(&mut v7.user_table, 0x2::tx_context::sender(arg10));
        *v8 = *v8 + arg1;
        if (v4 > 0) {
            let v9 = withdrawSui<T0>(v0, 0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle::get_amount(arg2, v4), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg10));
            v7.out_sui = v7.out_sui + 0x2::coin::value<T0>(&v9);
        };
        if (v5 > 0) {
            let v10 = &mut arg0.yy_balace;
            let v11 = yy_swap_out<T0, T1>(arg3, 0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle::get_amount(arg2, v5));
            assert!(v11 <= 0x2::balance::value<T1>(v10), 5);
            let v12 = 0x2::coin::take<T1>(v10, v11, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg10));
            v7.user_yy = v7.user_yy + 0x2::coin::value<T1>(&v12);
        };
        let v13 = v2 / 2;
        if (v13 > 0) {
            let v14 = withdrawSui<T0>(v0, 0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle::get_amount(arg2, v13), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            let v15 = 0x2::coin::value<T0>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, @0x79f367a292221b9f7daba6f48245d6c0eaabb80605e56ae7cc810cd17a00b011);
            v7.out_sui = v7.out_sui + v15;
            v7.consume_sui = v7.consume_sui + v15;
        };
        let v16 = &mut arg0.prize_pool;
        v16.level5_gross = v16.level5_gross + v13 * 50 / 100;
        v16.level6_gross = v16.level6_gross + v13 * 30 / 100;
        v16.level7_gross = v16.level7_gross + v13 * 20 / 100;
        0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::event::withdraw_event(0x2::tx_context::sender(arg10), arg1, v13, v4, v5);
    }

    public fun yy_swap_out<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: u64) : u64 {
        if (arg1 <= 0) {
            0
        } else {
            let (v1, v2, _) = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::interface::getLpliquidity<T0, T1>(arg0);
            arg1 * v2 / v1
        }
    }

    // decompiled from Move bytecode v6
}

