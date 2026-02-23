module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::vectors {
    public(friend) fun zero_fill(arg0: u256) : vector<u256> {
        let v0 = vector[];
        let v1 = 0;
        while (arg0 > v1) {
            0x1::vector::push_back<u256>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

