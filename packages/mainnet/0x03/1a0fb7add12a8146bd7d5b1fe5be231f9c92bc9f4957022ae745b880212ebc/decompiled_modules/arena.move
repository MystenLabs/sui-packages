module 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::arena {
    struct ArenaRequest<phantom T0> {
        arena_type: u8,
    }

    struct BonusHost<phantom T0> has key {
        id: 0x2::object::UID,
        arena: 0x2::object::ID,
        bonus: 0x2::balance::Balance<T0>,
        is_claimed: 0x2::table::Table<0x2::object::ID, bool>,
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
        is_matched: bool,
    }

    struct NewArena<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        arena_type: u8,
        start_time: u64,
        attend_duration: u64,
        invest_duration: u64,
        end_time: u64,
    }

    struct Attended<phantom T0> has copy, drop {
        arena: 0x2::object::ID,
        fund: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        fund_img: 0x1::string::String,
        trader: 0x2::object::ID,
        trader_fee: u64,
        start_time: u64,
        invest_duration: u64,
        end_time: u64,
        limit_amount: u64,
        expected_roi: u64,
    }

    struct Challenge has copy, drop {
        fund_id: 0x2::object::ID,
        is_success: bool,
    }

    struct ClaimRank has copy, drop {
        trader: 0x2::object::ID,
        arena: 0x2::object::ID,
        fund: 0x2::object::ID,
        rank: u64,
    }

    fun assert_if_already_attend_other_arena<T0>(arg0: &mut 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::Fund<T0>) {
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg0), 0x1::type_name::get<Certificate>()), 8);
    }

    fun assert_if_already_claimed<T0>(arg0: &BonusHost<T0>, arg1: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::Trader) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.is_claimed, 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg1)), 12);
    }

    fun assert_if_arena_type_not_allowed(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 2);
    }

    fun assert_if_arena_type_not_supported(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 4
        };
        assert!(v0, 9);
    }

    fun assert_if_fund_is_previous<T0>(arg0: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::Fund<T0>, arg1: &Arena<T0>) {
        assert!(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::start_time<T0>(arg0) >= arg1.start_time, 5);
    }

    fun assert_if_fund_trader_not_matched<T0>(arg0: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::Fund<T0>, arg1: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::Trader) {
        assert!(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::trader<T0>(arg0) == 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg1), 4);
    }

    fun assert_if_fund_type_not_matched<T0>(arg0: &Arena<T0>, arg1: u8) {
        assert!(arg0.arena_type == arg1, 1);
    }

    fun assert_if_host_not_for_this_arena<T0>(arg0: &BonusHost<T0>, arg1: &Arena<T0>) {
        assert!(arg0.arena == *0x2::object::uid_as_inner(&arg1.id), 11);
    }

    fun assert_if_not_arrive_attend_time<T0>(arg0: &Arena<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time, 3);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.start_time + arg0.attend_duration, 7);
    }

    fun assert_if_not_arrived_end_time<T0>(arg0: &Arena<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.end_time < 0x2::clock::timestamp_ms(arg1), 13);
    }

    fun assert_if_over_end_time<T0>(arg0: &Arena<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.end_time, 10);
    }

    fun assert_if_trader_already_attend<T0>(arg0: &Arena<T0>, arg1: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::Fund<T0>) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.funds, 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::trader<T0>(arg1)), 0);
    }

    fun assert_if_trader_not_attended_arena<T0>(arg0: &Arena<T0>, arg1: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::Trader) {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.funds, 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg1)), 6);
    }

    public fun attend<T0>(arg0: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::GlobalConfig, arg1: ArenaRequest<T0>, arg2: &mut Arena<T0>, arg3: &mut 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::Fund<T0>, arg4: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::Trader, arg5: &0x2::clock::Clock) {
        0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::assert_if_version_not_matched(arg0, 1);
        assert_if_already_attend_other_arena<T0>(arg3);
        assert_if_trader_already_attend<T0>(arg2, arg3);
        assert_if_not_arrive_attend_time<T0>(arg2, arg5);
        assert_if_fund_is_previous<T0>(arg3, arg2);
        assert_if_fund_type_not_matched<T0>(arg2, arg1.arena_type);
        assert_if_fund_trader_not_matched<T0>(arg3, arg4);
        let ArenaRequest {  } = arg1;
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg2.funds, 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::trader<T0>(arg3), *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg3)));
        0x2::dynamic_field::add<0x1::type_name::TypeName, Certificate>(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg3), 0x1::type_name::get<Certificate>(), create_certificate<T0>(arg2));
        0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::update_time<T0>(arg3, arg2.start_time + arg2.attend_duration, arg2.invest_duration, arg2.end_time);
        0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::set_is_arena<T0>(arg3, true);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.traders, 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg4));
        let v0 = Attended<T0>{
            arena           : *0x2::object::uid_as_inner(&arg2.id),
            fund            : *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg3)),
            name            : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::name<T0>(arg3),
            description     : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::description<T0>(arg3),
            fund_img        : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::fund_img<T0>(arg3),
            trader          : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::trader<T0>(arg3),
            trader_fee      : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::trader_fee<T0>(arg3),
            start_time      : arg2.start_time + arg2.attend_duration,
            invest_duration : arg2.invest_duration,
            end_time        : arg2.end_time,
            limit_amount    : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::limit_amount<T0>(arg3),
            expected_roi    : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::expected_roi<T0>(arg3),
        };
        0x2::event::emit<Attended<T0>>(v0);
    }

    public fun challenge<T0>(arg0: &mut Arena<T0>, arg1: &mut 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::Fund<T0>, arg2: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::Trader, arg3: &0x2::clock::Clock) {
        assert_if_fund_trader_not_matched<T0>(arg1, arg2);
        assert_if_trader_not_attended_arena<T0>(arg0, arg2);
        assert_if_over_end_time<T0>(arg0, arg3);
        let v0 = 0;
        let v1 = false;
        if (0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::after_amount<T0>(arg1) > 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::base<T0>(arg1)) {
            v0 = ((0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::after_amount<T0>(arg1) - 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::base<T0>(arg1)) as u128) * 1000000000 / (0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::base<T0>(arg1) as u128);
        };
        if (v0 > 0) {
            let v2 = 0;
            let v3 = 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg2);
            let v4 = v0;
            while (v2 < 3) {
                if (!0x2::table::contains<u64, Result>(&arg0.result, v2)) {
                    let v5 = Result{
                        trader : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg2),
                        result : v0,
                    };
                    0x2::table::add<u64, Result>(&mut arg0.result, v2, v5);
                    v1 = true;
                    break
                };
                let v6 = 0x2::table::remove<u64, Result>(&mut arg0.result, v2);
                if (v6.result < v4) {
                    let v7 = Result{
                        trader : v3,
                        result : v4,
                    };
                    0x2::table::add<u64, Result>(&mut arg0.result, v2, v7);
                    v3 = v6.trader;
                    v4 = v6.result;
                } else {
                    let v8 = Result{
                        trader : v6.trader,
                        result : v6.result,
                    };
                    0x2::table::add<u64, Result>(&mut arg0.result, v2, v8);
                };
                v2 = v2 + 1;
                let Result {
                    trader : _,
                    result : _,
                } = v6;
            };
            if (v1) {
                let v11 = Challenge{
                    fund_id    : *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg1)),
                    is_success : true,
                };
                0x2::event::emit<Challenge>(v11);
            } else if (v3 != 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg2)) {
                let v12 = Challenge{
                    fund_id    : *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg1)),
                    is_success : true,
                };
                0x2::event::emit<Challenge>(v12);
            } else {
                let v13 = Challenge{
                    fund_id    : *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg1)),
                    is_success : false,
                };
                0x2::event::emit<Challenge>(v13);
            };
        };
        let v14 = Challenge{
            fund_id    : *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg1)),
            is_success : false,
        };
        0x2::event::emit<Challenge>(v14);
    }

    public fun claim_rank<T0>(arg0: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::GlobalConfig, arg1: &mut BonusHost<T0>, arg2: &mut Arena<T0>, arg3: &mut 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::Fund<T0>, arg4: &mut 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::Trader, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_if_host_not_for_this_arena<T0>(arg1, arg2);
        assert_if_fund_trader_not_matched<T0>(arg3, arg4);
        assert_if_trader_not_attended_arena<T0>(arg2, arg4);
        assert_if_already_claimed<T0>(arg1, arg4);
        assert_if_not_arrived_end_time<T0>(arg2, arg5);
        let v0 = 0x2::table::borrow<u64, Result>(&arg2.result, 1);
        let v1 = 0x2::table::borrow<u64, Result>(&arg2.result, 2);
        let v2 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Certificate>(&mut arg2.id, *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg3)));
        let v3 = 0;
        let v4 = 0;
        if (0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg4) == 0x2::table::borrow<u64, Result>(&arg2.result, 0).trader) {
            v2.rank = 1;
            v3 = 1;
            v4 = 0x2::balance::value<T0>(&arg1.bonus) * 5000 / 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::base_percentage(arg0);
        } else if (0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg4) == v0.trader) {
            v2.rank = 2;
            v3 = 2;
            v4 = 0x2::balance::value<T0>(&arg1.bonus) * 3000 / 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::base_percentage(arg0);
        } else if (0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg4) == v1.trader) {
            v2.rank = 3;
            v3 = 3;
            v4 = 0x2::balance::value<T0>(&arg1.bonus) * 2000 / 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::base_percentage(arg0);
        };
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.is_claimed, 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg4), true);
        let v5 = ClaimRank{
            trader : 0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::trader::id(arg4),
            arena  : *0x2::object::uid_as_inner(&arg2.id),
            fund   : *0x2::object::uid_as_inner(0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::fund::id<T0>(arg3)),
            rank   : v3,
        };
        0x2::event::emit<ClaimRank>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.bonus, v4), arg6)
    }

    public fun create_arena<T0>(arg0: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::GlobalConfig, arg1: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Arena<T0> {
        0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::assert_if_version_not_matched(arg0, 1);
        assert_if_arena_type_not_allowed(arg2);
        if (arg2 == 0) {
            Arena<T0>{id: 0x2::object::new(arg6), arena_type: arg2, start_time: arg3, attend_duration: arg4, invest_duration: arg5, end_time: arg3 + arg4 + arg5 + 604800000, funds: 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg6), traders: 0x1::vector::empty<0x2::object::ID>(), result: 0x2::table::new<u64, Result>(arg6), is_rank_claimed: 0x2::table::new<0x2::object::ID, bool>(arg6)}
        } else if (arg2 == 1) {
            Arena<T0>{id: 0x2::object::new(arg6), arena_type: arg2, start_time: arg3, attend_duration: arg4, invest_duration: arg5, end_time: arg3 + arg4 + arg5 + 2592000000, funds: 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg6), traders: 0x1::vector::empty<0x2::object::ID>(), result: 0x2::table::new<u64, Result>(arg6), is_rank_claimed: 0x2::table::new<0x2::object::ID, bool>(arg6)}
        } else if (arg2 == 2) {
            Arena<T0>{id: 0x2::object::new(arg6), arena_type: arg2, start_time: arg3, attend_duration: arg4, invest_duration: arg5, end_time: arg3 + arg4 + arg5 + 7776000000, funds: 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg6), traders: 0x1::vector::empty<0x2::object::ID>(), result: 0x2::table::new<u64, Result>(arg6), is_rank_claimed: 0x2::table::new<0x2::object::ID, bool>(arg6)}
        } else {
            Arena<T0>{id: 0x2::object::new(arg6), arena_type: arg2, start_time: arg3, attend_duration: arg4, invest_duration: arg5, end_time: arg3 + arg4 + arg5 + 31536000000, funds: 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg6), traders: 0x1::vector::empty<0x2::object::ID>(), result: 0x2::table::new<u64, Result>(arg6), is_rank_claimed: 0x2::table::new<0x2::object::ID, bool>(arg6)}
        }
    }

    public fun create_arena_request<T0>(arg0: u8) : ArenaRequest<T0> {
        assert_if_arena_type_not_supported(arg0);
        ArenaRequest<T0>{arena_type: arg0}
    }

    fun create_certificate<T0>(arg0: &Arena<T0>) : Certificate {
        Certificate{
            arena      : *0x2::object::uid_as_inner(&arg0.id),
            arena_type : arg0.arena_type,
            end_time   : arg0.end_time,
            rank       : 0,
            is_matched : false,
        }
    }

    public entry fun new_arena<T0>(arg0: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::GlobalConfig, arg1: &0x31a0fb7add12a8146bd7d5b1fe5be231f9c92bc9f4957022ae745b880212ebc::config::AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = create_arena<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v1 = NewArena<T0>{
            id              : *0x2::object::uid_as_inner(&v0.id),
            arena_type      : v0.arena_type,
            start_time      : v0.start_time,
            attend_duration : v0.attend_duration,
            invest_duration : v0.invest_duration,
            end_time        : v0.end_time,
        };
        0x2::event::emit<NewArena<T0>>(v1);
        let v2 = BonusHost<T0>{
            id         : 0x2::object::new(arg7),
            arena      : *0x2::object::uid_as_inner(&v0.id),
            bonus      : 0x2::coin::into_balance<T0>(arg6),
            is_claimed : 0x2::table::new<0x2::object::ID, bool>(arg7),
        };
        0x2::transfer::share_object<BonusHost<T0>>(v2);
        0x2::transfer::share_object<Arena<T0>>(v0);
    }

    public entry fun sponsor_bonus<T0>(arg0: &mut BonusHost<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.bonus, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

