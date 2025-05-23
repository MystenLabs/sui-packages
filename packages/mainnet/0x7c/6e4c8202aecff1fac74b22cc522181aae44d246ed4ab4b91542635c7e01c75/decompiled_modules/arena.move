module 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::arena {
    struct ArenaRequest<phantom T0> {
        arena_type: u8,
    }

    struct ArenaHost<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        current_week_round: u64,
        current_month_round: u64,
    }

    struct Result has store {
        trader: 0x2::object::ID,
        result: u128,
    }

    struct Arena<phantom T0> has key {
        id: 0x2::object::UID,
        arena_type: u8,
        start_time: u64,
        attend_duration: u64,
        invest_duration: u64,
        end_time: u64,
        funds: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        traders: vector<0x2::object::ID>,
        result: 0x2::table::Table<u64, Result>,
        is_rank_claimed: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct Certificate has store {
        arena: 0x2::object::ID,
        arena_type: u8,
        end_time: u64,
        rank: u64,
    }

    fun assert_if_arena_type_not_allowed(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 2);
    }

    fun assert_if_fund_is_previous<T0>(arg0: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::Fund<T0>, arg1: &Arena<T0>) {
        assert!(0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::start_time<T0>(arg0) >= arg1.start_time, 6);
    }

    fun assert_if_fund_trader_not_matched<T0>(arg0: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::Fund<T0>, arg1: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::Trader) {
        assert!(0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::trader<T0>(arg0) == 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg1), 5);
    }

    fun assert_if_fund_type_not_matched<T0>(arg0: &Arena<T0>, arg1: u8) {
        assert!(arg0.arena_type == arg1, 1);
    }

    fun assert_if_not_arrive_attend_time<T0>(arg0: &Arena<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.start_time + arg0.attend_duration && 0x2::clock::timestamp_ms(arg1) >= arg0.start_time, 4);
    }

    fun assert_if_over_current_time(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 >= 0x2::clock::timestamp_ms(arg1), 3);
    }

    fun assert_if_trader_already_attend<T0>(arg0: &Arena<T0>, arg1: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::Fund<T0>) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.funds, 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::trader<T0>(arg1)), 0);
    }

    fun assert_if_trader_not_attended_arena<T0>(arg0: &Arena<T0>, arg1: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::Trader) {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.funds, 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg1)), 7);
    }

    public fun attend<T0>(arg0: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::config::GlobalConfig, arg1: ArenaRequest<T0>, arg2: &mut Arena<T0>, arg3: &mut 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::Fund<T0>, arg4: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::Trader, arg5: &0x2::clock::Clock) {
        0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_already_attend<T0>(arg2, arg3);
        assert_if_not_arrive_attend_time<T0>(arg2, arg5);
        assert_if_fund_is_previous<T0>(arg3, arg2);
        assert_if_fund_type_not_matched<T0>(arg2, arg1.arena_type);
        assert_if_fund_trader_not_matched<T0>(arg3, arg4);
        let ArenaRequest {  } = arg1;
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg2.funds, 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::trader<T0>(arg3), *0x2::object::uid_as_inner(0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::id<T0>(arg3)));
        0x2::dynamic_field::add<0x1::type_name::TypeName, Certificate>(0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::id<T0>(arg3), 0x1::type_name::get<Certificate>(), create_certificate<T0>(arg2));
        0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::update_time<T0>(arg3, arg2.start_time + arg2.attend_duration, arg2.start_time + arg2.attend_duration + arg2.invest_duration, arg2.end_time);
        0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::set_is_arena<T0>(arg3, true);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.traders, 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg4));
    }

    public fun challenge<T0>(arg0: &mut Arena<T0>, arg1: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::Fund<T0>, arg2: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::Trader) {
        assert_if_fund_trader_not_matched<T0>(arg1, arg2);
        assert_if_trader_not_attended_arena<T0>(arg0, arg2);
        let v0 = 0;
        if (0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::after_amount<T0>(arg1) > 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::base<T0>(arg1)) {
            v0 = ((0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::after_amount<T0>(arg1) - 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::base<T0>(arg1)) as u128) * 1000000000 / (0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::base<T0>(arg1) as u128);
        };
        if (v0 > 0) {
            let v1 = 0;
            let v2 = 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg2);
            let v3 = v0;
            while (v1 < 3) {
                if (!0x2::table::contains<u64, Result>(&arg0.result, v1)) {
                    let v4 = Result{
                        trader : 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg2),
                        result : v0,
                    };
                    0x2::table::add<u64, Result>(&mut arg0.result, v1, v4);
                };
                let v5 = 0x2::table::remove<u64, Result>(&mut arg0.result, v1);
                if (v5.result < v3) {
                    let v6 = Result{
                        trader : v2,
                        result : v3,
                    };
                    0x2::table::add<u64, Result>(&mut arg0.result, v1, v6);
                    v2 = v5.trader;
                    v3 = v5.result;
                } else {
                    let v7 = Result{
                        trader : v5.trader,
                        result : v5.result,
                    };
                    0x2::table::add<u64, Result>(&mut arg0.result, v1, v7);
                };
                v1 = v1 + 1;
                let Result {
                    trader : _,
                    result : _,
                } = v5;
            };
        };
    }

    public fun claim_rank<T0>(arg0: &mut Arena<T0>, arg1: &mut 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::Fund<T0>, arg2: &mut 0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::Trader) {
        assert_if_fund_trader_not_matched<T0>(arg1, arg2);
        assert_if_trader_not_attended_arena<T0>(arg0, arg2);
        let v0 = 0x2::table::borrow<u64, Result>(&arg0.result, 1);
        let v1 = 0x2::table::borrow<u64, Result>(&arg0.result, 2);
        let v2 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Certificate>(&mut arg0.id, *0x2::object::uid_as_inner(0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::fund::id<T0>(arg1)));
        if (0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg2) == 0x2::table::borrow<u64, Result>(&arg0.result, 0).trader) {
            v2.rank = 1;
        } else if (0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg2) == v0.trader) {
            v2.rank = 2;
        } else if (0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::trader::id(arg2) == v1.trader) {
            v2.rank = 3;
        };
    }

    public fun create_arena<T0>(arg0: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::config::GlobalConfig, arg1: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::config::AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Arena<T0> {
        0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::config::assert_if_version_not_matched(arg0, 1);
        assert_if_arena_type_not_allowed(arg2);
        assert_if_over_current_time(arg3, arg6);
        if (arg2 == 0) {
            Arena<T0>{id: 0x2::object::new(arg7), arena_type: arg2, start_time: arg3, attend_duration: arg4, invest_duration: arg5, end_time: arg3 + 604800000, funds: 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg7), traders: 0x1::vector::empty<0x2::object::ID>(), result: 0x2::table::new<u64, Result>(arg7), is_rank_claimed: 0x2::table::new<0x2::object::ID, bool>(arg7)}
        } else {
            Arena<T0>{id: 0x2::object::new(arg7), arena_type: arg2, start_time: arg3, attend_duration: arg4, invest_duration: arg5, end_time: arg3 + 2592000000, funds: 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg7), traders: 0x1::vector::empty<0x2::object::ID>(), result: 0x2::table::new<u64, Result>(arg7), is_rank_claimed: 0x2::table::new<0x2::object::ID, bool>(arg7)}
        }
    }

    public fun create_arena_request<T0>(arg0: u8) : ArenaRequest<T0> {
        ArenaRequest<T0>{arena_type: arg0}
    }

    fun create_certificate<T0>(arg0: &Arena<T0>) : Certificate {
        Certificate{
            arena      : *0x2::object::uid_as_inner(&arg0.id),
            arena_type : arg0.arena_type,
            end_time   : arg0.end_time,
            rank       : 0,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArenaHost<0x2::sui::SUI>{
            id                  : 0x2::object::new(arg0),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            current_week_round  : 0,
            current_month_round : 0,
        };
        0x2::transfer::share_object<ArenaHost<0x2::sui::SUI>>(v0);
    }

    public entry fun new_arena<T0>(arg0: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::config::GlobalConfig, arg1: &0x7c6e4c8202aecff1fac74b22cc522181aae44d246ed4ab4b91542635c7e01c75::config::AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Arena<T0>>(create_arena<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    // decompiled from Move bytecode v6
}

