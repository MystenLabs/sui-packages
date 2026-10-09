module 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math {
    public fun align_down(arg0: u32, arg1: u32) : u32 {
        let v0 = if (arg1 > 0) {
            if (arg0 >= 80652) {
                arg0 <= 967924
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        if (arg0 >= 524288) {
            arg0 - (arg0 - 524288) % arg1
        } else {
            524288 - 0x1::u32::div_ceil(524288 - arg0, arg1) * arg1
        }
    }

    fun factor(arg0: u8) : u256 {
        if (arg0 == 0) {
            340265354078544963557816517032075149313
        } else if (arg0 == 1) {
            340248342086729790484326174814286782778
        } else if (arg0 == 2) {
            340214320654664324051920982716015181260
        } else if (arg0 == 3) {
            340146287995602323631171512101879684304
        } else if (arg0 == 4) {
            340010263488231146823593991679159461444
        } else if (arg0 == 5) {
            339738377640345403697157401104375502016
        } else if (arg0 == 6) {
            339195258003219555707034227454543997025
        } else if (arg0 == 7) {
            338111622100601834656805679988414885971
        } else if (arg0 == 8) {
            335954724994790223023589805789778977700
        } else if (arg0 == 9) {
            331682121138379247127172139078559817300
        } else if (arg0 == 10) {
            323299236684853023288211250268160618739
        } else if (arg0 == 11) {
            307163716377032989948697243942600083929
        } else if (arg0 == 12) {
            277268403626896220162999269216087595045
        } else if (arg0 == 13) {
            225923453940442621947126027127485391333
        } else if (arg0 == 14) {
            149997214084966997727330242082538205943
        } else if (arg0 == 15) {
            66119101136024775622716233608466517926
        } else if (arg0 == 16) {
            12847376061809297530290974190478138313
        } else if (arg0 == 17) {
            485053260817066172746253684029974020
        } else {
            691415978906521570653435304214168
        }
    }

    public fun full_range(arg0: u32) : (u32, u32) {
        assert!(arg0 > 0 && arg0 <= 2000, 3);
        let v0 = 443636 - 443636 % arg0;
        (524288 - v0, 524288 + v0)
    }

    public fun is_aligned(arg0: u32, arg1: u32) : bool {
        let v0 = if (arg0 >= 524288) {
            arg0 - 524288
        } else {
            524288 - arg0
        };
        v0 % arg1 == 0
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579062
    }

    public fun max_tick() : u32 {
        967924
    }

    public fun max_tick_spacing() : u32 {
        2000
    }

    public fun min_sqrt_price() : u128 {
        4295048017
    }

    public fun min_tick() : u32 {
        80652
    }

    public fun sqrt_price_at_tick(arg0: u32) : u128 {
        assert!(arg0 >= 80652 && arg0 <= 967924, 1);
        let (v0, v1) = if (arg0 > 524288) {
            (true, arg0 - 524288)
        } else {
            (false, 524288 - arg0)
        };
        let v2 = 340282366920938463463374607431768211456;
        let v3 = 0;
        while (v3 < 19) {
            if (v1 >> v3 & 1 == 1) {
                let v4 = v2 * factor(v3);
                v2 = v4 >> 128;
            };
            v3 = v3 + 1;
        };
        if (v0) {
            v2 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v2;
        };
        ((v2 + 18446744073709551615 >> 64) as u128)
    }

    public fun tick_at_sqrt_price(arg0: u128) : u32 {
        assert!(arg0 >= 4295048017 && arg0 <= 79226673515401279992447579062, 2);
        let v0 = 0;
        let v1 = 19;
        let v2 = if (arg0 >= 18446744073709551616) {
            let v3 = (arg0 as u256) << 32;
            while (v1 > 0) {
                v1 = v1 - 1;
                v3 = v3 * factor(v1) >> 128;
                if (v3 >= 79228162514264337593543950336) {
                    v0 = v0 | 1 << v1;
                };
            };
            524288 + v0
        } else {
            let v4 = 340282366920938463463374607431768211456;
            while (v1 > 0) {
                let v5 = v1 - 1;
                v1 = v5;
                v4 = v4 * factor(v5) >> 128;
                if (v4 > (arg0 as u256) << 64) {
                    v0 = v0 | 1 << v5;
                };
            };
            524288 - v0 - 1
        };
        let v6 = v2;
        if (v2 > 967924) {
            v6 = 967924;
        };
        if (v6 < 80652) {
            v6 = 80652;
        };
        while (v6 > 80652 && sqrt_price_at_tick(v6) > arg0) {
            v6 = v6 - 1;
        };
        while (v6 < 967924 && sqrt_price_at_tick(v6 + 1) <= arg0) {
            v6 = v6 + 1;
        };
        v6
    }

    public fun tick_bound() : u32 {
        443636
    }

    public fun tick_offset() : u32 {
        524288
    }

    public fun usable_ticks(arg0: u32) : u32 {
        assert!(arg0 > 0 && arg0 <= 2000, 3);
        2 * 443636 / arg0 + 1
    }

    // decompiled from Move bytecode v7
}

