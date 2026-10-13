module 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::lazer_price {
    struct LazerPrice has copy, drop {
        feed_id: u32,
        channel: u8,
        envelope_us: u64,
        generation_us: u64,
        spot: u64,
    }

    public fun channel(arg0: &LazerPrice) : u8 {
        arg0.channel
    }

    public fun envelope_us(arg0: &LazerPrice) : u64 {
        arg0.envelope_us
    }

    public fun feed_id(arg0: &LazerPrice) : u32 {
        arg0.feed_id
    }

    public(friend) fun feed_index(arg0: &vector<u32>, arg1: u32) : u64 {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u32>(arg0)) {
            if (*0x1::vector::borrow<u32>(arg0, v0) == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v1), 2);
                return 0x1::option::destroy_some<u64>(v1)
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun from_parts(arg0: u32, arg1: u8, arg2: u64, arg3: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg4: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>, arg5: 0x1::option::Option<0x1::option::Option<u64>>) : 0x1::option::Option<LazerPrice> {
        let v0 = if (0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg3)) {
            if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&arg4)) {
                0x1::option::is_some<0x1::option::Option<u64>>(&arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = 0x1::option::destroy_some<0x1::option::Option<u64>>(arg5);
        if (0x1::option::is_none<u64>(&v1)) {
            return 0x1::option::none<LazerPrice>()
        };
        let v2 = 0x1::option::destroy_some<u64>(v1);
        assert!(v2 <= arg2, 1);
        let v3 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg3);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v3)) {
            return 0x1::option::none<LazerPrice>()
        };
        let v4 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v3);
        let v5 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(arg4);
        let v6 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v5);
        let v7 = if (v6) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v5)
        } else {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v5)
        };
        let v8 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v4);
        let v9 = if (v8) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_negative(&v4)
        } else {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v4)
        };
        let v10 = normalize_spot(v9, v8, v7, v6);
        if (0x1::option::is_some<u64>(&v10)) {
            let v12 = LazerPrice{
                feed_id       : arg0,
                channel       : arg1,
                envelope_us   : arg2,
                generation_us : v2,
                spot          : 0x1::option::destroy_some<u64>(v10),
            };
            0x1::option::some<LazerPrice>(v12)
        } else {
            0x1::option::destroy_none<u64>(v10);
            0x1::option::none<LazerPrice>()
        }
    }

    public fun from_update(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u32) : 0x1::option::Option<LazerPrice> {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::channel(arg0);
        let v1 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::is_fixed_rate_50ms(&v0)) {
            2
        } else if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::is_fixed_rate_200ms(&v0)) {
            3
        } else {
            1
        };
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2)) {
            0x1::vector::push_back<u32>(&mut v3, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2, v4)));
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2, feed_index(&v3, arg1));
        from_parts(arg1, v1, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg0), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v5), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v5), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v5))
    }

    public fun generation_us(arg0: &LazerPrice) : u64 {
        arg0.generation_us
    }

    public(friend) fun normalize_spot(arg0: u64, arg1: bool, arg2: u16, arg3: bool) : 0x1::option::Option<u64> {
        if (arg1) {
            return 0x1::option::none<u64>()
        };
        let v0 = 9;
        let v1 = (arg2 as u64);
        let v2 = if (arg3 && v1 > v0) {
            let v3 = v1 - v0;
            if (v3 > 18) {
                return 0x1::option::none<u64>()
            };
            ((arg0 / 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::pow10(v3)) as u128)
        } else {
            let v4 = if (arg3) {
                v0 - v1
            } else {
                v0 + v1
            };
            if (v4 > 18) {
                return 0x1::option::none<u64>()
            };
            (arg0 as u128) * (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::pow10(v4) as u128)
        };
        if (v2 == 0 || v2 > 184467440737095516) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v2 as u64))
    }

    public fun spot(arg0: &LazerPrice) : u64 {
        arg0.spot
    }

    // decompiled from Move bytecode v7
}

