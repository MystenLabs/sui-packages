module 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price {
    struct Pair has copy, drop, store {
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
    }

    struct RawPrice has copy, drop, store {
        value: 0x1::uq32_32::UQ32_32,
    }

    struct PairPrice<phantom T0, phantom T1> has copy, drop, store {
        inner: RawPrice,
    }

    struct RawPairPrice has copy, drop, store {
        pair: Pair,
        value: RawPrice,
    }

    public fun base(arg0: &Pair) : 0x1::type_name::TypeName {
        arg0.base
    }

    public fun calc_base_out(arg0: &RawPrice, arg1: u64) : u64 {
        0x1::uq32_32::int_div(arg1, arg0.value)
    }

    public fun calc_base_out_for_pair_price<T0, T1>(arg0: &PairPrice<T0, T1>, arg1: u64) : u64 {
        calc_base_out(&arg0.inner, arg1)
    }

    public fun calc_base_out_from_balance_for_pair_price<T0, T1>(arg0: &PairPrice<T0, T1>, arg1: &0x2::balance::Balance<T1>) : u64 {
        calc_base_out_for_pair_price<T0, T1>(arg0, 0x2::balance::value<T1>(arg1))
    }

    public fun calc_quote_out(arg0: &RawPrice, arg1: u64) : u64 {
        0x1::uq32_32::int_mul(arg1, arg0.value)
    }

    public fun calc_quote_out_from_balance_for_pair_price<T0, T1>(arg0: &PairPrice<T0, T1>, arg1: &0x2::balance::Balance<T0>) : u64 {
        calc_quote_out(&arg0.inner, 0x2::balance::value<T0>(arg1))
    }

    public fun into_inner(arg0: RawPrice) : 0x1::uq32_32::UQ32_32 {
        arg0.value
    }

    public fun into_pair_price<T0, T1>(arg0: RawPrice) : PairPrice<T0, T1> {
        PairPrice<T0, T1>{inner: arg0}
    }

    public fun into_raw_pair_price<T0, T1>(arg0: PairPrice<T0, T1>) : RawPairPrice {
        RawPairPrice{
            pair  : new_pair<T0, T1>(),
            value : arg0.inner,
        }
    }

    public fun new_pair<T0, T1>() : Pair {
        new_pair_from_raw(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
    }

    public fun new_pair_from_raw(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : Pair {
        Pair{
            base  : arg0,
            quote : arg1,
        }
    }

    public fun new_pair_price<T0, T1>(arg0: 0x1::uq32_32::UQ32_32) : PairPrice<T0, T1> {
        PairPrice<T0, T1>{inner: new_raw_price(arg0)}
    }

    public fun new_raw_pair_price(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: 0x1::uq32_32::UQ32_32) : RawPairPrice {
        RawPairPrice{
            pair  : new_pair_from_raw(arg0, arg1),
            value : new_raw_price(arg2),
        }
    }

    public fun new_raw_price(arg0: 0x1::uq32_32::UQ32_32) : RawPrice {
        RawPrice{value: arg0}
    }

    public fun quote(arg0: &Pair) : 0x1::type_name::TypeName {
        arg0.quote
    }

    public fun raw_pair_price_into_pair_and_raw_price(arg0: RawPairPrice) : (Pair, RawPrice) {
        let RawPairPrice {
            pair  : v0,
            value : v1,
        } = arg0;
        (v0, v1)
    }

    public fun to_inverse(arg0: &Pair) : Pair {
        Pair{
            base  : arg0.quote,
            quote : arg0.base,
        }
    }

    // decompiled from Move bytecode v6
}

