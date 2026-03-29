module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_stale_price_threshold {
    struct StalePriceThreshold {
        threshold: u64,
    }

    public(friend) fun execute(arg0: &0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::LatestOnly, arg1: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg2: vector<u8>) {
        let StalePriceThreshold { threshold: v0 } = from_byte_vec(arg2);
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::set_stale_price_threshold_secs(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : StalePriceThreshold {
        let v0 = 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::new<u8>(arg0);
        0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::destroy_empty<u8>(v0);
        StalePriceThreshold{threshold: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_u64(&mut v0)}
    }

    // decompiled from Move bytecode v6
}

