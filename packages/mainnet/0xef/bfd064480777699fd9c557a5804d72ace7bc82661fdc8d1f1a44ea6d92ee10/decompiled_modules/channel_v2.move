module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel_v2 {
    struct Channel has copy, drop, store {
        pos0: u8,
    }

    public(friend) fun from_u8(arg0: u8) : Channel {
        assert!(arg0 >= 1 && arg0 <= 4, 13906834217293053953);
        Channel{pos0: arg0}
    }

    public fun get_update_interval_ms(arg0: &Channel) : u64 {
        if (arg0.pos0 == 1) {
            0
        } else if (arg0.pos0 == 2) {
            50
        } else if (arg0.pos0 == 3) {
            200
        } else {
            assert!(arg0.pos0 == 4, 13906834328962203649);
            1000
        }
    }

    public fun is_fixed_rate_1000ms(arg0: &Channel) : bool {
        arg0.pos0 == 4
    }

    public fun is_fixed_rate_200ms(arg0: &Channel) : bool {
        arg0.pos0 == 3
    }

    public fun is_fixed_rate_50ms(arg0: &Channel) : bool {
        arg0.pos0 == 2
    }

    public fun is_real_time(arg0: &Channel) : bool {
        arg0.pos0 == 1
    }

    // decompiled from Move bytecode v7
}

