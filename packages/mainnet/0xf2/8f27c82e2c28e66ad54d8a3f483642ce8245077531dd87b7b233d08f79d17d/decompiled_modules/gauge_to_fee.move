module 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::gauge_to_fee {
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

