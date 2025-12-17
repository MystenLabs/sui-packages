module 0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::dapp {
    struct GlobalNetworkData has store {
        total_user: u64,
        total_effective_user: u64,
        total_user_balance: u64,
        total_invested_amount: u64,
        total_sui_invested_amount: u64,
        total_pre_invested_amount: u64,
        total_withdrawn_amount: u64,
        total_asset_invested: u64,
        total_area_invested: u64,
        total_cumulative_stake: u64,
        total_claimed_amount: u64,
        total_claimed_sui: u64,
        total_static_power_distributed: u64,
        total_dynamic_power_distributed: u64,
    }

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
    }

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        pre_balance: 0x2::balance::Balance<T0>,
        pay_ratio: u8,
        up_time: u64,
        withdraw_charges: u8,
        withdraw_ratio: u8,
        global_network_data: GlobalNetworkData,
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

    fun apply_reward(arg0: &mut User, arg1: &mut GlobalNetworkData, arg2: u64, arg3: bool) {
        let v0 = arg0.static_power - arg0.total_earning;
        let v1 = if (arg2 < v0) {
            arg2
        } else {
            v0
        };
        arg0.balance = arg0.balance + v1;
        arg0.total_earning = arg0.total_earning + v1;
        arg0.today_earning = arg0.today_earning + v1;
        handler_out(arg1, arg0);
        if (arg3) {
            arg1.total_static_power_distributed = arg1.total_static_power_distributed + v1;
        } else {
            arg1.total_dynamic_power_distributed = arg1.total_dynamic_power_distributed + v1;
        };
    }

    public fun appointUserLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).appoint_level = arg2;
    }

    public entry fun bindInviter<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v0, arg1), 0);
        let v1 = &mut arg0.global_network_data;
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, User>(v0, v2), 0);
        let v3 = User{
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
            orders                  : 0x1::vector::empty<Order>(),
            stake_orders            : 0x1::vector::empty<StakeOrder>(),
        };
        0x2::table::add<address, User>(v0, v2, v3);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<address, User>(v0, arg1).invitees, v2);
        v1.total_user = v1.total_user + 1;
    }

    public fun buyToken<T0, T1>(arg0: &mut Contract<T1>, arg1: &0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::PriceOracle, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13906837404158787583);
        let v1 = 0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::get_sui_amount(arg1, v0);
        let v2 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        assert!(v2.quota >= v1, 2);
        v2.quota = v2.quota - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
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

    fun calc_level_diff(arg0: &mut GlobalNetworkData, arg1: &mut 0x2::table::Table<address, User>, arg2: address, arg3: u64) {
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
            0
        }
    }

    public entry fun claimBalance<T0, T1>(arg0: &mut Contract<T1>, arg1: &0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::PriceOracle, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg9));
        assert!(arg2 > 0, 0);
        assert!(v0.balance >= arg2, 1);
        v0.balance = v0.balance - arg2;
        let v1 = withdrawSui<T0>(&arg0.vault, 0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::get_sui_amount(arg1, arg2 - arg2 / 10), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg9));
    }

    public entry fun claimInterest<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg4));
        let v2 = 0x1::vector::length<StakeOrder>(&v1.stake_orders);
        assert!(v2 > 0 && arg1 <= v2, 1);
        let v3 = 0x1::vector::borrow_mut<StakeOrder>(&mut v1.stake_orders, arg1 - 1);
        let v4 = (0x2::clock::timestamp_ms(arg3) - v3.start_time) / 86400000;
        let v5 = v3.amount * get_daily_interest_rate(v4) * v4 / 10000 - v3.interest;
        assert!(v5 > 0, 2);
        v3.interest = v3.interest + v5;
        withdraw_pre<T0>(arg0, v0, 0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::get_usdt_amount(arg2, v5), arg4);
    }

    fun depositSui<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public fun freezeUser<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).state = arg2;
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

    public fun get_stake_order<T0>(arg0: &Contract<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : vector<StakeOrder> {
        let v0 = &0x2::table::borrow<address, User>(&arg0.users, 0x2::tx_context::sender(arg2)).stake_orders;
        let v1 = 0x1::vector::empty<StakeOrder>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeOrder>(v0)) {
            let v3 = 0x1::vector::borrow<StakeOrder>(v0, v2);
            let v4 = (0x2::clock::timestamp_ms(arg1) - v3.start_time) / 86400000;
            let v5 = StakeOrder{
                id         : v3.id,
                start_time : v3.start_time,
                status     : v3.status,
                cycle      : v3.cycle,
                pre_amount : v3.pre_amount,
                amount     : v3.amount,
                interest   : v3.amount * get_daily_interest_rate(v4) * v4 / 10000 - v3.interest,
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

    fun handler_out(arg0: &mut GlobalNetworkData, arg1: &mut User) {
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
                arg0.total_asset_invested = arg0.total_asset_invested - v2.amount;
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
        let v5 = GlobalNetworkData{
            total_user                      : 0,
            total_effective_user            : 0,
            total_user_balance              : 0,
            total_invested_amount           : 0,
            total_sui_invested_amount       : 0,
            total_pre_invested_amount       : 0,
            total_withdrawn_amount          : 0,
            total_asset_invested            : 0,
            total_area_invested             : 0,
            total_cumulative_stake          : 0,
            total_claimed_amount            : 0,
            total_claimed_sui               : 0,
            total_static_power_distributed  : 0,
            total_dynamic_power_distributed : 0,
        };
        let v6 = Contract<T0>{
            id                  : 0x2::object::new(arg2),
            users               : v2,
            pre_balance         : 0x2::balance::zero<T0>(),
            pay_ratio           : 100,
            up_time             : 0x2::clock::timestamp_ms(arg1),
            withdraw_charges    : 10,
            withdraw_ratio      : 100,
            global_network_data : v5,
            vault               : v4,
            admin               : @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45,
            rebot               : @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45,
        };
        0x2::transfer::share_object<Contract<T0>>(v6);
    }

    public entry fun investment<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::PriceOracle, arg4: u64, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = &mut arg0.users;
        let v2 = &arg0.vault;
        let v3 = &mut arg0.global_network_data;
        assert!(arg4 >= 100000000, 0);
        assert!(0x2::table::contains<address, User>(v1, v0), 1);
        let v4 = 0x2::table::borrow_mut<address, User>(v1, v0);
        let v5 = arg0.pay_ratio;
        assert!(v5 >= 0 && v5 <= 100, 0);
        let v6 = 0;
        if (v5 > 0) {
            let v7 = 0x2::coin::value<T0>(&arg1);
            v6 = v7;
            assert!(v7 >= 0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::get_sui_amount(arg3, arg4 * (v5 as u64) / 100), 2);
            depositSui<T0>(v2, arg1, arg5, arg6, arg7, arg8, arg9);
            v3.total_sui_invested_amount = v3.total_sui_invested_amount + v7;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let v8 = 100 - v5;
        let v9 = 0;
        if (v8 > 0) {
            let v10 = 0x2::coin::value<T1>(&arg2);
            v9 = v10;
            assert!(v10 >= 0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::get_pre_amount(arg3, arg4 * (v8 as u64) / 100), 2);
            0x2::balance::join<T1>(&mut arg0.pre_balance, 0x2::coin::into_balance<T1>(arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
        };
        let v11 = calc_static_power(arg4);
        let v12 = Order{
            id           : (0x1::vector::length<Order>(&v4.orders) as u64) + 1,
            start_time   : 0x2::clock::timestamp_ms(arg9),
            amount       : arg4,
            rate         : v5,
            sui_amount   : v6,
            pre_amount   : v9,
            static_power : v11,
            status       : 0,
        };
        0x1::vector::push_back<Order>(&mut v4.orders, v12);
        v4.static_power = v4.static_power + v11;
        v4.underway_power = v4.underway_power + v11;
        v4.join_amount = v4.join_amount + arg4;
        v4.invest_amount = v4.invest_amount + arg4;
        v3.total_invested_amount = v3.total_invested_amount + arg4;
        if (v4.invest_amount == 0 && arg0.up_time < 0x2::clock::timestamp_ms(arg9)) {
            v4.level = calc_equity_level(arg4);
            v4.benefit_expiry = 0x2::clock::timestamp_ms(arg9) + 8640000000;
        };
        update_performance(v1, v0, arg4);
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

    fun release_dynamic_power(arg0: &mut User, arg1: &mut GlobalNetworkData) {
        if (arg0.dynamic_power == 0 || arg0.total_earning >= arg0.static_power) {
            return
        };
        let v0 = arg0.dynamic_power / 500;
        arg0.dynamic_power = arg0.dynamic_power - v0;
        apply_reward(arg0, arg1, v0, false);
    }

    fun release_static_power(arg0: &mut User, arg1: &mut GlobalNetworkData) {
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

    public fun setPayRatio<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 >= 0 && arg1 <= 100, 2);
        arg0.pay_ratio = arg1;
    }

    public fun setUserLevel<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rebot == 0x2::tx_context::sender(arg3), 2);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).level = arg2;
    }

    public entry fun stake<T0>(arg0: &mut Contract<T0>, arg1: &0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::PriceOracle, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
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
        0x2::balance::join<T0>(&mut arg0.pre_balance, 0x2::coin::into_balance<T0>(arg2));
        let v3 = &mut arg0.global_network_data;
        v3.total_cumulative_stake = v3.total_cumulative_stake + v0;
        let v4 = StakeOrder{
            id         : 0x1::vector::length<StakeOrder>(&v2.stake_orders) + 1,
            start_time : 0x2::clock::timestamp_ms(arg4),
            status     : 0,
            cycle      : arg3,
            pre_amount : v0,
            amount     : 0x57a1b6675b23c91604b7f237296d42c3262bf6cfbebb57cc8c38cce7a4844151::price_oracle::get_pre_amount(arg1, v0),
            interest   : 0,
        };
        0x1::vector::push_back<StakeOrder>(&mut v2.stake_orders, v4);
    }

    public entry fun unStake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        let v2 = 0x1::vector::length<StakeOrder>(&v1.stake_orders);
        assert!(v2 > 0 && arg1 <= v2, 1);
        let v3 = 0x1::vector::borrow_mut<StakeOrder>(&mut v1.stake_orders, arg1 - 1);
        assert!(v3.status == 0, 1);
        assert!((0x2::clock::timestamp_ms(arg2) - v3.start_time) / 86400000 >= v3.cycle, 1);
        withdraw_pre<T0>(arg0, v0, v3.pre_amount, arg3);
        0x1::vector::borrow_mut<StakeOrder>(&mut 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0).stake_orders, arg1 - 1).status = 1;
    }

    fun update_dynamic_power(arg0: &mut 0x2::table::Table<address, User>, arg1: address, arg2: u64) {
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

    public fun viewSui<T0, T1>(arg0: &Contract<T1>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = &arg0.vault;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v0.sui_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v0.account_cap)) as u64))
    }

    fun withdrawSui<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg6, arg7, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap), arg8)
    }

    fun withdraw_pre<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.pre_balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pre_balance, arg2), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

