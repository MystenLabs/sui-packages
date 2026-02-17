module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update {
    struct Update has copy, drop {
        timestamp: u64,
        channel: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::Channel,
        feeds: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>,
    }

    public fun channel(arg0: &Update) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::Channel {
        arg0.channel
    }

    public(friend) fun parse_from_cursor(arg0: 0x2::bcs::BCS) : Update {
        let v0 = 0x1::vector::empty<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_u8(&mut arg0)) {
            0x1::vector::push_back<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut v0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::parse_from_cursor(&mut arg0));
            v1 = v1 + 1;
        };
        let v2 = 0x2::bcs::into_remainder_bytes(arg0);
        assert!(0x1::vector::length<u8>(&v2) == 0, 3);
        Update{
            timestamp : 0x2::bcs::peel_u64(&mut arg0),
            channel   : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::from_u8(0x2::bcs::peel_u8(&mut arg0)),
            feeds     : v0,
        }
    }

    public fun feeds(arg0: &Update) : vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed> {
        arg0.feeds
    }

    public fun feeds_ref(arg0: &Update) : &vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed> {
        &arg0.feeds
    }

    public(friend) fun new(arg0: u64, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel::Channel, arg2: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>) : Update {
        Update{
            timestamp : arg0,
            channel   : arg1,
            feeds     : arg2,
        }
    }

    public fun timestamp(arg0: &Update) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

