module 0xf7a6f35906832e90a5d589016cb35b5bb97f66a0b1b9657dc59d15f417ef7b7a::vectors {
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

