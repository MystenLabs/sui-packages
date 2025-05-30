module 0x29d1af191e304e6c0a5ff81e7ec763ac5ba18e32a5bbd2228bf4757f6e08de69::newapp {
    struct User has store {
        id: 0x2::object::UID,
        inviter: 0x1::option::Option<address>,
        invitees: vector<address>,
        total_revenue: u64,
        total_amount: u64,
        performance: u64,
        total_static_power: u64,
        total_dynamic_power: u64,
        level: u8,
        appoint_level: u8,
        balance: u64,
        underway_power: u64,
        underway_amount: u64,
        daily_static_revenue: u64,
        level3_count: u32,
        level4_count: u32,
        level5_count: u32,
        level6_count: u32,
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
        sui_balace: 0x2::balance::Balance<0x2::sui::SUI>,
        yy_balace: 0x2::balance::Balance<T0>,
        withdraw_charges: u8,
        withdraw_ratio: u8,
        pay_ratio: u8,
        prize_pool: PrizePool,
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

    struct NetworkStatistics has copy, drop {
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

    public entry fun bindInviter<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        assert!(0x2::table::contains<address, User>(v0, arg1), 0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, User>(v0, v1), 0);
        let v2 = User{
            id                   : 0x2::object::new(arg2),
            inviter              : 0x1::option::some<address>(arg1),
            invitees             : vector[],
            total_revenue        : 0,
            total_amount         : 0,
            performance          : 0,
            total_static_power   : 0,
            total_dynamic_power  : 0,
            level                : 0,
            appoint_level        : 0,
            balance              : 0,
            underway_power       : 0,
            underway_amount      : 0,
            daily_static_revenue : 0,
            level3_count         : 0,
            level4_count         : 0,
            level5_count         : 0,
            level6_count         : 0,
            orders               : 0x1::vector::empty<Order>(),
            stake_orders         : 0x1::vector::empty<StakeOrder>(),
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

    fun calc_yu_li_bao(arg0: &vector<StakeOrder>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<StakeOrder>(arg0)) {
            let v2 = 0x1::vector::borrow<StakeOrder>(arg0, v1);
            if (v2.status == 0) {
                v0 = v0 + v2.amount;
                continue
            };
        };
        v0
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
            if (check_lower_level(0x2::table::borrow<address, User>(arg1, *0x1::vector::borrow<address>(&arg0.invitees, v0)), arg1, arg3)) {
                let v2 = v1 + 1;
                v1 = v2;
                if (v2 == arg2) {
                    return true
                };
            };
            v0 = v0 + 1;
        };
        false
    }

    fun clac_level_diff(arg0: &mut 0x2::table::Table<address, User>, arg1: address, arg2: u64) {
    }

    public entry fun distribution<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        let v1 = &mut arg0.user_list;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = 0x2::table::borrow_mut<address, User>(v0, *0x1::vector::borrow<address>(v1, v2));
            let v4 = v3.total_dynamic_power / 500;
            if (v4 > 0) {
                v3.total_dynamic_power = v3.total_dynamic_power - v4;
            };
            let v5 = v3.underway_power / 500 + v4;
            let v6 = v3.total_static_power - v3.total_revenue;
            let v7 = if (v6 > v5) {
                v5
            } else {
                v6
            };
            v3.balance = v3.balance + v7;
            v3.total_revenue = v3.total_revenue + v7;
            handler_out(v3);
        };
    }

    public entry fun dividend<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.prize_pool;
        if (v0.level5_gross > 0) {
            let v1 = v0.level5_gross * (v0.level5_ratio as u64) / 100;
            v0.level5_issued = v0.level5_issued + v1;
            let v2 = v0.level5_gross - v1;
            if (v2 > 0) {
                v0.market_gross = v0.market_gross + v2;
            };
            v0.level5_gross = 0;
        };
        if (v0.level6_gross > 0) {
            let v3 = v0.level6_gross * (v0.level6_ratio as u64) / 100;
            v0.level6_issued = v0.level6_issued + v3;
            let v4 = v0.level6_gross - v3;
            if (v4 > 0) {
                v0.market_gross = v0.market_gross + v4;
            };
            v0.level6_gross = 0;
        };
        if (v0.level7_gross > 0) {
            let v5 = v0.level7_gross * (v0.level7_ratio as u64) / 100;
            v0.level7_issued = v0.level7_issued + v5;
            let v6 = v0.level7_gross - v5;
            if (v6 > 0) {
                v0.market_gross = v0.market_gross + v6;
            };
            v0.level7_gross = 0;
        };
    }

    public fun get_ShareList<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : vector<Share> {
        let v0 = &mut arg0.users;
        let v1 = 0x2::table::borrow<address, User>(v0, 0x2::tx_context::sender(arg1));
        let v2 = 0;
        let v3 = 0x1::vector::empty<Share>();
        while (v2 < 0x1::vector::length<address>(&v1.invitees)) {
            let v4 = 0x1::vector::borrow<address>(&v1.invitees, v2);
            let v5 = 0x2::table::borrow<address, User>(v0, *v4);
            let (v6, v7) = calc_amount(v0, v5);
            let (v8, v9, v10) = calc_all_amount(v0, v5);
            let v11 = Share{
                addr                      : *v4,
                max_level                 : v10,
                total_amount              : v5.total_amount,
                underway_amount           : v5.underway_amount,
                direct_total_amount       : v6,
                direct_underway_amount    : v7,
                community_total_amount    : v8,
                community_underway_amount : v9,
            };
            0x1::vector::push_back<Share>(&mut v3, v11);
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

    public fun get_net_data<T0>(arg0: &Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : NetworkStatistics {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.user_list)) {
            let v10 = 0x2::table::borrow<address, User>(&arg0.users, *0x1::vector::borrow<address>(&arg0.user_list, v0));
            v1 = v1 + v10.underway_power;
            v2 = v2 + v10.total_dynamic_power;
            v3 = v3 + v10.total_static_power;
            v4 = v4 + v10.total_dynamic_power;
            v5 = v5 + v10.total_amount;
            v6 = v6 + v10.underway_power;
            v7 = v7 + v10.balance;
            v8 = v8 + calc_yu_li_bao(&v10.stake_orders);
            v9 = v9 + v10.underway_amount;
            v0 = v0 + 1;
        };
        NetworkStatistics{
            total_static_power_invested  : v1,
            total_dynamic_power_invested : v2,
            total_static_power_released  : v3,
            total_dynamic_power_released : v4,
            total_invested_amount        : v5,
            total_withdrawn_amount       : v6,
            total_user_balance           : v7,
            yu_li_bao_unredeemed_amount  : v8,
            total_asset_invested         : v9,
        }
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

    public fun get_stake_orders<T0>(arg0: &Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : vector<StakeOrder> {
        let v0 = 0x2::table::borrow<address, User>(&arg0.users, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<StakeOrder>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeOrder>(&v0.stake_orders)) {
            let v3 = 0x1::vector::borrow<StakeOrder>(&v0.stake_orders, v2);
            if (v3.status == 0) {
                let v4 = (0x2::tx_context::epoch_timestamp_ms(arg1) - v3.start_time) / 86400;
                let v5 = StakeOrder{
                    id         : v3.id,
                    start_time : v3.start_time,
                    status     : v3.status,
                    amount     : v3.amount,
                    interest   : v3.amount * get_daily_interest_rate(v4) * v4 / 10000,
                };
                0x1::vector::push_back<StakeOrder>(&mut v1, v5);
            } else {
                let v6 = StakeOrder{
                    id         : v3.id,
                    start_time : v3.start_time,
                    status     : v3.status,
                    amount     : v3.amount,
                    interest   : v3.interest,
                };
                0x1::vector::push_back<StakeOrder>(&mut v1, v6);
            };
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

    fun handler_out(arg0: &mut User) {
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<Order>(&arg0.orders) > v0) {
            let v2 = 0x1::vector::borrow_mut<Order>(&mut arg0.orders, v0);
            let v3 = v1 + v2.static_power;
            v1 = v3;
            if (arg0.total_revenue >= v3) {
                v2.status = 1;
                arg0.underway_amount = arg0.underway_amount - v2.amount;
                arg0.underway_power = arg0.underway_power - v2.static_power;
                continue
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{
            id    : 0x2::object::new(arg0),
            admin : @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797,
        };
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_contract<T0>(arg0: &Owner, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PrizePool{
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
        let v1 = Contract<T0>{
            id               : 0x2::object::new(arg1),
            users            : 0x2::table::new<address, User>(arg1),
            user_list        : vector[],
            sui_balace       : 0x2::balance::zero<0x2::sui::SUI>(),
            yy_balace        : 0x2::balance::zero<T0>(),
            withdraw_charges : 10,
            withdraw_ratio   : 80,
            pay_ratio        : 100,
            prize_pool       : v0,
        };
        let v2 = User{
            id                   : 0x2::object::new(arg1),
            inviter              : 0x1::option::none<address>(),
            invitees             : vector[],
            total_revenue        : 0,
            total_amount         : 0,
            performance          : 0,
            total_static_power   : 0,
            total_dynamic_power  : 0,
            level                : 0,
            appoint_level        : 0,
            balance              : 0,
            underway_power       : 0,
            underway_amount      : 0,
            daily_static_revenue : 0,
            level3_count         : 0,
            level4_count         : 0,
            level5_count         : 0,
            level6_count         : 0,
            orders               : 0x1::vector::empty<Order>(),
            stake_orders         : 0x1::vector::empty<StakeOrder>(),
        };
        0x1::vector::push_back<address>(&mut v1.user_list, @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797);
        0x2::table::add<address, User>(&mut v1.users, @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797, v2);
        0x2::transfer::share_object<Contract<T0>>(v1);
    }

    public fun preSwap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, true, true, arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public entry fun purchase<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg0.users;
        assert!(arg4 >= 0 || arg4 <= 100, 3);
        assert!(0x2::table::contains<address, User>(v1, v0), 4);
        let v2 = 0x2::table::borrow_mut<address, User>(v1, v0);
        let v3 = if (arg3 >= 1000) {
            arg3 * 4
        } else if (arg3 >= 500) {
            arg3 * 3
        } else if (arg3 >= 100) {
            arg3 * 2
        } else {
            0
        };
        v2.total_amount = v2.total_amount + arg3;
        v2.total_static_power = v2.total_static_power + v3;
        v2.underway_power = v2.underway_power + v3;
        v2.underway_amount = v2.underway_amount + arg3;
        let v4 = 0x2::coin::value<T0>(&arg1);
        let v5 = 0x2::coin::value<T1>(&arg2);
        0x2::balance::join<T1>(&mut arg0.yy_balace, 0x2::coin::into_balance<T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v6 = Order{
            id           : (0x1::vector::length<Order>(&v2.orders) as u64) + 1,
            start_time   : 0x2::clock::timestamp_ms(arg5),
            amount       : arg3,
            rate         : arg4,
            sui_amount   : v4,
            yy_amount    : v5,
            static_power : v3,
            status       : 0,
        };
        0x1::vector::push_back<Order>(&mut v2.orders, v6);
        update_dynamic_power(v1, v0, arg3);
        update_performance(v1, v0, arg3);
        clac_level_diff(v1, v0, arg3);
        0x29d1af191e304e6c0a5ff81e7ec763ac5ba18e32a5bbd2228bf4757f6e08de69::event::purchase_event(v0, arg3, v3, v4, v5);
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
        v0.balance = v0.balance - arg1;
        let v1 = StakeOrder{
            id         : 0x1::vector::length<StakeOrder>(&v0.stake_orders) + 1,
            start_time : 0x2::clock::timestamp_ms(arg2),
            status     : 0,
            amount     : arg1,
            interest   : 0,
        };
        0x1::vector::push_back<StakeOrder>(&mut v0.stake_orders, v1);
    }

    public fun transter_owner(arg0: Owner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Owner>(arg0, arg1);
    }

    public entry fun unstake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        let v1 = 0x1::vector::length<StakeOrder>(&v0.stake_orders);
        assert!(v1 > 0 && arg1 <= v1, 1);
        let v2 = 0x1::vector::borrow_mut<StakeOrder>(&mut v0.stake_orders, arg1 - 1);
        assert!(v2.status == 0, 1);
        let v3 = (0x2::clock::timestamp_ms(arg2) - v2.start_time) / 600000;
        let v4 = v2.amount * get_daily_interest_rate(v3) * v3 / 10000;
        v2.interest = v4;
        v2.status = 1;
        v0.balance = v0.balance + v4 + v2.amount;
    }

    fun update_dynamic_power(arg0: &mut 0x2::table::Table<address, User>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg0, arg1).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 10) {
            let v2 = 0x1::option::extract<address>(&mut v0);
            let v3 = 0x2::table::borrow_mut<address, User>(arg0, v2);
            let v4 = &v1;
            let v5 = if (*v4 == 1) {
                let v6 = calc_effective_user(arg0, v2);
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
                if (calc_effective_user(arg0, v2) >= 2) {
                    40
                } else {
                    0
                }
            } else if (*v4 == 3) {
                if (calc_effective_user(arg0, v2) >= 3) {
                    30
                } else {
                    0
                }
            } else if (*v4 == 4) {
                if (calc_effective_user(arg0, v2) >= 4) {
                    20
                } else {
                    0
                }
            } else if (*v4 == 5) {
                if (calc_effective_user(arg0, v2) >= 5) {
                    10
                } else {
                    0
                }
            } else if (*v4 == 6) {
                if (calc_effective_user(arg0, v2) >= 6) {
                    10
                } else {
                    0
                }
            } else if (*v4 == 7) {
                if (calc_effective_user(arg0, v2) >= 7) {
                    10
                } else {
                    0
                }
            } else if (*v4 == 8) {
                if (calc_effective_user(arg0, v2) >= 8) {
                    20
                } else {
                    0
                }
            } else if (*v4 == 9) {
                if (calc_effective_user(arg0, v2) >= 9) {
                    30
                } else {
                    0
                }
            } else if (*v4 == 10) {
                if (calc_effective_user(arg0, v2) >= 10) {
                    40
                } else {
                    0
                }
            } else {
                0
            };
            if (v5 > 0) {
                v3.total_dynamic_power = v3.total_dynamic_power + arg2 * v5 / 100;
            };
            v1 = v1 + 1;
            v0 = v3.inviter;
        };
    }

    fun update_performance(arg0: &mut 0x2::table::Table<address, User>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, User>(arg0, arg1).inviter;
        let v1 = 1;
        while (0x1::option::is_some<address>(&v0) && v1 <= 30) {
            let v2 = 0x2::table::borrow_mut<address, User>(arg0, 0x1::option::extract<address>(&mut v0));
            v2.performance = v2.performance + arg2;
            v1 = v1 + 1;
            v0 = v2.inviter;
        };
    }

    fun update_user_level(arg0: &mut 0x2::table::Table<address, User>, arg1: &mut User, arg2: address) {
        let v0 = calc_all_underway_amount(arg0, arg2);
        let v1 = if (v0 >= 100000) {
            3
        } else if (v0 >= 50000) {
            2
        } else if (v0 >= 10000) {
            1
        } else {
            0
        };
        let v2 = v1;
        if (v1 == 3) {
            if (check_user_up_level(arg1, arg0, 2, 3)) {
                v2 = 4;
            };
        };
        if (v2 == 4) {
            if (check_user_up_level(arg1, arg0, 2, 4)) {
                v2 = 5;
            };
        };
        if (v2 == 5) {
            if (check_user_up_level(arg1, arg0, 2, 5)) {
                v2 = 6;
            };
        };
        if (v2 == 6) {
            if (check_user_up_level(arg1, arg0, 3, 6)) {
                v2 = 7;
            };
        };
        arg1.level = v2;
    }

    public entry fun withdraw<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg2));
        assert!(v0.balance >= arg1, 1);
        v0.balance = v0.balance - arg1;
        let v1 = arg1 - arg1 * (arg0.withdraw_charges as u64) / 100;
        let v2 = (v1 - v1 * (arg0.withdraw_ratio as u64) / 100) / 2;
        let v3 = &mut arg0.prize_pool;
        v3.level5_gross = v3.level5_gross + v2 * 50 / 100;
        v3.level6_gross = v3.level5_gross + v2 * 30 / 100;
        v3.level7_gross = v3.level5_gross + v2 * 20 / 100;
    }

    // decompiled from Move bytecode v6
}

