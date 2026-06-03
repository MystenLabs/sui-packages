module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        position_id: u64,
        account_object_address: address,
        market_id: 0x2::object::ID,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_token: 0x1::type_name::TypeName,
        collateral_decimal: u8,
        collateral_amount: u64,
        average_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        entry_borrow_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        pool_reserve_amount: u64,
        borrow_reserve_amount: u64,
        entry_funding_sign: bool,
        entry_funding_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        unrealized_borrow_fee: u64,
        unrealized_funding_sign: bool,
        unrealized_funding_fee: u64,
        unrealized_trading_fee: u64,
        linked_order_ids: vector<u64>,
        linked_order_price_keys: vector<u128>,
        create_timestamp: u64,
        update_timestamp: u64,
    }

    struct Order has store, key {
        id: 0x2::object::UID,
        order_id: u64,
        account_object_address: address,
        market_id: 0x2::object::ID,
        linked_position_id: 0x1::option::Option<u64>,
        collateral_token: 0x1::type_name::TypeName,
        collateral_decimal: u8,
        collateral_amount: u64,
        is_long: bool,
        reduce_only: bool,
        is_stop_order: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        trigger_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        acceptable_price: u64,
        leverage_bps: u64,
        oracle_price_at_creation: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        create_timestamp: u64,
    }

    public(friend) fun add_linked_order(arg0: &mut Position, arg1: u64, arg2: u128) {
        if (0x1::vector::length<u64>(&arg0.linked_order_ids) >= 5) {
            abort 13906836171503435781
        };
        0x1::vector::push_back<u64>(&mut arg0.linked_order_ids, arg1);
        0x1::vector::push_back<u128>(&mut arg0.linked_order_price_keys, arg2);
    }

    public(friend) fun add_pool_reserve(arg0: &mut Position, arg1: u64) {
        arg0.pool_reserve_amount = arg0.pool_reserve_amount + arg1;
    }

    public(friend) fun add_trading_fee(arg0: &mut Position, arg1: u64) {
        arg0.unrealized_trading_fee = arg0.unrealized_trading_fee + arg1;
    }

    fun assert_order_collateral_type<T0>(arg0: &Order) {
        if (arg0.collateral_token != 0x1::type_name::with_defining_ids<T0>()) {
            abort 13906835514373308419
        };
    }

    fun assert_position_collateral_type<T0>(arg0: &Position) {
        if (arg0.collateral_token != 0x1::type_name::with_defining_ids<T0>()) {
            abort 13906835488603504643
        };
    }

    public fun calculate_borrow_fee(arg0: &Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : u64 {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lte(arg1, arg0.entry_borrow_index)) {
            return 0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg1, arg0.entry_borrow_index), arg0.borrow_reserve_amount))
    }

    public fun calculate_funding_fee(arg0: &Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: bool, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) : (bool, u64) {
        let (v0, v1) = if (arg2 == arg0.entry_funding_sign) {
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::gte(arg3, arg0.entry_funding_index)) {
                (arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(arg3, arg0.entry_funding_index))
            } else {
                (!arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(arg0.entry_funding_index, arg3))
            }
        } else {
            (arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(arg3, arg0.entry_funding_index))
        };
        let v2 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::usd_to_amount(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val((((0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(arg0.size) as u256) * 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(v1) / 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::precision()) as u128)), arg0.collateral_decimal, arg1);
        let v3 = arg0.is_long && v0 || !v0;
        if (v3 == arg0.unrealized_funding_sign) {
            (v3, arg0.unrealized_funding_fee + v2)
        } else if (arg0.unrealized_funding_fee >= v2) {
            (arg0.unrealized_funding_sign, arg0.unrealized_funding_fee - v2)
        } else {
            (v3, v2 - arg0.unrealized_funding_fee)
        }
    }

    fun calculate_pool_reserve_amount_from_values(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: u8, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : u64 {
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::usd_to_amount(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0, arg1), arg2, arg3)
    }

    fun calculate_reserve_amount(arg0: &Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : u64 {
        calculate_reserve_amount_from_values(arg0.size, arg1, arg0.collateral_amount, arg0.collateral_decimal, arg2)
    }

    fun calculate_reserve_amount_from_values(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: u64, arg3: u8, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : u64 {
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::saturating_sub(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::usd_to_amount(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0, arg1), arg3, arg4), arg2)
    }

    public fun check_order_fillable(arg0: &Order, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : bool {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0.trigger_price, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return true
        };
        arg0.is_long && (arg0.is_stop_order && 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg1, arg0.trigger_price) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lte(arg1, arg0.trigger_price)) || arg0.is_stop_order && 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lte(arg1, arg0.trigger_price) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg1, arg0.trigger_price)
    }

    public(friend) fun create_order<T0>(arg0: u64, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::option::Option<u64>, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T0>, arg6: u8, arg7: bool, arg8: bool, arg9: bool, arg10: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg11: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg12: u64, arg13: u64, arg14: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : Order {
        0x2::balance::join<T0>(arg5, arg4);
        Order{
            id                       : 0x2::object::new(arg16),
            order_id                 : arg0,
            account_object_address   : arg1,
            market_id                : arg2,
            linked_position_id       : arg3,
            collateral_token         : 0x1::type_name::with_defining_ids<T0>(),
            collateral_decimal       : arg6,
            collateral_amount        : 0x2::balance::value<T0>(&arg4),
            is_long                  : arg7,
            reduce_only              : arg8,
            is_stop_order            : arg9,
            size                     : arg10,
            trigger_price            : arg11,
            acceptable_price         : arg12,
            leverage_bps             : arg13,
            oracle_price_at_creation : arg14,
            create_timestamp         : 0x2::clock::timestamp_ms(arg15),
        }
    }

    public(friend) fun create_position<T0>(arg0: u64, arg1: address, arg2: 0x2::object::ID, arg3: bool, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::balance::Balance<T0>, arg7: u8, arg8: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg11: bool, arg12: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : Position {
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x2::balance::join<T0>(arg6, arg5);
        Position{
            id                      : 0x2::object::new(arg15),
            position_id             : arg0,
            account_object_address  : arg1,
            market_id               : arg2,
            is_long                 : arg3,
            size                    : arg4,
            collateral_token        : 0x1::type_name::with_defining_ids<T0>(),
            collateral_decimal      : arg7,
            collateral_amount       : v0,
            average_price           : arg8,
            entry_borrow_index      : arg10,
            pool_reserve_amount     : calculate_pool_reserve_amount_from_values(arg4, arg8, arg7, arg9),
            borrow_reserve_amount   : calculate_reserve_amount_from_values(arg4, arg8, v0, arg7, arg9),
            entry_funding_sign      : arg11,
            entry_funding_index     : arg12,
            unrealized_borrow_fee   : 0,
            unrealized_funding_sign : true,
            unrealized_funding_fee  : 0,
            unrealized_trading_fee  : arg13,
            linked_order_ids        : vector[],
            linked_order_price_keys : vector[],
            create_timestamp        : 0x2::clock::timestamp_ms(arg14),
            update_timestamp        : 0x2::clock::timestamp_ms(arg14),
        }
    }

    public(friend) fun deposit_collateral<T0>(arg0: &mut Position, arg1: &mut 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>) {
        assert_position_collateral_type<T0>(arg0);
        0x2::balance::join<T0>(arg1, arg2);
        arg0.collateral_amount = arg0.collateral_amount + 0x2::balance::value<T0>(&arg2);
    }

    public fun get_order_id(arg0: &Order) : u64 {
        arg0.order_id
    }

    public fun get_position_id(arg0: &Position) : u64 {
        arg0.position_id
    }

    public fun is_liquidatable(arg0: &Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: bool, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) : bool {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(arg0.collateral_amount, arg0.collateral_decimal, arg2);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(arg0.unrealized_borrow_fee + calculate_borrow_fee(arg0, arg5) + arg0.unrealized_trading_fee, arg0.collateral_decimal, arg2), arg3);
        let (v2, v3) = calculate_funding_fee(arg0, arg2, arg6, arg7);
        let v4 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(v3, arg0.collateral_decimal, arg2);
        let v5 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        let v6 = v5;
        let (v7, v8) = unrealized_pnl(arg0, arg1);
        let v9 = if (v7) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v0, v8)
        } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v0, v8)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v0, v8)
        } else {
            v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v8, v0));
            v5
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v9, v1)) {
            v9 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v9, v1);
        } else {
            v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v6, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v1, v9));
            v9 = v5;
        };
        if (v2) {
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v9, v4)) {
                v9 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v9, v4);
            } else {
                v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v6, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v4, v9));
                v9 = v5;
            };
        } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(v4, v5)) {
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v6, v4)) {
                v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v6, v4);
            } else {
                v9 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v9, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v4, v6));
                v6 = v5;
            };
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(v6, v5)) {
            return true
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lte(v9, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0.size, arg1)))
    }

    public(friend) fun max_linked_orders() : u64 {
        5
    }

    public fun order_acceptable_price(arg0: &Order) : u64 {
        arg0.acceptable_price
    }

    public fun order_account_object_address(arg0: &Order) : address {
        arg0.account_object_address
    }

    public fun order_collateral_amount(arg0: &Order) : u64 {
        arg0.collateral_amount
    }

    public fun order_collateral_decimal(arg0: &Order) : u8 {
        arg0.collateral_decimal
    }

    public fun order_collateral_token(arg0: &Order) : 0x1::type_name::TypeName {
        arg0.collateral_token
    }

    public fun order_create_timestamp(arg0: &Order) : u64 {
        arg0.create_timestamp
    }

    public fun order_is_long(arg0: &Order) : bool {
        arg0.is_long
    }

    public fun order_is_stop_order(arg0: &Order) : bool {
        arg0.is_stop_order
    }

    public fun order_leverage_bps(arg0: &Order) : u64 {
        arg0.leverage_bps
    }

    public fun order_linked_position_id(arg0: &Order) : 0x1::option::Option<u64> {
        arg0.linked_position_id
    }

    public fun order_market_id(arg0: &Order) : 0x2::object::ID {
        arg0.market_id
    }

    public fun order_reduce_only(arg0: &Order) : bool {
        arg0.reduce_only
    }

    public fun order_size(arg0: &Order) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.size
    }

    public fun order_trigger_price(arg0: &Order) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.trigger_price
    }

    public fun order_type_tag(arg0: &Order) : u8 {
        if (arg0.is_long) {
            if (arg0.is_stop_order) {
                2
            } else {
                0
            }
        } else if (arg0.is_stop_order) {
            3
        } else {
            1
        }
    }

    public fun position_account_object_address(arg0: &Position) : address {
        arg0.account_object_address
    }

    public fun position_average_price(arg0: &Position) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.average_price
    }

    public fun position_borrow_reserve_amount(arg0: &Position) : u64 {
        arg0.borrow_reserve_amount
    }

    public fun position_collateral_amount(arg0: &Position) : u64 {
        arg0.collateral_amount
    }

    public fun position_collateral_decimal(arg0: &Position) : u8 {
        arg0.collateral_decimal
    }

    public fun position_collateral_token(arg0: &Position) : 0x1::type_name::TypeName {
        arg0.collateral_token
    }

    public fun position_create_timestamp(arg0: &Position) : u64 {
        arg0.create_timestamp
    }

    public fun position_entry_borrow_index(arg0: &Position) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.entry_borrow_index
    }

    public fun position_entry_funding_index(arg0: &Position) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        arg0.entry_funding_index
    }

    public fun position_entry_funding_sign(arg0: &Position) : bool {
        arg0.entry_funding_sign
    }

    public fun position_fee_state(arg0: &Position) : (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, u64, bool, u64) {
        (arg0.entry_borrow_index, arg0.entry_funding_sign, arg0.entry_funding_index, arg0.unrealized_borrow_fee, arg0.unrealized_funding_sign, arg0.unrealized_funding_fee)
    }

    public fun position_is_long(arg0: &Position) : bool {
        arg0.is_long
    }

    public fun position_linked_order_ids(arg0: &Position) : vector<u64> {
        arg0.linked_order_ids
    }

    public fun position_linked_order_price_keys(arg0: &Position) : vector<u128> {
        arg0.linked_order_price_keys
    }

    public fun position_market_id(arg0: &Position) : 0x2::object::ID {
        arg0.market_id
    }

    public fun position_pool_reserve_amount(arg0: &Position) : u64 {
        arg0.pool_reserve_amount
    }

    public fun position_size(arg0: &Position) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.size
    }

    public fun position_unrealized_borrow_fee(arg0: &Position) : u64 {
        arg0.unrealized_borrow_fee
    }

    public fun position_unrealized_funding_fee(arg0: &Position) : u64 {
        arg0.unrealized_funding_fee
    }

    public fun position_unrealized_funding_sign(arg0: &Position) : bool {
        arg0.unrealized_funding_sign
    }

    public fun position_unrealized_trading_fee(arg0: &Position) : u64 {
        arg0.unrealized_trading_fee
    }

    public fun position_update_timestamp(arg0: &Position) : u64 {
        arg0.update_timestamp
    }

    public(friend) fun realize_partial_fees(arg0: &mut Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : (u64, bool, u64, u64) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg1, v0) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg2, v0)) {
            return (0, arg0.unrealized_funding_sign, 0, 0)
        };
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(arg1);
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(arg2);
        let v3 = (((arg0.unrealized_borrow_fee as u128) * v1 / v2) as u64);
        let v4 = (((arg0.unrealized_funding_fee as u128) * v1 / v2) as u64);
        let v5 = (((arg0.unrealized_trading_fee as u128) * v1 / v2) as u64);
        arg0.unrealized_borrow_fee = arg0.unrealized_borrow_fee - v3;
        arg0.unrealized_funding_fee = arg0.unrealized_funding_fee - v4;
        arg0.unrealized_trading_fee = arg0.unrealized_trading_fee - v5;
        (v3, arg0.unrealized_funding_sign, v4, v5)
    }

    public(friend) fun realize_pool_reserve(arg0: &mut Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : u64 {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        let v1 = if (arg0.pool_reserve_amount == 0) {
            true
        } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg1, v0)) {
            true
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg2, v0)
        };
        if (v1) {
            return 0
        };
        let v2 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg1, arg2)) {
            arg0.pool_reserve_amount
        } else {
            (((arg0.pool_reserve_amount as u128) * 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(arg1) / 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(arg2)) as u64)
        };
        arg0.pool_reserve_amount = arg0.pool_reserve_amount - v2;
        v2
    }

    public(friend) fun refresh_borrow_reserve(arg0: &mut Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        arg0.borrow_reserve_amount = calculate_reserve_amount(arg0, arg1, arg2);
    }

    public(friend) fun remove_linked_order(arg0: &mut Position, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.linked_order_ids)) {
            if (*0x1::vector::borrow<u64>(&arg0.linked_order_ids, v0) == arg1) {
                0x1::vector::swap_remove<u64>(&mut arg0.linked_order_ids, v0);
                0x1::vector::swap_remove<u128>(&mut arg0.linked_order_price_keys, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun remove_order<T0>(arg0: Order, arg1: &mut 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        assert_order_collateral_type<T0>(&arg0);
        let Order {
            id                       : v0,
            order_id                 : _,
            account_object_address   : _,
            market_id                : _,
            linked_position_id       : _,
            collateral_token         : _,
            collateral_decimal       : _,
            collateral_amount        : v7,
            is_long                  : _,
            reduce_only              : _,
            is_stop_order            : _,
            size                     : _,
            trigger_price            : _,
            acceptable_price         : _,
            leverage_bps             : _,
            oracle_price_at_creation : _,
            create_timestamp         : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::split<T0>(arg1, v7)
    }

    public(friend) fun remove_position<T0>(arg0: Position, arg1: &mut 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T0>, vector<u64>, vector<u128>) {
        assert_position_collateral_type<T0>(&arg0);
        let Position {
            id                      : v0,
            position_id             : _,
            account_object_address  : _,
            market_id               : _,
            is_long                 : _,
            size                    : _,
            collateral_token        : _,
            collateral_decimal      : _,
            collateral_amount       : v8,
            average_price           : _,
            entry_borrow_index      : _,
            pool_reserve_amount     : _,
            borrow_reserve_amount   : _,
            entry_funding_sign      : _,
            entry_funding_index     : _,
            unrealized_borrow_fee   : _,
            unrealized_funding_sign : _,
            unrealized_funding_fee  : _,
            unrealized_trading_fee  : _,
            linked_order_ids        : v19,
            linked_order_price_keys : v20,
            create_timestamp        : _,
            update_timestamp        : _,
        } = arg0;
        0x2::object::delete(v0);
        (0x2::balance::split<T0>(arg1, v8), v19, v20)
    }

    public(friend) fun set_linked_position_id(arg0: &mut Order, arg1: u64) {
        arg0.linked_position_id = 0x1::option::some<u64>(arg1);
    }

    public fun unrealized_pnl(arg0: &Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : (bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0.size, arg0.average_price);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0.size, arg1);
        if (arg0.is_long) {
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v1, v0)) {
                (true, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v1, v0))
            } else {
                (false, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v0, v1))
            }
        } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v0, v1)) {
            (true, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v0, v1))
        } else {
            (false, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v1, v0))
        }
    }

    public(friend) fun update_fees(arg0: &mut Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: bool, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        arg0.unrealized_borrow_fee = arg0.unrealized_borrow_fee + calculate_borrow_fee(arg0, arg2);
        arg0.entry_borrow_index = arg2;
        let (v0, v1) = calculate_funding_fee(arg0, arg1, arg3, arg4);
        arg0.unrealized_funding_sign = v0;
        arg0.unrealized_funding_fee = v1;
        arg0.entry_funding_sign = arg3;
        arg0.entry_funding_index = arg4;
    }

    public(friend) fun update_order(arg0: &mut Order, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: u64) {
        arg0.size = arg1;
        arg0.trigger_price = arg2;
        arg0.leverage_bps = arg3;
    }

    public(friend) fun update_position_size(arg0: &mut Position, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: bool, arg4: &0x2::clock::Clock) {
        arg0.size = arg1;
        arg0.average_price = arg2;
        arg0.is_long = arg3;
        arg0.update_timestamp = 0x2::clock::timestamp_ms(arg4);
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &mut Position, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_position_collateral_type<T0>(arg0);
        if (arg0.collateral_amount < arg2) {
            abort 13906835394114093057
        };
        arg0.collateral_amount = arg0.collateral_amount - arg2;
        0x2::balance::split<T0>(arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

