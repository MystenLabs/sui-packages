module 0x8b254f9057f92b78b8b98d0ae66f4562afdd0235fea8a9008883ed52c13732c1::func {
    public fun loopx() {
        let v0 = 1;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 > 0) {
            v0 = v0 + 1;
            0x1::vector::push_back<u64>(&mut v1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

