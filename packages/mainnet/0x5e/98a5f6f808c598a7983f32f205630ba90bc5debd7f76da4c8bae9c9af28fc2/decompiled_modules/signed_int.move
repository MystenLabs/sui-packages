module 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::signed_int {
    struct SignedInt has copy, drop, store {
        value: u128,
        is_negative: bool,
    }

    struct QValue has copy, drop {
        q: u128,
        is_negative: bool,
    }

    public fun signed_int(arg0: u128, arg1: bool) : SignedInt {
        SignedInt{
            value       : arg0,
            is_negative : arg1,
        }
    }

    public fun signed_add(arg0: SignedInt, arg1: SignedInt) : SignedInt {
        if (arg0.is_negative == arg1.is_negative) {
            SignedInt{value: arg0.value + arg1.value, is_negative: arg0.is_negative}
        } else if (arg0.value >= arg1.value) {
            SignedInt{value: arg0.value - arg1.value, is_negative: arg0.is_negative}
        } else {
            SignedInt{value: arg1.value - arg0.value, is_negative: arg1.is_negative}
        }
    }

    public fun signed_bound(arg0: SignedInt, arg1: SignedInt, arg2: SignedInt) : SignedInt {
        if (signed_lt(arg0, arg1)) {
            arg1
        } else if (signed_lt(arg2, arg0)) {
            arg2
        } else {
            arg0
        }
    }

    public fun signed_double(arg0: &SignedInt) : SignedInt {
        SignedInt{
            value       : arg0.value * 2,
            is_negative : arg0.is_negative,
        }
    }

    public fun signed_from_u128(arg0: u128) : SignedInt {
        SignedInt{
            value       : arg0,
            is_negative : false,
        }
    }

    public fun signed_gte(arg0: SignedInt, arg1: SignedInt) : bool {
        !signed_lt(arg0, arg1)
    }

    public fun signed_halve(arg0: &SignedInt) : SignedInt {
        SignedInt{
            value       : arg0.value / 2,
            is_negative : arg0.is_negative,
        }
    }

    public fun signed_is_negative(arg0: &SignedInt) : bool {
        arg0.is_negative
    }

    public fun signed_lt(arg0: SignedInt, arg1: SignedInt) : bool {
        arg0.is_negative && !arg1.is_negative || !arg0.is_negative && arg1.is_negative && false || arg0.is_negative && arg0.value > arg1.value || arg0.value < arg1.value
    }

    public fun signed_quarter(arg0: &SignedInt) : SignedInt {
        SignedInt{
            value       : arg0.value / 4,
            is_negative : arg0.is_negative,
        }
    }

    public fun signed_sub(arg0: SignedInt, arg1: SignedInt) : SignedInt {
        let v0 = SignedInt{
            value       : arg1.value,
            is_negative : !arg1.is_negative,
        };
        signed_add(arg0, v0)
    }

    public fun signed_value(arg0: &SignedInt) : u128 {
        arg0.value
    }

    public fun signed_w_div_to_zero(arg0: SignedInt, arg1: SignedInt) : SignedInt {
        SignedInt{
            value       : 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_down(arg0.value, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), arg1.value),
            is_negative : arg0.is_negative != arg1.is_negative,
        }
    }

    public fun signed_w_mul_to_zero(arg0: SignedInt, arg1: SignedInt) : SignedInt {
        SignedInt{
            value       : 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_down(arg0.value, arg1.value, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()),
            is_negative : arg0.is_negative != arg1.is_negative,
        }
    }

    public fun signed_zero() : SignedInt {
        SignedInt{
            value       : 0,
            is_negative : false,
        }
    }

    public fun w_exp(arg0: SignedInt) : SignedInt {
        if (arg0.is_negative && arg0.value > 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::ln_wei()) {
            return signed_zero()
        };
        if (!arg0.is_negative && arg0.value >= 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wexp_upper_bound()) {
            return signed_from_u128(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wexp_upper_value())
        };
        let v0 = if (arg0.is_negative) {
            QValue{q: (arg0.value + 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::ln_2() / 2) / 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::ln_2(), is_negative: true}
        } else {
            QValue{q: (arg0.value + 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::ln_2() / 2) / 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::ln_2(), is_negative: false}
        };
        let v1 = v0;
        let v2 = v1.q * 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::ln_2();
        let v3 = if (arg0.is_negative == v1.is_negative) {
            if (arg0.value >= v2) {
                signed_int(arg0.value - v2, arg0.is_negative)
            } else {
                signed_int(v2 - arg0.value, !arg0.is_negative)
            }
        } else {
            signed_int(arg0.value + v2, arg0.is_negative)
        };
        let v4 = signed_w_mul_to_zero(v3, v3);
        let v5 = SignedInt{
            value       : v4.value / 2,
            is_negative : v4.is_negative,
        };
        let v6 = signed_add(signed_from_u128(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()), signed_add(v3, v5));
        if (v1.is_negative) {
            let v8 = if (v1.q > 127) {
                127
            } else {
                (v1.q as u8)
            };
            SignedInt{value: v6.value >> v8, is_negative: v6.is_negative}
        } else {
            let v9 = if (v1.q > 127) {
                127
            } else {
                (v1.q as u8)
            };
            SignedInt{value: v6.value << v9, is_negative: v6.is_negative}
        }
    }

    // decompiled from Move bytecode v6
}

