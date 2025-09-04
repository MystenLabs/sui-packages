module 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::market {
    struct PositionHolder has store, key {
        id: 0x2::object::UID,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        max_long_leverage: u64,
        max_short_leverage: u64,
        position_holder: PositionHolder,
        num_positions: u64,
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
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
    }

    struct NewMarketEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_key: 0x2::object::ID,
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
        position_holder_id: 0x2::object::ID,
        max_long_leverage: u64,
        max_short_leverage: u64,
        open_fee_rate: u64,
        close_fee_rate: u64,
    }

    struct MarketUpdatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        max_long_leverage: u64,
        max_short_leverage: u64,
        open_fee_rate: u64,
        close_fee_rate: u64,
    }

    struct SetMarketOpenPauseEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_open_pause: bool,
        sender: address,
    }

    struct SetMarketClosePauseEvent has copy, drop {
        market_id: 0x2::object::ID,
        is_close_pause: bool,
        sender: address,
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

    public(friend) fun add_position_into_position_holder<T0>(arg0: &mut Market, arg1: 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0>) {
        let v0 = 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::create_position_df_key(0x2::object::id<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0>>(&arg1));
        if (0x2::dynamic_object_field::exists_<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey>(&arg0.position_holder.id, v0)) {
            abort 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_position_already_exists()
        };
        0x2::dynamic_object_field::add<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0>>(&mut arg0.position_holder.id, v0, arg1);
        arg0.num_positions = arg0.num_positions + 1;
    }

    public(friend) fun assert_close_not_paused(arg0: &Market) {
        assert!(!arg0.is_close_pause, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_market_close_paused());
    }

    public(friend) fun assert_leverage_valid(arg0: &Market, arg1: u64, arg2: bool) {
        if (arg2) {
            assert!(arg1 >= 1 && arg1 <= arg0.max_long_leverage, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_leverage_too_high());
        } else {
            assert!(arg1 >= 1 && arg1 <= arg0.max_short_leverage, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_leverage_too_high());
        };
    }

    public(friend) fun assert_open_not_paused(arg0: &Market) {
        assert!(!arg0.is_open_pause, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_market_open_paused());
    }

    public fun base_token(arg0: &Market) : 0x1::type_name::TypeName {
        arg0.base_token
    }

    public(friend) fun borrow_mut_position<T0>(arg0: &mut Market, arg1: 0x2::object::ID) : &mut 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0> {
        let v0 = 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::create_position_df_key(arg1);
        if (!0x2::dynamic_object_field::exists_<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey>(&arg0.position_holder.id, v0)) {
            abort 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_position_not_found()
        };
        0x2::dynamic_object_field::borrow_mut<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0>>(&mut arg0.position_holder.id, v0)
    }

    public(friend) fun borrow_position<T0>(arg0: &Market, arg1: 0x2::object::ID) : &0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0> {
        let v0 = 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::create_position_df_key(arg1);
        if (!0x2::dynamic_object_field::exists_<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey>(&arg0.position_holder.id, v0)) {
            abort 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_position_not_found()
        };
        0x2::dynamic_object_field::borrow<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0>>(&arg0.position_holder.id, v0)
    }

    public fun claim_fees<T0, T1>(arg0: &0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::config::AdminCap, arg1: &mut Market, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
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
            market_id        : 0x2::object::id<Market>(arg1),
            recipient        : 0x2::tx_context::sender(arg2),
            base_fee_amount  : 0x2::balance::value<T0>(&v3),
            quote_fee_amount : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<ClaimFeeEvent>(v6);
        (0x2::coin::from_balance<T0>(v3, arg2), 0x2::coin::from_balance<T1>(v5, arg2))
    }

    public fun close_fee_rate(arg0: &Market) : u64 {
        arg0.close_fee_rate
    }

    public fun create_market<T0, T1>(arg0: &0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::config::AdminCap, arg1: &mut Markets, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 100000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_fee_rate());
        assert!(arg5 <= 100000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_fee_rate());
        assert!(arg2 > 0, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_equal_to_zero());
        assert!(arg3 > 0, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_equal_to_zero());
        assert!(arg2 <= 5000000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_too_high());
        assert!(arg3 <= 5000000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_too_high());
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<T1>();
        let v4 = new_market_key(v2, v3);
        if (0x2::table::contains<0x2::object::ID, MarketSimpleInfo>(&arg1.list, v4)) {
            abort 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_market_already_exists()
        };
        let v5 = PositionHolder{id: 0x2::object::new(arg6)};
        let v6 = Market{
            id                 : v0,
            base_token         : v2,
            quote_token        : v3,
            max_long_leverage  : arg2,
            max_short_leverage : arg3,
            position_holder    : v5,
            num_positions      : 0,
            fees               : 0x2::bag::new(arg6),
            open_fee_rate      : arg4,
            close_fee_rate     : arg5,
            is_open_pause      : false,
            is_close_pause     : false,
        };
        let v7 = MarketSimpleInfo{
            market_id   : v1,
            market_key  : v4,
            base_token  : v2,
            quote_token : v3,
        };
        0x2::table::add<0x2::object::ID, MarketSimpleInfo>(&mut arg1.list, v4, v7);
        arg1.index = arg1.index + 1;
        let v8 = NewMarketEvent{
            market_id          : v1,
            market_key         : v4,
            base_token         : v2,
            quote_token        : v3,
            position_holder_id : 0x2::object::id<PositionHolder>(&v5),
            max_long_leverage  : arg2,
            max_short_leverage : arg3,
            open_fee_rate      : arg4,
            close_fee_rate     : arg5,
        };
        0x2::event::emit<NewMarketEvent>(v8);
        0x2::transfer::share_object<Market>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Markets{
            id    : 0x2::object::new(arg0),
            list  : 0x2::table::new<0x2::object::ID, MarketSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Markets>(v0);
    }

    public fun is_close_pause(arg0: &Market) : bool {
        arg0.is_close_pause
    }

    public fun is_open_pause(arg0: &Market) : bool {
        arg0.is_open_pause
    }

    public(friend) fun join_fee<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: bool) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0, arg1);
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0), arg1);
        };
        let v1 = FeeCollectedEvent{
            market_id     : 0x2::object::id<Market>(arg0),
            is_open       : arg2,
            fee_amount    : 0x2::balance::value<T0>(&arg1),
            fee_coin_type : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v1);
    }

    public fun market_id(arg0: &Market) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun max_long_leverage(arg0: &Market) : u64 {
        arg0.max_long_leverage
    }

    public fun max_short_leverage(arg0: &Market) : u64 {
        arg0.max_short_leverage
    }

    public(friend) fun new_market_key(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(arg0);
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(arg1);
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let (v6, v7) = if (*0x1::vector::borrow<u8>(&v1, 0) < *0x1::vector::borrow<u8>(&v3, 0)) {
            (v1, v3)
        } else {
            (v3, v1)
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

    public fun open_fee_rate(arg0: &Market) : u64 {
        arg0.open_fee_rate
    }

    public fun position_holder_id(arg0: &Market) : 0x2::object::ID {
        0x2::object::id<PositionHolder>(&arg0.position_holder)
    }

    public fun quote_token(arg0: &Market) : 0x1::type_name::TypeName {
        arg0.quote_token
    }

    public(friend) fun remove_position_from_position_holder<T0>(arg0: &mut Market, arg1: 0x2::object::ID) : 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0> {
        let v0 = 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::create_position_df_key(arg1);
        if (!0x2::dynamic_object_field::exists_<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey>(&arg0.position_holder.id, v0)) {
            abort 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_position_not_found()
        };
        0x2::dynamic_object_field::remove<0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::PositionDfKey, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::position::Position<T0>>(&mut arg0.position_holder.id, v0)
    }

    public fun set_fee_rate(arg0: &0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::config::AdminCap, arg1: &mut Market, arg2: u64, arg3: u64) {
        assert!(arg2 <= 100000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_fee_rate());
        assert!(arg3 <= 100000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_fee_rate());
        arg1.open_fee_rate = arg2;
        arg1.close_fee_rate = arg3;
        let v0 = MarketUpdatedEvent{
            market_id          : 0x2::object::id<Market>(arg1),
            max_long_leverage  : arg1.max_long_leverage,
            max_short_leverage : arg1.max_short_leverage,
            open_fee_rate      : arg2,
            close_fee_rate     : arg3,
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    public fun set_market_close_pause(arg0: &0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::config::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        arg1.is_close_pause = arg2;
        let v0 = SetMarketClosePauseEvent{
            market_id      : 0x2::object::id<Market>(arg1),
            is_close_pause : arg2,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SetMarketClosePauseEvent>(v0);
    }

    public fun set_market_open_pause(arg0: &0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::config::AdminCap, arg1: &mut Market, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        arg1.is_open_pause = arg2;
        let v0 = SetMarketOpenPauseEvent{
            market_id     : 0x2::object::id<Market>(arg1),
            is_open_pause : arg2,
            sender        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SetMarketOpenPauseEvent>(v0);
    }

    public fun set_max_leverage(arg0: &0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::config::AdminCap, arg1: &mut Market, arg2: u64, arg3: u64) {
        assert!(arg2 > 0, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_equal_to_zero());
        assert!(arg3 > 0, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_equal_to_zero());
        assert!(arg2 <= 5000000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_too_high());
        assert!(arg3 <= 5000000, 0x917acb3dfbc4a57299704c23587fec3e767769a63851a92bf17da0df722ddfc8::errors::err_invalid_leverage_too_high());
        arg1.max_long_leverage = arg2;
        arg1.max_short_leverage = arg3;
        let v0 = MarketUpdatedEvent{
            market_id          : 0x2::object::id<Market>(arg1),
            max_long_leverage  : arg2,
            max_short_leverage : arg3,
            open_fee_rate      : arg1.open_fee_rate,
            close_fee_rate     : arg1.close_fee_rate,
        };
        0x2::event::emit<MarketUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

