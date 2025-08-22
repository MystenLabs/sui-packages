module 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::market {
    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        max_long_leverage: u64,
        max_short_leverage: u64,
        positions: 0x2::linked_table::LinkedTable<0x2::object::ID, PositionInfo>,
        fees: 0x2::bag::Bag,
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
        init_deposit_amount: u64,
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
        fee_amount: u64,
        fee_coin_type: 0x1::type_name::TypeName,
    }

    struct ClaimFeeEvent has copy, drop {
        market_id: 0x2::object::ID,
        recipient: address,
        base_fee_amount: u64,
        quote_fee_amount: u64,
    }

    public(friend) fun add_position_info<T0, T1>(arg0: &mut Market<T0, T1>, arg1: PositionInfo) {
        0x2::linked_table::push_back<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1.position_id, arg1);
    }

    public(friend) fun assert_close_not_paused<T0, T1>(arg0: &Market<T0, T1>) {
        assert!(!arg0.is_close_pause, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_market_close_paused());
    }

    public(friend) fun assert_leverage_valid<T0, T1>(arg0: &Market<T0, T1>, arg1: u64, arg2: bool) {
        if (arg2) {
            assert!(arg1 >= 1 && arg1 <= arg0.max_long_leverage, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_leverage_too_high());
        } else {
            assert!(arg1 >= 1 && arg1 <= arg0.max_short_leverage, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_leverage_too_high());
        };
    }

    public(friend) fun assert_open_not_paused<T0, T1>(arg0: &Market<T0, T1>) {
        assert!(!arg0.is_open_pause, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_market_open_paused());
    }

    public(friend) fun calculate_close_fee<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : u64 {
        arg1 * arg0.close_fee_rate / 1000000
    }

    public(friend) fun calculate_open_fee<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : u64 {
        arg1 * arg0.open_fee_rate / 1000000
    }

    public fun claim_fees<T0, T1>(arg0: &0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fees, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fees, v0)
        } else {
            0x2::balance::zero<T0>()
        };
        let v3 = v2;
        let v4 = if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fees, v1)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.fees, v1)
        } else {
            0x2::balance::zero<T1>()
        };
        let v5 = v4;
        let v6 = ClaimFeeEvent{
            market_id        : 0x2::object::uid_to_inner(&arg1.id),
            recipient        : 0x2::tx_context::sender(arg2),
            base_fee_amount  : 0x2::balance::value<T0>(&v3),
            quote_fee_amount : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<ClaimFeeEvent>(v6);
        (0x2::coin::from_balance<T0>(v3, arg2), 0x2::coin::from_balance<T1>(v5, arg2))
    }

    public fun close_fee_rate<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.close_fee_rate
    }

    public fun create_market<T0, T1>(arg0: &0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::AdminCap, arg1: &0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::GlobalConfig, arg2: &mut Markets, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::assert_package_version(arg1);
        assert!(arg5 <= 100000, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_fee_rate());
        assert!(arg6 <= 100000, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_fee_rate());
        assert!(arg3 > 0, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_leverage());
        assert!(arg4 > 0, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_leverage());
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        let v4 = Market<T0, T1>{
            id                 : v0,
            base_token         : v2,
            quote_token        : v3,
            max_long_leverage  : arg3,
            max_short_leverage : arg4,
            positions          : 0x2::linked_table::new<0x2::object::ID, PositionInfo>(arg8),
            fees               : 0x2::bag::new(arg8),
            open_fee_rate      : arg5,
            close_fee_rate     : arg6,
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
        0x2::table::add<0x2::object::ID, MarketSimpleInfo>(&mut arg2.list, v5, v6);
        arg2.index = arg2.index + 1;
        let v7 = NewMarketEvent{
            market_id          : v1,
            market_key         : v5,
            coin_type_base     : v2,
            coin_type_quote    : v3,
            max_long_leverage  : arg3,
            max_short_leverage : arg4,
            open_fee_rate      : arg5,
            close_fee_rate     : arg6,
            timestamp          : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<NewMarketEvent>(v7);
        0x2::transfer::share_object<Market<T0, T1>>(v4);
    }

    public(friend) fun create_position_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: bool) : PositionInfo {
        PositionInfo{
            position_id             : arg0,
            obligation_owner_cap_id : arg1,
            init_deposit_amount     : arg2,
            is_long                 : arg3,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Markets{
            id    : 0x2::object::new(arg0),
            list  : 0x2::table::new<0x2::object::ID, MarketSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Markets>(v0);
    }

    public fun is_close_pause<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.is_close_pause
    }

    public fun is_market_open_paused<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.is_open_pause
    }

    public(friend) fun join_fee<T0, T1, T2>(arg0: &mut Market<T0, T1>, arg1: 0x2::balance::Balance<T2>, arg2: bool) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.fees, v0, arg1);
        } else {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.fees, v0), arg1);
        };
        let v1 = FeeCollectedEvent{
            market_id     : 0x2::object::id<Market<T0, T1>>(arg0),
            is_open       : arg2,
            fee_amount    : 0x2::balance::value<T2>(&arg1),
            fee_coin_type : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v1);
    }

    public fun market_id<T0, T1>(arg0: &Market<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun max_long_leverage<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.max_long_leverage
    }

    public fun max_short_leverage<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.max_short_leverage
    }

    public(friend) fun new_market_key<T0, T1>() : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let (v6, v7) = if (*0x1::vector::borrow<u8>(&v1, 0) < *0x1::vector::borrow<u8>(&v3, 0)) {
            (v3, v1)
        } else {
            (v1, v3)
        };
        let v8 = v7;
        let v9 = v6;
        let v10 = 0;
        let v11 = false;
        while (v10 < v5) {
            let v12 = *0x1::vector::borrow<u8>(&v8, v10);
            if (!v11 && v10 < v4) {
                let v13 = *0x1::vector::borrow<u8>(&v9, v10);
                if (v13 > v12) {
                    abort 10002
                };
                if (v13 < v12) {
                    v11 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v9, v12);
            v10 = v10 + 1;
        };
        if (!v11) {
            assert!(v4 != v5, 10001);
            assert!(v4 < v5, 10002);
        };
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v9))
    }

    public fun open_fee_rate<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.open_fee_rate
    }

    public fun position_exists<T0, T1>(arg0: &Market<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, PositionInfo>(&arg0.positions, arg1)
    }

    public(friend) fun remove_position_info<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::object::ID) {
        0x2::linked_table::remove<0x2::object::ID, PositionInfo>(&mut arg0.positions, arg1);
    }

    public fun set_fee_rate<T0, T1>(arg0: &0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 <= 100000, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_fee_rate());
        assert!(arg3 <= 100000, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_fee_rate());
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

    public fun set_market_close_pause<T0, T1>(arg0: &0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_close_pause = arg2;
        let v0 = SetMarketClosePauseEvent{
            market_id      : 0x2::object::uid_to_inner(&arg1.id),
            is_close_pause : arg2,
            sender         : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetMarketClosePauseEvent>(v0);
    }

    public fun set_market_open_pause<T0, T1>(arg0: &0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.is_open_pause = arg2;
        let v0 = SetMarketOpenPauseEvent{
            market_id     : 0x2::object::uid_to_inner(&arg1.id),
            is_open_pause : arg2,
            sender        : 0x2::tx_context::sender(arg4),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetMarketOpenPauseEvent>(v0);
    }

    public fun set_max_leverage<T0, T1>(arg0: &0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_leverage());
        assert!(arg3 > 0, 0xed98661c7d788bc1cb9917c008f8595fc9d0cd7e5c22a1fcc0949f9c3e2c9b4f::errors::err_invalid_leverage());
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

