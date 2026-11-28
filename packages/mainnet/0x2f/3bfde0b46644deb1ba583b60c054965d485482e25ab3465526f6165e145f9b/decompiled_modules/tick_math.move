module 0x2f3bfde0b46644deb1ba583b60c054965d485482e25ab3465526f6165e145f9b::tick_math {
    public fun get_sqrt_price_at_tick(arg0: u32, arg1: bool) : u128 {
        assert!(arg0 <= 443636, 1);
        let v0 = mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(mul_step(340282366920938463463374607431768211456, arg0, 0, 340265354078544963557816517032075149313), arg0, 1, 340248342086729790484326174814286782778), arg0, 2, 340214320654664324051920982716015181260), arg0, 3, 340146287995602323631171512101879684304), arg0, 4, 340010263488231146823593991679159461444), arg0, 5, 339738377640345403697157401104375502016), arg0, 6, 339195258003219555707034227454543997025), arg0, 7, 338111622100601834656805679988414885971), arg0, 8, 335954724994790223023589805789778977700), arg0, 9, 331682121138379247127172139078559817300), arg0, 10, 323299236684853023288211250268160618739), arg0, 11, 307163716377032989948697243942600083929), arg0, 12, 277268403626896220162999269216087595045), arg0, 13, 225923453940442621947126027127485391333), arg0, 14, 149997214084966997727330242082538205943), arg0, 15, 66119101136024775622716233608466517926), arg0, 16, 12847376061809297530290974190478138313), arg0, 17, 485053260817066172746253684029974020), arg0, 18, 691415978906521570653435304214168);
        let v1 = v0;
        if (!arg1 && arg0 > 0) {
            v1 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v0;
        };
        ((v1 >> 64) as u128)
    }

    public fun get_tick_at_sqrt_price(arg0: u128) : (u32, bool) {
        assert!(arg0 >= 4295048016 && arg0 <= 79226673515401279992447579061, 2);
        let v0 = 0;
        let v1 = 887272;
        while (v0 < v1) {
            let v2 = v0 + (v1 - v0 + 1) / 2;
            if (price_at_index_le(v2, arg0)) {
                v0 = v2;
                continue
            };
            v1 = v2 - 1;
        };
        index_to_tick(v0)
    }

    fun index_to_tick(arg0: u32) : (u32, bool) {
        if (arg0 >= 443636) {
            (arg0 - 443636, false)
        } else {
            (443636 - arg0, true)
        }
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579061
    }

    public fun max_tick() : u32 {
        443636
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    fun mul_step(arg0: u256, arg1: u32, arg2: u8, arg3: u256) : u256 {
        if ((arg1 >> arg2) % 2 == 1) {
            arg0 * arg3 >> 128
        } else {
            arg0
        }
    }

    fun price_at_index_le(arg0: u32, arg1: u128) : bool {
        let (v0, v1) = index_to_tick(arg0);
        get_sqrt_price_at_tick(v0, v1) <= arg1
    }

    // decompiled from Move bytecode v7
}

