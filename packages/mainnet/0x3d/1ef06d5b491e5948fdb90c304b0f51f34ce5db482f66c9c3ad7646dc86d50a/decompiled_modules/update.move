module 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update {
    struct Update has copy, drop {
        timestamp: u64,
        feeds: vector<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed>,
    }

    public(friend) fun new(arg0: u64, arg1: vector<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed>) : Update {
        Update{
            timestamp : arg0,
            feeds     : arg1,
        }
    }

    public fun feed_for_id(arg0: &Update, arg1: u32) : &0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed {
        let v0 = &arg0.feeds;
        let v1 = 0;
        let v2 = 0x1::vector::length<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed>(v0);
        while (v1 < v2) {
            v2 = v1 + v2 >> 1;
            let v3 = 0x1::vector::borrow<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed>(v0, v2);
            let v4 = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::feed_id(v3);
            if (v4 == arg1) {
                return v3
            };
            if (v4 < arg1) {
                v1 = v2 + 1;
                continue
            };
        };
        abort 13906834702624620549
    }

    public fun feeds(arg0: &Update) : &vector<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed> {
        &arg0.feeds
    }

    public(friend) fun parse(arg0: vector<u8>) : Update {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_u32(&mut v0) == 1347765825, 13906834427746451457);
        let v1 = 0x1::vector::empty<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed>();
        let v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v3 = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::parse_from_cursor(&mut v0);
            assert!(0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::feed_id(&v3) >= 0, 13906834487876386823);
            0x1::vector::push_back<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::Feed>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v4) == 0, 13906834522235863043);
        new(0x2::bcs::peel_u64(&mut v0), v1)
    }

    public fun timestamp(arg0: &Update) : u64 {
        arg0.timestamp
    }

    public fun timestamp_ms(arg0: &Update) : u64 {
        arg0.timestamp / 1000
    }

    // decompiled from Move bytecode v7
}

