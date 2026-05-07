module 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::set_stale_price_threshold {
    struct StalePriceThreshold {
        threshold: u64,
    }

    public(friend) fun execute(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::LatestOnly, arg1: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<u8>) {
        let StalePriceThreshold { threshold: v0 } = from_byte_vec(arg2);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::set_stale_price_threshold_secs(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : StalePriceThreshold {
        let v0 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::new<u8>(arg0);
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::destroy_empty<u8>(v0);
        StalePriceThreshold{threshold: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::deserialize::deserialize_u64(&mut v0)}
    }

    // decompiled from Move bytecode v6
}

