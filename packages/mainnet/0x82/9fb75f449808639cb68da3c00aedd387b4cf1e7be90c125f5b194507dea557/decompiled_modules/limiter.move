module 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter {
    struct VolumeLimiter has store, key {
        id: 0x2::object::UID,
        max_volume: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal,
        current_volume: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal,
        last_updated: u64,
    }

    struct VOLUME_LIMITER_FIELD has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_volume(arg0: &mut VolumeLimiter, arg1: &0x2::clock::Clock) {
        maybe_reset(arg0, arg1);
        assert!(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::le(arg0.current_volume, arg0.max_volume), 100);
    }

    public(friend) fun create_volume_limiter(arg0: &mut 0x2::tx_context::TxContext) : VolumeLimiter {
        VolumeLimiter{
            id             : 0x2::object::new(arg0),
            max_volume     : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(1000),
            current_volume : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0),
            last_updated   : 0,
        }
    }

    fun current_day(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 86400000
    }

    fun maybe_reset(arg0: &mut VolumeLimiter, arg1: &0x2::clock::Clock) {
        let v0 = current_day(arg1);
        if (arg0.last_updated < v0) {
            arg0.current_volume = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0);
            arg0.last_updated = v0;
        };
    }

    public(friend) fun record_volume(arg0: &mut VolumeLimiter, arg1: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal, arg2: &0x2::clock::Clock) {
        maybe_reset(arg0, arg2);
        arg0.current_volume = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::add(arg0.current_volume, arg1);
    }

    public(friend) fun set_max_volume(arg0: &mut VolumeLimiter, arg1: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal) {
        arg0.max_volume = arg1;
    }

    public(friend) fun volume_limiter_field() : VOLUME_LIMITER_FIELD {
        VOLUME_LIMITER_FIELD{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

