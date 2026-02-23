module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert {
    public(friend) fun to_u256(arg0: u64) : u256 {
        (arg0 as u256)
    }

    public(friend) fun to_u64(arg0: u256) : u64 {
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

