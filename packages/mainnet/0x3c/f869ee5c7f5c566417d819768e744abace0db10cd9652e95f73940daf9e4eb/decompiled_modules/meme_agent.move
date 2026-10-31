module 0x3cf869ee5c7f5c566417d819768e744abace0db10cd9652e95f73940daf9e4eb::meme_agent {
    struct MemeAgent has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        plans_of: 0x2::table::Table<address, vector<0x2::object::ID>>,
        count: u64,
    }

    struct Position has copy, drop, store {
        qty: u64,
        cost: u64,
    }

    struct Held has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct LabelKey has copy, drop, store {
        owner: address,
        name: 0x1::string::String,
    }

    struct Plan has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        paused: bool,
        max_trade: u64,
        slippage_bps: u64,
        book: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Position>,
        trades: u64,
        allowance_name: 0x1::string::String,
    }

    struct Ticket {
        plan: 0x2::object::ID,
        side: u8,
        coin: 0x1::type_name::TypeName,
        amount_in: u64,
        price: u256,
        pool: 0x2::object::ID,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Created has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        agent: address,
        max_trade: u64,
        slippage_bps: u64,
    }

    struct Configured has copy, drop {
        plan: 0x2::object::ID,
        agent: address,
        paused: bool,
        max_trade: u64,
        slippage_bps: u64,
    }

    struct Traded has copy, drop {
        plan: 0x2::object::ID,
        side: u8,
        coin: 0x1::type_name::TypeName,
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        price: u256,
    }

    struct Withdrawn has copy, drop {
        plan: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun agent(arg0: &Plan) : address {
        arg0.agent
    }

    public fun allowance_name(arg0: &Plan) : 0x1::string::String {
        arg0.allowance_name
    }

    fun assert_bound(arg0: &Plan, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>) {
        let v0 = 0x2::allowance::allowance_settings<0x2::balance::Balance<0x2::sui::SUI>>(arg1);
        assert!(0x2::allowance::funder(v0) == arg0.owner, 15);
        let v1 = 0x2::allowance::spender(v0);
        assert!(0x1::option::contains<address>(&v1, &arg0.agent), 16);
        assert!(0x2::allowance::name(v0) == &arg0.allowance_name, 19);
    }

    fun assert_can_trade<T0>(arg0: &Plan, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.agent, 2);
        assert!(!arg0.paused, 3);
        assert!(key<T0>() != key<0x2::sui::SUI>(), 18);
    }

    fun assert_owner(arg0: &Plan, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    public(friend) fun begin_buy_at<T0>(arg0: &Plan, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg3: 0x2::object::ID, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Ticket) {
        assert_can_trade<T0>(arg0, arg6);
        assert!(arg4 > 0, 7);
        assert_bound(arg0, arg1);
        let v0 = 0x2::allowance::app_balance_spend<0x2::sui::SUI, MemeAgent>(arg1, 0x2::allowance::spend_permit<MemeAgent>(0x1::internal::permit<MemeAgent>()), arg2, arg5, arg6);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        assert!(v1 > 0, 6);
        assert!(v1 <= arg0.max_trade, 4);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        assert!(v2 > 0, 6);
        let v3 = Ticket{
            plan      : 0x2::object::id<Plan>(arg0),
            side      : 0,
            coin      : key<T0>(),
            amount_in : v2,
            price     : arg4,
            pool      : arg3,
            fee       : 0x2::balance::split<0x2::sui::SUI>(&mut v0, fee_of(v1)),
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(v0, arg6), v3)
    }

    public fun begin_buy_bluefin<T0, T1, T2>(arg0: &mut Plan, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Ticket) {
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T1, T2>(arg3) > 0, 7);
        begin_buy_at<T0>(arg0, arg1, arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg3), price_from_sqrt<T0, T1, T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg3)), arg4, arg5)
    }

    public fun begin_buy_cetus<T0, T1, T2>(arg0: &mut Plan, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Ticket) {
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T1, T2>(arg3), 9);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T2>(arg3) > 0, 7);
        begin_buy_at<T0>(arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3), price_from_sqrt<T0, T1, T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg3)), arg4, arg5)
    }

    public(friend) fun begin_sell_at<T0>(arg0: &mut Plan, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg2: u64, arg3: 0x2::object::ID, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        assert_can_trade<T0>(arg0, arg6);
        assert!(arg4 > 0, 7);
        assert_bound(arg0, arg1);
        let v0 = 0x2::allowance::expiration_timestamp_ms(0x2::allowance::allowance_settings<0x2::balance::Balance<0x2::sui::SUI>>(arg1));
        assert!(0x1::option::is_none<u64>(&v0) || 0x2::clock::timestamp_ms(arg5) < *0x1::option::borrow<u64>(&v0), 20);
        assert!(arg2 > 0, 6);
        let v1 = key<T0>();
        let v2 = Held{coin: v1};
        assert!(0x2::dynamic_field::exists<Held>(&arg0.id, v2), 13);
        let v3 = 0x2::dynamic_field::borrow_mut<Held, 0x2::balance::Balance<T0>>(&mut arg0.id, v2);
        assert!(arg2 <= 0x2::balance::value<T0>(v3), 13);
        let v4 = 0x2::balance::split<T0>(v3, arg2);
        let v5 = Ticket{
            plan      : 0x2::object::id<Plan>(arg0),
            side      : 1,
            coin      : v1,
            amount_in : arg2,
            price     : arg4,
            pool      : arg3,
            fee       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        (0x2::coin::from_balance<T0>(v4, arg6), v5)
    }

    public fun begin_sell_bluefin<T0, T1, T2>(arg0: &mut Plan, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg2: u64, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T1, T2>(arg3) > 0, 7);
        begin_sell_at<T0>(arg0, arg1, arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg3), price_from_sqrt<T0, T1, T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg3)), arg4, arg5)
    }

    public fun begin_sell_cetus<T0, T1, T2>(arg0: &mut Plan, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket) {
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T1, T2>(arg3), 9);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T2>(arg3) > 0, 7);
        begin_sell_at<T0>(arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg3), price_from_sqrt<T0, T1, T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg3)), arg4, arg5)
    }

    fun configured(arg0: &Plan) {
        let v0 = Configured{
            plan         : 0x2::object::id<Plan>(arg0),
            agent        : arg0.agent,
            paused       : arg0.paused,
            max_trade    : arg0.max_trade,
            slippage_bps : arg0.slippage_bps,
        };
        0x2::event::emit<Configured>(v0);
    }

    public fun count(arg0: &Registry) : u64 {
        arg0.count
    }

    public fun create(arg0: &mut Registry, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) : Plan {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1 != @0x0 && arg1 != v0, 16);
        assert!(arg2 > 0, 6);
        assert!(arg3 <= 1500, 5);
        let v1 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<0x2::sui::SUI>>(&arg4);
        assert!(0x2::allowance::funder(v1) == v0, 15);
        let v2 = 0x2::allowance::spender(v1);
        assert!(0x1::option::contains<address>(&v2, &arg1), 16);
        let v3 = 0x2::allowance::rate_limit(v1);
        let v4 = if (0x1::option::is_some<0x2::allowance::RateLimit>(&v3)) {
            let v5 = 0x2::allowance::expiration_timestamp_ms(v1);
            0x1::option::is_some<u64>(&v5)
        } else {
            false
        };
        assert!(v4, 17);
        let v6 = *0x2::allowance::name(v1);
        let v7 = LabelKey{
            owner : v0,
            name  : v6,
        };
        assert!(!0x2::dynamic_field::exists<LabelKey>(&arg0.id, v7), 22);
        0x2::dynamic_field::add<LabelKey, bool>(&mut arg0.id, v7, true);
        0x2::allowance::issue<0x2::balance::Balance<0x2::sui::SUI>, MemeAgent>(arg4, 0x2::allowance::settings_permit<MemeAgent>(0x1::internal::permit<MemeAgent>()), arg5);
        let v8 = Plan{
            id             : 0x2::object::new(arg5),
            owner          : v0,
            agent          : arg1,
            paused         : false,
            max_trade      : arg2,
            slippage_bps   : arg3,
            book           : 0x2::vec_map::empty<0x1::type_name::TypeName, Position>(),
            trades         : 0,
            allowance_name : v6,
        };
        let v9 = 0x2::object::id<Plan>(&v8);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.plans_of, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.plans_of, v0), v9);
        } else {
            let v10 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v9);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.plans_of, v0, v10);
        };
        arg0.count = arg0.count + 1;
        let v11 = Created{
            plan         : v9,
            owner        : v0,
            agent        : arg1,
            max_trade    : arg2,
            slippage_bps : arg3,
        };
        0x2::event::emit<Created>(v11);
        v8
    }

    fun drop_if_empty<T0>(arg0: &mut Plan) {
        let v0 = key<T0>();
        let v1 = Held{coin: v0};
        if (0x2::dynamic_field::exists<Held>(&arg0.id, v1)) {
            if (0x2::balance::value<T0>(0x2::dynamic_field::borrow<Held, 0x2::balance::Balance<T0>>(&arg0.id, v1)) == 0) {
                0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<Held, 0x2::balance::Balance<T0>>(&mut arg0.id, v1));
                if (0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &v0)) {
                    let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, Position>(&mut arg0.book, &v0);
                };
            };
        };
    }

    public fun end_buy<T0>(arg0: &mut Plan, arg1: Ticket, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan      : v0,
            side      : v1,
            coin      : v2,
            amount_in : v3,
            price     : v4,
            pool      : v5,
            fee       : v6,
        } = arg1;
        let v7 = v6;
        let v8 = if (v0 == 0x2::object::id<Plan>(arg0)) {
            if (v1 == 0) {
                v2 == key<T0>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 11);
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v9 < v3, 12);
        let v10 = v3 - v9;
        let v11 = 0x2::coin::value<T0>(&arg2);
        assert!(v11 > 0, 21);
        assert!(v11 >= min_bought(v10, v4, arg0.slippage_bps), 10);
        let v12 = 0x1::u64::min(fee_of(v10), 0x2::balance::value<0x2::sui::SUI>(&v7));
        if (v12 > 0) {
            0x2::coin::send_funds<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v7, v12), arg4), @0x99f97251af2d072fc492316ae30de3ab5639beb09073509d54bf49197513b4);
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v7, arg4));
        give<0x2::sui::SUI>(arg0, arg3);
        hold<T0>(arg0, 0x2::coin::into_balance<T0>(arg2), v10 + v12);
        arg0.trades = arg0.trades + 1;
        let v13 = Traded{
            plan       : v0,
            side       : v1,
            coin       : v2,
            pool       : v5,
            amount_in  : v10,
            amount_out : v11,
            fee        : v12,
            price      : v4,
        };
        0x2::event::emit<Traded>(v13);
    }

    public fun end_sell<T0>(arg0: &mut Plan, arg1: Ticket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan      : v0,
            side      : v1,
            coin      : v2,
            amount_in : v3,
            price     : v4,
            pool      : v5,
            fee       : v6,
        } = arg1;
        let v7 = if (v0 == 0x2::object::id<Plan>(arg0)) {
            if (v1 == 1) {
                v2 == key<T0>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 11);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        let v8 = 0x2::coin::value<T0>(&arg3);
        assert!(v8 < v3, 12);
        let v9 = v3 - v8;
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v10 > 0, 21);
        assert!(v10 >= min_sold(v9, v4, arg0.slippage_bps), 10);
        let v11 = fee_of(v10);
        if (v11 > 0) {
            0x2::coin::send_funds<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v11, arg4), @0x99f97251af2d072fc492316ae30de3ab5639beb09073509d54bf49197513b4);
        };
        give<0x2::sui::SUI>(arg0, arg2);
        let v12 = Held{coin: v2};
        if (0x2::dynamic_field::exists<Held>(&arg0.id, v12)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<Held, 0x2::balance::Balance<T0>>(&mut arg0.id, v12), 0x2::coin::into_balance<T0>(arg3));
        } else {
            0x2::dynamic_field::add<Held, 0x2::balance::Balance<T0>>(&mut arg0.id, v12, 0x2::coin::into_balance<T0>(arg3));
        };
        reduce_book(arg0, v2, v9);
        drop_if_empty<T0>(arg0);
        arg0.trades = arg0.trades + 1;
        let v13 = Traded{
            plan       : v0,
            side       : v1,
            coin       : v2,
            pool       : v5,
            amount_in  : v9,
            amount_out : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            fee        : v11,
            price      : v4,
        };
        0x2::event::emit<Traded>(v13);
    }

    public fun fee_bps() : u64 {
        50
    }

    public(friend) fun fee_of(arg0: u64) : u64 {
        ((((arg0 as u128) * (50 as u128) + 9999) / 10000) as u64)
    }

    fun give<T0>(arg0: &Plan, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::coin::send_funds<T0>(arg1, arg0.owner);
        };
    }

    fun hold<T0>(arg0: &mut Plan, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        let v0 = key<T0>();
        let v1 = Held{coin: v0};
        if (0x2::dynamic_field::exists<Held>(&arg0.id, v1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<Held, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg1);
        } else {
            0x2::dynamic_field::add<Held, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, arg1);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &v0)) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Position>(&mut arg0.book, &v0);
            v2.qty = v2.qty + 0x2::balance::value<T0>(&arg1);
            v2.cost = v2.cost + arg2;
        } else {
            assert!(0x2::vec_map::length<0x1::type_name::TypeName, Position>(&arg0.book) < 32, 14);
            let v3 = Position{
                qty  : 0x2::balance::value<T0>(&arg1),
                cost : arg2,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Position>(&mut arg0.book, v0, v3);
        };
    }

    public fun holdings(arg0: &Plan) : (vector<0x1::type_name::TypeName>, vector<Position>) {
        0x2::vec_map::into_keys_values<0x1::type_name::TypeName, Position>(arg0.book)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg0),
            plans_of : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            count    : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    public fun max_trade(arg0: &Plan) : u64 {
        arg0.max_trade
    }

    public(friend) fun min_bought(arg0: u64, arg1: u256, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * 1000000000000000000 / arg1 * (10000 - (arg2 as u256)) / 10000;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public(friend) fun min_sold(arg0: u64, arg1: u256, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * arg1 / 1000000000000000000 * (10000 - (arg2 as u256)) / 10000;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun owner(arg0: &Plan) : address {
        arg0.owner
    }

    public fun pause(arg0: &mut Plan, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.paused = true;
        configured(arg0);
    }

    public fun paused(arg0: &Plan) : bool {
        arg0.paused
    }

    public fun plans_of(arg0: &Registry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.plans_of, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.plans_of, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun position<T0>(arg0: &Plan) : (u64, u64) {
        let v0 = key<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &v0)) {
            let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, Position>(&arg0.book, &v0);
            (v3.qty, v3.cost)
        } else {
            (0, 0)
        }
    }

    public fun position_cost(arg0: &Position) : u64 {
        arg0.cost
    }

    public fun position_qty(arg0: &Position) : u64 {
        arg0.qty
    }

    public(friend) fun price_from_sqrt<T0, T1, T2>(arg0: u128) : u256 {
        let v0 = key<T0>();
        let v1 = key<0x2::sui::SUI>();
        assert!(v0 != v1, 18);
        let v2 = key<T1>();
        let v3 = key<T2>();
        let v4 = (arg0 as u256);
        assert!(v4 > 0, 7);
        let v5 = if (v2 == v0 && v3 == v1) {
            v4 * v4 * 1000000000000000000 >> 128
        } else {
            assert!(v2 == v1 && v3 == v0, 8);
            (1000000000000000000 << 128) / v4 * v4
        };
        assert!(v5 > 0, 7);
        v5
    }

    fun reduce_book(arg0: &mut Plan, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &arg1)) {
            return
        };
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Position>(&mut arg0.book, &arg1);
        if (arg2 >= v0.qty) {
            v0.qty = 0;
            v0.cost = 0;
        } else {
            v0.cost = v0.cost - (((v0.cost as u128) * (arg2 as u128) / (v0.qty as u128)) as u64);
            v0.qty = v0.qty - arg2;
        };
    }

    public fun repoint(arg0: &Plan, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<0x2::sui::SUI>>(arg1)) == arg0.owner, 15);
        assert!(0x2::allowance::name(0x2::allowance::allowance_settings<0x2::balance::Balance<0x2::sui::SUI>>(arg1)) == &arg0.allowance_name, 19);
        0x2::allowance::rotate_spender<0x2::balance::Balance<0x2::sui::SUI>, MemeAgent>(arg1, 0x2::allowance::settings_permit<MemeAgent>(0x1::internal::permit<MemeAgent>()), arg0.agent);
    }

    public fun resume(arg0: &mut Plan, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.paused = false;
        configured(arg0);
    }

    public fun set_agent(arg0: &mut Plan, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0 && arg1 != arg0.owner, 16);
        arg0.agent = arg1;
        configured(arg0);
    }

    public fun set_limits(arg0: &mut Plan, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert!(arg1 > 0, 6);
        assert!(arg2 <= 1500, 5);
        arg0.max_trade = arg1;
        arg0.slippage_bps = arg2;
        configured(arg0);
    }

    public fun share(arg0: Plan) {
        0x2::transfer::share_object<Plan>(arg0);
    }

    public fun slippage_bps(arg0: &Plan) : u64 {
        arg0.slippage_bps
    }

    public fun trades(arg0: &Plan) : u64 {
        arg0.trades
    }

    public fun withdraw<T0>(arg0: &mut Plan, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = key<T0>();
        let v1 = Held{coin: v0};
        if (!0x2::dynamic_field::exists<Held>(&arg0.id, v1)) {
            return
        };
        let v2 = 0x2::dynamic_field::remove<Held, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Position>(&arg0.book, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, Position>(&mut arg0.book, &v0);
        };
        give<T0>(arg0, 0x2::coin::from_balance<T0>(v2, arg1));
        let v5 = Withdrawn{
            plan   : 0x2::object::id<Plan>(arg0),
            coin   : v0,
            amount : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<Withdrawn>(v5);
    }

    // decompiled from Move bytecode v7
}

