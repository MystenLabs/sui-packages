module 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market {
    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        max_long_leverage: u64,
        max_short_leverage: u64,
        positions: 0x2::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
        fee_base: 0x2::balance::Balance<T0>,
        fee_quote: 0x2::balance::Balance<T1>,
        open_fee_rate: u64,
        close_fee_rate: u64,
        is_open_pause: bool,
        is_close_pause: bool,
    }

    struct Markets has store, key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x2::object::ID, MarketSimpleInfo>,
        index: u64,
    }

    struct MarketSimpleInfo has copy, drop, store {
        market_id: 0x2::object::ID,
        market_key: 0x2::object::ID,
        coin_type_base: 0x1::type_name::TypeName,
        coin_type_quote: 0x1::type_name::TypeName,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        obligation_owner_cap_id: 0x2::object::ID,
        init_deposit_token_amount: u64,
        is_long: bool,
    }

    struct NewMarketEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_key: 0x2::object::ID,
        coin_type_base: 0x1::type_name::TypeName,
        coin_type_quote: 0x1::type_name::TypeName,
        max_long_leverage: u64,
        max_short_leverage: u64,
        open_fee_rate: u64,
        close_fee_rate: u64,
        timestamp: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        max_long_leverage: u64,
        max_short_leverage: u64,
        open_fee_rate: u64,
        close_fee_rate: u64,
        timestamp: u64,
    }

    struct SetMarketOpenPauseEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_open_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct SetMarketClosePauseEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_close_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_open: bool,
        base_fee_amount: u64,
        quote_fee_amount: u64,
        timestamp: u64,
    }

    struct ClaimFeeEvent has copy, drop {
        market_id: 0x2::object::ID,
        recipient: address,
        base_fee_amount: u64,
        quote_fee_amount: u64,
        timestamp: u64,
    }

    public(friend) fun add_position_info<T0, T1>(arg0: &mut Market<T0, T1>, arg1: PositionInfo) {
        0x2::linked_table::push_back<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1.position_id, arg1);
    }

    public(friend) fun assert_close_not_paused<T0, T1>(arg0: &Market<T0, T1>) {
        assert!(!arg0.is_close_pause, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_market_close_paused());
    }

    public(friend) fun assert_leverage_valid<T0, T1>(arg0: &Market<T0, T1>, arg1: u64, arg2: bool) {
        if (arg2) {
            assert!(arg1 >= 1 && arg1 <= arg0.max_long_leverage, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_leverage_too_high());
        } else {
            assert!(arg1 >= 1 && arg1 <= arg0.max_short_leverage, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_leverage_too_high());
        };
    }

    public(friend) fun assert_open_not_paused<T0, T1>(arg0: &Market<T0, T1>) {
        assert!(!arg0.is_open_pause, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_market_open_paused());
    }

    public(friend) fun calculate_close_fee<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : u64 {
        arg1 * arg0.close_fee_rate / 1000000
    }

    public(friend) fun calculate_open_fee<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : u64 {
        arg1 * arg0.open_fee_rate / 1000000
    }

    public fun claim_fees<T0, T1>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg1.fee_base);
        let v1 = 0x2::balance::value<T1>(&arg1.fee_quote);
        let v2 = ClaimFeeEvent{
            market_id        : 0x2::object::uid_to_inner(&arg1.id),
            recipient        : 0x2::tx_context::sender(arg3),
            base_fee_amount  : v0,
            quote_fee_amount : v1,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ClaimFeeEvent>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fee_base, v0), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.fee_quote, v1), arg3))
    }

    public fun create_market<T0, T1>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::AdminCap, arg1: &mut Markets, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 100000, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_fee_rate());
        assert!(arg5 <= 100000, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_fee_rate());
        assert!(arg2 > 0, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_leverage());
        assert!(arg3 > 0, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_leverage());
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        let v4 = Market<T0, T1>{
            id                 : v0,
            base_token         : v2,
            quote_token        : v3,
            max_long_leverage  : arg2,
            max_short_leverage : arg3,
            positions          : 0x2::linked_table::new<0x2::object::ID, PositionInfo>(arg7),
            fee_base           : 0x2::balance::zero<T0>(),
            fee_quote          : 0x2::balance::zero<T1>(),
            open_fee_rate      : arg4,
            close_fee_rate     : arg5,
            is_open_pause      : false,
            is_close_pause     : false,
        };
        let v5 = new_market_key<T0, T1>();
        let v6 = MarketSimpleInfo{
            market_id       : v1,
            market_key      : v5,
            coin_type_base  : v2,
            coin_type_quote : v3,
        };
        0x2::table::add<0x2::object::ID, MarketSimpleInfo>(&mut arg1.list, v5, v6);
        arg1.index = arg1.index + 1;
        let v7 = NewMarketEvent{
            market_id          : v1,
            market_key         : v5,
            coin_type_base     : v2,
            coin_type_quote    : v3,
            max_long_leverage  : arg2,
            max_short_leverage : arg3,
            open_fee_rate      : arg4,
            close_fee_rate     : arg5,
            timestamp          : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<NewMarketEvent>(v7);
        0x2::transfer::share_object<Market<T0, T1>>(v4);
    }

    public(friend) fun create_position_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: bool) : PositionInfo {
        PositionInfo{
            position_id               : arg0,
            obligation_owner_cap_id   : arg1,
            init_deposit_token_amount : arg2,
            is_long                   : arg3,
        }
    }

    public fun get_close_fee_rate<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.close_fee_rate
    }

    public fun get_market_id<T0, T1>(arg0: &Market<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_max_long_leverage<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.max_long_leverage
    }

    public fun get_max_short_leverage<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.max_short_leverage
    }

    public fun get_open_fee_rate<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.open_fee_rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Markets{
            id    : 0x2::object::new(arg0),
            list  : 0x2::table::new<0x2::object::ID, MarketSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Markets>(v0);
    }

    public fun is_market_close_paused<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.is_close_pause
    }

    public fun is_market_open_paused<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.is_open_pause
    }

    public(friend) fun join_fee<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: bool, arg4: &0x2::clock::Clock) {
        0x2::balance::join<T0>(&mut arg0.fee_base, arg1);
        0x2::balance::join<T1>(&mut arg0.fee_quote, arg2);
        let v0 = FeeCollectedEvent{
            market_id        : 0x2::object::id<Market<T0, T1>>(arg0),
            is_open          : arg3,
            base_fee_amount  : 0x2::balance::value<T0>(&arg1),
            quote_fee_amount : 0x2::balance::value<T1>(&arg2),
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FeeCollectedEvent>(v0);
    }

    public fun new_market_key<T0, T1>() : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let v6 = 0;
        let v7 = false;
        while (v6 < v5) {
            let v8 = *0x1::vector::borrow<u8>(&v3, v6);
            if (!v7 && v6 < v4) {
                let v9 = *0x1::vector::borrow<u8>(&v1, v6);
                if (v9 > v8) {
                    abort 10002
                };
                if (v9 < v8) {
                    v7 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v8);
            v6 = v6 + 1;
        };
        if (!v7) {
            assert!(v4 != v5, 10001);
            assert!(v4 < v5, 10002);
        };
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun position_exists<T0, T1>(arg0: &Market<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    public(friend) fun remove_position_info<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::object::ID) {
        0x2::linked_table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
    }

    public fun set_fee_rate<T0, T1>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 <= 100000, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_fee_rate());
        assert!(arg3 <= 100000, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_fee_rate());
        arg1.open_fee_rate = arg2;
        arg1.close_fee_rate = arg3;
        let v0 = MarketUpdatedEvent{
            market_id          : 0x2::object::uid_to_inner(&arg1.id),
            max_long_leverage  : arg1.max_long_leverage,
            max_short_leverage : arg1.max_short_leverage,
            open_fee_rate      : arg2,
            close_fee_rate     : arg3,
            timestamp          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun set_market_close_pause<T0, T1>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_close_pause = arg2;
        let v0 = SetMarketClosePauseEvent{
            market_id      : 0x2::object::uid_to_inner(&arg1.id),
            is_close_pause : arg2,
            sender         : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetMarketClosePauseEvent>(v0);
    }

    public fun set_market_open_pause<T0, T1>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_open_pause = arg2;
        let v0 = SetMarketOpenPauseEvent{
            market_id     : 0x2::object::uid_to_inner(&arg1.id),
            is_open_pause : arg2,
            sender        : 0x2::tx_context::sender(arg4),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetMarketOpenPauseEvent>(v0);
    }

    public fun set_max_leverage<T0, T1>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_leverage());
        assert!(arg3 > 0, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_leverage());
        arg1.max_long_leverage = arg2;
        arg1.max_short_leverage = arg3;
        let v0 = MarketUpdatedEvent{
            market_id          : 0x2::object::uid_to_inner(&arg1.id),
            max_long_leverage  : arg2,
            max_short_leverage : arg3,
            open_fee_rate      : arg1.open_fee_rate,
            close_fee_rate     : arg1.close_fee_rate,
            timestamp          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

