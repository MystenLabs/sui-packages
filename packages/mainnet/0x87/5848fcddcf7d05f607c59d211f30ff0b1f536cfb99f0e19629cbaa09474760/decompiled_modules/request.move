module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::request {
    struct TradingRequest<phantom T0> {
        market_id: 0x2::object::ID,
        account_object_address: address,
        action: u8,
        sender: address,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral: 0x2::balance::Balance<T0>,
        position_id: 0x1::option::Option<u64>,
        trigger_price: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>,
        reduce_only: bool,
        is_stop_order: bool,
        linked_position_id: 0x1::option::Option<u64>,
        trigger_price_key: 0x1::option::Option<u128>,
        withdraw_amount: u64,
        acceptable_price: u64,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun acceptable_price<T0>(arg0: &TradingRequest<T0>) : u64 {
        arg0.acceptable_price
    }

    public fun account_id<T0>(arg0: &TradingRequest<T0>) : 0x2::object::ID {
        0x2::object::id_from_address(arg0.account_object_address)
    }

    public fun account_object_address<T0>(arg0: &TradingRequest<T0>) : address {
        arg0.account_object_address
    }

    public fun action<T0>(arg0: &TradingRequest<T0>) : u8 {
        arg0.action
    }

    public fun action_cancel_order() : u8 {
        3
    }

    public fun action_close_position() : u8 {
        1
    }

    public fun action_decrease_position() : u8 {
        8
    }

    public fun action_deposit_collateral() : u8 {
        4
    }

    public fun action_increase_position() : u8 {
        7
    }

    public fun action_liquidate() : u8 {
        6
    }

    public fun action_open_position() : u8 {
        0
    }

    public fun action_place_order() : u8 {
        2
    }

    public fun action_withdraw_collateral() : u8 {
        5
    }

    public fun add_witness<T0, T1: drop>(arg0: &mut TradingRequest<T0>, arg1: T1) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witnesses, &v0)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_witness_already_exists();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
    }

    public fun deposit_amount<T0>(arg0: &TradingRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public(friend) fun destroy<T0>(arg0: TradingRequest<T0>) : (0x2::object::ID, address, u8, address, bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, 0x2::balance::Balance<T0>, 0x1::option::Option<u64>, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>, bool, bool, 0x1::option::Option<u64>, 0x1::option::Option<u128>, u64, u64, 0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        let TradingRequest {
            market_id              : v0,
            account_object_address : v1,
            action                 : v2,
            sender                 : v3,
            is_long                : v4,
            size                   : v5,
            collateral             : v6,
            position_id            : v7,
            trigger_price          : v8,
            reduce_only            : v9,
            is_stop_order          : v10,
            linked_position_id     : v11,
            trigger_price_key      : v12,
            withdraw_amount        : v13,
            acceptable_price       : v14,
            witnesses              : v15,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15)
    }

    public fun is_long<T0>(arg0: &TradingRequest<T0>) : bool {
        arg0.is_long
    }

    public fun is_stop_order<T0>(arg0: &TradingRequest<T0>) : bool {
        arg0.is_stop_order
    }

    public fun linked_position_id<T0>(arg0: &TradingRequest<T0>) : 0x1::option::Option<u64> {
        arg0.linked_position_id
    }

    public fun market_id<T0>(arg0: &TradingRequest<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: address, arg4: bool, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: 0x2::balance::Balance<T0>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>, arg9: bool, arg10: bool, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u128>, arg13: u64, arg14: u64) : TradingRequest<T0> {
        TradingRequest<T0>{
            market_id              : arg0,
            account_object_address : arg1,
            action                 : arg2,
            sender                 : arg3,
            is_long                : arg4,
            size                   : arg5,
            collateral             : arg6,
            position_id            : arg7,
            trigger_price          : arg8,
            reduce_only            : arg9,
            is_stop_order          : arg10,
            linked_position_id     : arg11,
            trigger_price_key      : arg12,
            withdraw_amount        : arg13,
            acceptable_price       : arg14,
            witnesses              : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun new_no_collateral<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: address, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64) : TradingRequest<T0> {
        new<T0>(arg0, arg1, arg2, arg3, false, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(), 0x2::balance::zero<T0>(), arg4, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(), false, false, 0x1::option::none<u64>(), 0x1::option::none<u128>(), arg5, arg6)
    }

    public fun position_id<T0>(arg0: &TradingRequest<T0>) : 0x1::option::Option<u64> {
        arg0.position_id
    }

    public fun reduce_only<T0>(arg0: &TradingRequest<T0>) : bool {
        arg0.reduce_only
    }

    public fun sender<T0>(arg0: &TradingRequest<T0>) : address {
        arg0.sender
    }

    public fun size<T0>(arg0: &TradingRequest<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.size
    }

    public fun trigger_price<T0>(arg0: &TradingRequest<T0>) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float> {
        arg0.trigger_price
    }

    public fun trigger_price_key<T0>(arg0: &TradingRequest<T0>) : 0x1::option::Option<u128> {
        arg0.trigger_price_key
    }

    public fun withdraw_amount<T0>(arg0: &TradingRequest<T0>) : u64 {
        arg0.withdraw_amount
    }

    public fun witnesses<T0>(arg0: &TradingRequest<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    // decompiled from Move bytecode v7
}

