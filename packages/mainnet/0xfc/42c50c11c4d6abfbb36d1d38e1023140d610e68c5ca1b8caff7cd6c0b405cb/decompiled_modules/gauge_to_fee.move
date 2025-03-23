module 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::gauge_to_fee {
    struct GaugeToFeeProof {
        voter: 0x2::object::ID,
        gauge: 0x2::object::ID,
        reward: 0x2::object::ID,
    }

    public fun consume(arg0: GaugeToFeeProof) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let GaugeToFeeProof {
            voter  : v0,
            gauge  : v1,
            reward : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public(friend) fun issue(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : GaugeToFeeProof {
        GaugeToFeeProof{
            voter  : arg0,
            gauge  : arg1,
            reward : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

