module 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::bin {
    struct Bin<phantom T0, phantom T1> has store {
        generation: u64,
        price: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::FP64,
        claim_x: 0x2::balance::Balance<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>,
        claim_y: 0x2::balance::Balance<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>,
        total_shares: u128,
        last_yield_growth_x: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index,
        last_yield_growth_y: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index,
        yield_remainder_x: u64,
        yield_remainder_y: u64,
    }

    struct BinSwapResult has copy, drop {
        consumed: u64,
        out: u64,
        protocol_fee: u64,
        lp_fee: u64,
    }

    public fun destroy_empty<T0, T1>(arg0: Bin<T0, T1>) {
        let Bin {
            generation          : _,
            price               : _,
            claim_x             : v2,
            claim_y             : v3,
            total_shares        : v4,
            last_yield_growth_x : _,
            last_yield_growth_y : _,
            yield_remainder_x   : _,
            yield_remainder_y   : _,
        } = arg0;
        assert!(v4 == 0, 211);
        0x2::balance::destroy_zero<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(v2);
        0x2::balance::destroy_zero<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(v3);
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: &mut 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::Custody<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        if (arg0.total_shares == 0) {
            let v2 = if (v0 > 0) {
                v0
            } else {
                v1
            };
            assert!(v2 > 0, 201);
            arg0.total_shares = (v2 as u128);
            arg0.yield_remainder_x = 0;
            arg0.yield_remainder_y = 0;
            0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&mut arg0.claim_x, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deposit_x<T0, T1>(arg1, arg2));
            0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&mut arg0.claim_y, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deposit_y<T0, T1>(arg1, arg3));
            return ((v2 as u128), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v3 = arg0.total_shares;
        let v4 = 0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x);
        let v5 = 0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y);
        assert!(v4 > 0 || v5 > 0, 208);
        let v6 = deposit_shares(v4, v5, v0, v1, v3);
        assert!(v6 > 0, 201);
        assert_share_supply_headroom(v3, v6);
        arg0.total_shares = v3 + v6;
        0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&mut arg0.claim_x, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deposit_x<T0, T1>(arg1, arg2));
        0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&mut arg0.claim_y, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deposit_y<T0, T1>(arg1, arg3));
        (v6, 0x2::balance::split<T0>(&mut arg2, v0 - deposit_backing_amount(v4, v0, v6, v3)), 0x2::balance::split<T1>(&mut arg3, v1 - deposit_backing_amount(v5, v1, v6, v3)))
    }

    public fun apply_swap_in_x<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: &mut 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::Custody<T0, T1>, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&mut arg0.claim_x, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deposit_x<T0, T1>(arg1, arg2));
    }

    public fun apply_swap_in_y<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: &mut 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::Custody<T0, T1>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&mut arg0.claim_y, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::deposit_y<T0, T1>(arg1, arg2));
    }

    fun assert_quote_conservation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!((arg2 as u128) + (arg3 as u128) <= (arg0 as u128), 213);
        let v0 = if (arg0 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else {
            (arg2 as u128) + (arg3 as u128) > 0
        };
        assert!(v0, 214);
        assert!(arg1 == 0 || arg0 > 0, 215);
    }

    fun assert_share_supply_headroom(arg0: u128, arg1: u128) {
        assert!((arg0 as u256) + (arg1 as u256) <= 340282366920938463463374607431768211455, 209);
    }

    public fun bin_id_offset() : u32 {
        0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bin_id_offset()
    }

    public fun compute_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        assert!(arg2 > 0, 205);
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_ceil((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::fits_u64(v0), 204);
        (v0 as u64)
    }

    fun compute_fee_exclusive(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        assert!(arg2 > 0, 205);
        assert!(arg1 < arg2, 216);
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_ceil((arg0 as u128), (arg1 as u128), (arg2 as u128) - (arg1 as u128));
        assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::fits_u64(v0), 204);
        (v0 as u64)
    }

    fun compute_input_for_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 205);
        assert!(arg1 < arg2, 216);
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_ceil((arg0 as u128), (arg2 as u128), (arg2 as u128) - (arg1 as u128));
        assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::fits_u64(v0), 204);
        (v0 as u64)
    }

    public fun credit_lending_yield<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: &mut 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::Custody<T0, T1>, arg2: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index, arg3: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index) : (u64, u64) {
        if (arg0.total_shares == 0) {
            arg0.last_yield_growth_x = arg2;
            arg0.last_yield_growth_y = arg3;
            arg0.yield_remainder_x = 0;
            arg0.yield_remainder_y = 0;
            return (0, 0)
        };
        let v0 = 0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x);
        let (v1, v2) = 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::apply(v0, arg0.yield_remainder_x, arg0.last_yield_growth_x, arg2);
        let v3 = if (v1 >= v0) {
            v1 - v0
        } else {
            0
        };
        if (v3 > 0) {
            0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&mut arg0.claim_x, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::credit_existing_yield_x<T0, T1>(arg1, v3));
        } else if (v1 < v0) {
            0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::burn_existing_claims_x<T0, T1>(arg1, 0x2::balance::split<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&mut arg0.claim_x, v0 - v1));
        };
        let v4 = 0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y);
        let (v5, v6) = 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::apply(v4, arg0.yield_remainder_y, arg0.last_yield_growth_y, arg3);
        let v7 = if (v5 >= v4) {
            v5 - v4
        } else {
            0
        };
        if (v7 > 0) {
            0x2::balance::join<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&mut arg0.claim_y, 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::credit_existing_yield_y<T0, T1>(arg1, v7));
        } else if (v5 < v4) {
            0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::burn_existing_claims_y<T0, T1>(arg1, 0x2::balance::split<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&mut arg0.claim_y, v4 - v5));
        };
        arg0.last_yield_growth_x = arg2;
        arg0.last_yield_growth_y = arg3;
        arg0.yield_remainder_x = v2;
        arg0.yield_remainder_y = v6;
        (v3, v7)
    }

    fun deposit_backing_amount(arg0: u64, arg1: u64, arg2: u128, arg3: u128) : u64 {
        if (arg0 == 0) {
            0
        } else {
            let v1 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_ceil(arg2, (arg0 as u128), arg3) as u64);
            if (v1 < arg1) {
                v1
            } else {
                arg1
            }
        }
    }

    fun deposit_shares(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128) : u128 {
        if (arg0 > 0 && arg1 > 0) {
            let v1 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg2 as u128), arg4, (arg0 as u128));
            let v2 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg3 as u128), arg4, (arg1 as u128));
            if (v1 < v2) {
                v1
            } else {
                v2
            }
        } else if (arg0 > 0) {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg2 as u128), arg4, (arg0 as u128))
        } else {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg3 as u128), arg4, (arg1 as u128))
        }
    }

    public fun generation<T0, T1>(arg0: &Bin<T0, T1>) : u64 {
        arg0.generation
    }

    public fun get_price(arg0: u32, arg1: u16) : 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::FP64 {
        assert!(arg1 > 0, 205);
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bin_id_offset();
        if (arg0 == v0) {
            return 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::one()
        };
        let (v1, v2) = price_exponent_bound(arg0, arg1);
        assert!(v1 <= v2, 203);
        if (arg0 > v0) {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::pow(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::add(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::one(), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::from_fraction((arg1 as u64), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u64())), v1)
        } else {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::div(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::one(), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::pow(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::add(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::one(), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::from_fraction((arg1 as u64), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u64())), v1))
        }
    }

    public fun init_yield_snapshot<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index, arg2: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index) {
        arg0.last_yield_growth_x = arg1;
        arg0.last_yield_growth_y = arg2;
        arg0.yield_remainder_x = 0;
        arg0.yield_remainder_y = 0;
    }

    public fun is_priceable(arg0: u32, arg1: u16) : bool {
        if (arg1 == 0) {
            return false
        };
        let (v0, v1) = price_exponent_bound(arg0, arg1);
        v0 <= v1
    }

    public fun last_yield_growth_x<T0, T1>(arg0: &Bin<T0, T1>) : 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index {
        arg0.last_yield_growth_x
    }

    public fun last_yield_growth_y<T0, T1>(arg0: &Bin<T0, T1>) : 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index {
        arg0.last_yield_growth_y
    }

    public fun new_at<T0, T1>(arg0: u32, arg1: u16, arg2: u64) : Bin<T0, T1> {
        Bin<T0, T1>{
            generation          : arg2,
            price               : get_price(arg0, arg1),
            claim_x             : 0x2::balance::zero<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(),
            claim_y             : 0x2::balance::zero<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(),
            total_shares        : 0,
            last_yield_growth_x : 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::uninitialized(),
            last_yield_growth_y : 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::uninitialized(),
            yield_remainder_x   : 0,
            yield_remainder_y   : 0,
        }
    }

    public fun preview_credited_reserves<T0, T1>(arg0: &Bin<T0, T1>, arg1: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index, arg2: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index) : (u64, u64) {
        if (arg0.total_shares == 0) {
            return (0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x), 0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y))
        };
        let (v0, _) = 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::apply(0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x), arg0.yield_remainder_x, arg0.last_yield_growth_x, arg1);
        let (v2, _) = 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::apply(0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y), arg0.yield_remainder_y, arg0.last_yield_growth_y, arg2);
        (v0, v2)
    }

    public fun price<T0, T1>(arg0: &Bin<T0, T1>) : 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::FP64 {
        arg0.price
    }

    fun price_exponent_bound(arg0: u32, arg1: u16) : (u32, u32) {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bin_id_offset();
        let v1 = if (arg0 > v0) {
            arg0 - v0
        } else {
            v0 - arg0
        };
        let v2 = if (arg0 > v0) {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::price_range_num() / (arg1 as u32)
        } else {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::price_range_num_low() / (arg1 as u32)
        };
        (v1, v2)
    }

    public fun quote_exact_in(arg0: u64, arg1: u64, arg2: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::FP64, arg3: u64, arg4: u64, arg5: u16, arg6: bool) : BinSwapResult {
        if (arg1 == 0 || arg0 == 0) {
            return BinSwapResult{
                consumed     : 0,
                out          : 0,
                protocol_fee : 0,
                lp_fee       : 0,
            }
        };
        assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::raw(arg2) > 0, 210);
        let v0 = compute_fee(arg0, arg3, arg4);
        let v1 = if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        };
        let v2 = if (arg6) {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::mul_u64_floor_u128(arg2, v1)
        } else {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::div_u64_floor_u128(v1, arg2)
        };
        let (v3, v4, v5) = if (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::fits_u64(v2) && (v2 as u64) <= arg1) {
            let v6 = (v2 as u64);
            let (v7, v8, v9) = if (v6 == 0) {
                (0, 0, 0)
            } else {
                let v10 = if (arg6) {
                    0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::div_u64_ceil_u128(v6, arg2)
                } else {
                    0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::mul_u64_ceil_u128(arg2, v6)
                };
                assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::fits_u64(v10), 206);
                let v11 = (v10 as u64);
                let (v12, v13) = if (v11 < v1) {
                    let v14 = compute_fee_exclusive(v11, arg3, arg4);
                    (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_add_u64(v11, v14), v14)
                } else {
                    (arg0, v0)
                };
                (v6, v13, v12)
            };
            (v9, v7, v8)
        } else {
            let v15 = if (arg6) {
                0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::div_u64_ceil_u128(arg1, arg2)
            } else {
                0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::mul_u64_ceil_u128(arg2, arg1)
            };
            assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::fits_u64(v15), 206);
            let v16 = (v15 as u64);
            let v17 = compute_fee_exclusive(v16, arg3, arg4);
            (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_add_u64(v16, v17), arg1, v17)
        };
        let (v18, v19) = split_fee(v5, arg5);
        assert!(v3 <= arg0, 212);
        assert_quote_conservation(v3, v4, v18, v19, arg3);
        BinSwapResult{
            consumed     : v3,
            out          : v4,
            protocol_fee : v18,
            lp_fee       : v19,
        }
    }

    public fun quote_exact_out(arg0: u64, arg1: u64, arg2: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::FP64, arg3: u64, arg4: u64, arg5: u16, arg6: bool) : BinSwapResult {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        if (v0 == 0) {
            return BinSwapResult{
                consumed     : 0,
                out          : 0,
                protocol_fee : 0,
                lp_fee       : 0,
            }
        };
        assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::raw(arg2) > 0, 210);
        let v1 = if (arg6) {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::div_u64_ceil_u128(v0, arg2)
        } else {
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::mul_u64_ceil_u128(arg2, v0)
        };
        assert!(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::fits_u64(v1), 206);
        let v2 = (v1 as u64);
        let v3 = compute_input_for_output(v2, arg3, arg4);
        let (v4, v5) = split_fee(v3 - v2, arg5);
        BinSwapResult{
            consumed     : v3,
            out          : v0,
            protocol_fee : v4,
            lp_fee       : v5,
        }
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: &mut 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::Custody<T0, T1>, arg2: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.total_shares > 0, 201);
        assert!(arg2 <= arg0.total_shares, 207);
        arg0.total_shares = arg0.total_shares - arg2;
        (0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::withdraw_x<T0, T1>(arg1, 0x2::balance::split<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&mut arg0.claim_x, (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x) as u128), arg2, arg0.total_shares) as u64))), 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::withdraw_y<T0, T1>(arg1, 0x2::balance::split<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&mut arg0.claim_y, (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y) as u128), arg2, arg0.total_shares) as u64))))
    }

    public fun reserve_x<T0, T1>(arg0: &Bin<T0, T1>) : u64 {
        0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x)
    }

    public fun reserve_y<T0, T1>(arg0: &Bin<T0, T1>) : u64 {
        0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y)
    }

    public fun result_consumed(arg0: &BinSwapResult) : u64 {
        arg0.consumed
    }

    public fun result_lp_fee(arg0: &BinSwapResult) : u64 {
        arg0.lp_fee
    }

    public fun result_out(arg0: &BinSwapResult) : u64 {
        arg0.out
    }

    public fun result_protocol_fee(arg0: &BinSwapResult) : u64 {
        arg0.protocol_fee
    }

    public fun seal_yield_interval_before_reserve_growth<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index, arg2: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::yield_index::Index, arg3: u64, arg4: u64) {
        if (arg3 > 0) {
            assert!(arg0.last_yield_growth_x == arg1, 218);
        };
        if (arg4 > 0) {
            assert!(arg0.last_yield_growth_y == arg2, 218);
        };
    }

    fun split_fee(arg0: u64, arg1: u16) : (u64, u64) {
        let v0 = (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg0 as u128), (arg1 as u128), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u128()) as u64);
        (v0, arg0 - v0)
    }

    public fun swap_exact_out_with_fees<T0, T1>(arg0: &Bin<T0, T1>, arg1: u64, arg2: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::FP64, arg3: u64, arg4: u64, arg5: u16, arg6: bool) : BinSwapResult {
        let v0 = if (arg6) {
            0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y)
        } else {
            0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x)
        };
        quote_exact_out(arg1, v0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun swap_with_fees<T0, T1>(arg0: &Bin<T0, T1>, arg1: u64, arg2: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::FP64, arg3: u64, arg4: u64, arg5: u16, arg6: bool) : BinSwapResult {
        let v0 = if (arg6) {
            0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&arg0.claim_y)
        } else {
            0x2::balance::value<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&arg0.claim_x)
        };
        quote_exact_in(arg1, v0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun take_out_x<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: u64) : 0x2::balance::Balance<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>> {
        0x2::balance::split<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::XToken<T0>>(&mut arg0.claim_x, arg1)
    }

    public fun take_out_y<T0, T1>(arg0: &mut Bin<T0, T1>, arg1: u64) : 0x2::balance::Balance<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>> {
        0x2::balance::split<0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::custody::YToken<T1>>(&mut arg0.claim_y, arg1)
    }

    public fun total_shares<T0, T1>(arg0: &Bin<T0, T1>) : u128 {
        arg0.total_shares
    }

    // decompiled from Move bytecode v7
}

