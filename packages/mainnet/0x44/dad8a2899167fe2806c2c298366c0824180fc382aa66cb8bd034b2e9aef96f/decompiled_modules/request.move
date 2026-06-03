module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::request {
    struct PlaceOrderArgument has copy, drop, store {
        is_long: bool,
        is_stop_order: bool,
        reduce_only: bool,
        size: u128,
        trigger_price: 0x1::option::Option<u128>,
        linked_position_id: 0x1::option::Option<u64>,
        acceptable_price: 0x1::option::Option<u64>,
        collateral_amount: u64,
    }

    struct TradingRequest<phantom T0> {
        market_id: 0x2::object::ID,
        account_object_address: address,
        action: u8,
        sender: address,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral: 0x2::balance::Balance<T0>,
        order_id: 0x1::option::Option<u64>,
        position_id: 0x1::option::Option<u64>,
        trigger_price: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>,
        reduce_only: bool,
        is_stop_order: bool,
        linked_position_id: 0x1::option::Option<u64>,
        trigger_price_key: 0x1::option::Option<u128>,
        withdraw_amount: u64,
        acceptable_price: u64,
        pre_orders: vector<PlaceOrderArgument>,
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

    public fun action_place_order() : u8 {
        2
    }

    public fun add_witness<T0, T1: drop>(arg0: &mut TradingRequest<T0>, arg1: T1) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witnesses, &v0)) {
            abort 13906834646789783553
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
    }

    public fun arg_acceptable_price(arg0: &PlaceOrderArgument) : 0x1::option::Option<u64> {
        arg0.acceptable_price
    }

    public fun arg_collateral_amount(arg0: &PlaceOrderArgument) : u64 {
        arg0.collateral_amount
    }

    public fun arg_is_long(arg0: &PlaceOrderArgument) : bool {
        arg0.is_long
    }

    public fun arg_is_stop_order(arg0: &PlaceOrderArgument) : bool {
        arg0.is_stop_order
    }

    public fun arg_linked_position_id(arg0: &PlaceOrderArgument) : 0x1::option::Option<u64> {
        arg0.linked_position_id
    }

    public fun arg_reduce_only(arg0: &PlaceOrderArgument) : bool {
        arg0.reduce_only
    }

    public fun arg_size(arg0: &PlaceOrderArgument) : u128 {
        arg0.size
    }

    public fun arg_trigger_price(arg0: &PlaceOrderArgument) : 0x1::option::Option<u128> {
        arg0.trigger_price
    }

    public fun deposit_amount<T0>(arg0: &TradingRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public(friend) fun destroy<T0>(arg0: TradingRequest<T0>) : (0x2::object::ID, address, u8, address, bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, 0x2::balance::Balance<T0>, 0x1::option::Option<u64>, 0x1::option::Option<u64>, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>, bool, bool, 0x1::option::Option<u64>, 0x1::option::Option<u128>, u64, u64, vector<PlaceOrderArgument>, 0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        let TradingRequest {
            market_id              : v0,
            account_object_address : v1,
            action                 : v2,
            sender                 : v3,
            is_long                : v4,
            size                   : v5,
            collateral             : v6,
            order_id               : v7,
            position_id            : v8,
            trigger_price          : v9,
            reduce_only            : v10,
            is_stop_order          : v11,
            linked_position_id     : v12,
            trigger_price_key      : v13,
            withdraw_amount        : v14,
            acceptable_price       : v15,
            pre_orders             : v16,
            witnesses              : v17,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17)
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

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: address, arg4: bool, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: 0x2::balance::Balance<T0>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>, arg10: bool, arg11: bool, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u128>, arg14: u64, arg15: u64, arg16: vector<PlaceOrderArgument>) : TradingRequest<T0> {
        TradingRequest<T0>{
            market_id              : arg0,
            account_object_address : arg1,
            action                 : arg2,
            sender                 : arg3,
            is_long                : arg4,
            size                   : arg5,
            collateral             : arg6,
            order_id               : arg7,
            position_id            : arg8,
            trigger_price          : arg9,
            reduce_only            : arg10,
            is_stop_order          : arg11,
            linked_position_id     : arg12,
            trigger_price_key      : arg13,
            withdraw_amount        : arg14,
            acceptable_price       : arg15,
            pre_orders             : arg16,
            witnesses              : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun new_no_collateral<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: address, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: u64) : TradingRequest<T0> {
        new<T0>(arg0, arg1, arg2, arg3, false, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(), 0x2::balance::zero<T0>(), arg4, arg5, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(), false, false, 0x1::option::none<u64>(), 0x1::option::none<u128>(), arg6, arg7, 0x1::vector::empty<PlaceOrderArgument>())
    }

    public fun new_place_order_argument(arg0: bool, arg1: bool, arg2: bool, arg3: u128, arg4: 0x1::option::Option<u128>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: u64) : PlaceOrderArgument {
        PlaceOrderArgument{
            is_long            : arg0,
            is_stop_order      : arg1,
            reduce_only        : arg2,
            size               : arg3,
            trigger_price      : arg4,
            linked_position_id : arg5,
            acceptable_price   : arg6,
            collateral_amount  : arg7,
        }
    }

    public fun order_id<T0>(arg0: &TradingRequest<T0>) : 0x1::option::Option<u64> {
        arg0.order_id
    }

    public fun position_id<T0>(arg0: &TradingRequest<T0>) : 0x1::option::Option<u64> {
        arg0.position_id
    }

    public fun pre_orders<T0>(arg0: &TradingRequest<T0>) : vector<PlaceOrderArgument> {
        arg0.pre_orders
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

