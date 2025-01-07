module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price {
    struct Price has drop, store {
        conversion_rate: u64,
        timestamp: u64,
    }

    struct PriceAdded has copy, drop {
        conversion_rate: u64,
        timestamp: u64,
        is_base_conversion: bool,
        reference_pool: 0x2::object::ID,
        target_pool: 0x2::object::ID,
    }

    struct DeepPrice has drop, store {
        base_prices: vector<Price>,
        cumulative_base: u64,
        quote_prices: vector<Price>,
        cumulative_quote: u64,
    }

    struct OrderDeepPrice has copy, drop, store {
        asset_is_base: bool,
        deep_per_asset: u64,
    }

    public(friend) fun empty() : DeepPrice {
        DeepPrice{
            base_prices      : 0x1::vector::empty<Price>(),
            cumulative_base  : 0,
            quote_prices     : 0x1::vector::empty<Price>(),
            cumulative_quote : 0,
        }
    }

    public(friend) fun add_price_point(arg0: &mut DeepPrice, arg1: u64, arg2: u64, arg3: bool) {
        assert!(last_insert_timestamp(arg0, arg3) + 60000 < arg2, 1);
        let v0 = if (arg3) {
            &mut arg0.base_prices
        } else {
            &mut arg0.quote_prices
        };
        let v1 = Price{
            conversion_rate : arg1,
            timestamp       : arg2,
        };
        0x1::vector::push_back<Price>(v0, v1);
        if (arg3) {
            arg0.cumulative_base = arg0.cumulative_base + arg1;
            while (0x1::vector::length<Price>(v0) == 100 + 1 || 0x1::vector::borrow<Price>(v0, 0).timestamp + 86400000 < arg2) {
                arg0.cumulative_base = arg0.cumulative_base - 0x1::vector::borrow<Price>(v0, 0).conversion_rate;
                0x1::vector::remove<Price>(v0, 0);
            };
        } else {
            arg0.cumulative_quote = arg0.cumulative_quote + arg1;
            while (0x1::vector::length<Price>(v0) == 100 + 1 || 0x1::vector::borrow<Price>(v0, 0).timestamp + 86400000 < arg2) {
                arg0.cumulative_quote = arg0.cumulative_quote - 0x1::vector::borrow<Price>(v0, 0).conversion_rate;
                0x1::vector::remove<Price>(v0, 0);
            };
        };
    }

    public fun asset_is_base(arg0: &OrderDeepPrice) : bool {
        arg0.asset_is_base
    }

    fun calculate_order_deep_price(arg0: &DeepPrice, arg1: bool) : (bool, u64) {
        if (arg1) {
            return (false, 0)
        };
        assert!(last_insert_timestamp(arg0, true) > 0 || last_insert_timestamp(arg0, false) > 0, 2);
        let v0 = last_insert_timestamp(arg0, false) == 0;
        let v1 = if (v0) {
            arg0.cumulative_base
        } else {
            arg0.cumulative_quote
        };
        let v2 = if (v0) {
            0x1::vector::length<Price>(&arg0.base_prices)
        } else {
            0x1::vector::length<Price>(&arg0.quote_prices)
        };
        (v0, v1 / v2)
    }

    public fun deep_per_asset(arg0: &OrderDeepPrice) : u64 {
        arg0.deep_per_asset
    }

    public(friend) fun deep_quantity(arg0: &OrderDeepPrice, arg1: u64, arg2: u64) : u64 {
        if (arg0.asset_is_base) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(arg1, arg0.deep_per_asset)
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(arg2, arg0.deep_per_asset)
        }
    }

    public(friend) fun deep_quantity_u128(arg0: &OrderDeepPrice, arg1: u128, arg2: u128) : u128 {
        if (arg0.asset_is_base) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul_u128(arg1, (arg0.deep_per_asset as u128))
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul_u128(arg2, (arg0.deep_per_asset as u128))
        }
    }

    public(friend) fun emit_deep_price_added(arg0: u64, arg1: u64, arg2: bool, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        let v0 = PriceAdded{
            conversion_rate    : arg0,
            timestamp          : arg1,
            is_base_conversion : arg2,
            reference_pool     : arg3,
            target_pool        : arg4,
        };
        0x2::event::emit<PriceAdded>(v0);
    }

    public(friend) fun get_order_deep_price(arg0: &DeepPrice, arg1: bool) : OrderDeepPrice {
        let (v0, v1) = calculate_order_deep_price(arg0, arg1);
        new_order_deep_price(v0, v1)
    }

    fun last_insert_timestamp(arg0: &DeepPrice, arg1: bool) : u64 {
        let v0 = if (arg1) {
            &arg0.base_prices
        } else {
            &arg0.quote_prices
        };
        if (0x1::vector::length<Price>(v0) > 0) {
            0x1::vector::borrow<Price>(v0, 0x1::vector::length<Price>(v0) - 1).timestamp
        } else {
            0
        }
    }

    public(friend) fun new_order_deep_price(arg0: bool, arg1: u64) : OrderDeepPrice {
        OrderDeepPrice{
            asset_is_base  : arg0,
            deep_per_asset : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

