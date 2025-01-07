module 0xc426d36dab91993f70c98b43754608a9369cdf4ff1c59b1866570959225109::crystalcaves {
    struct BlockMined has copy, drop {
        count: u64,
    }

    entry fun testFun<T0>(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u16>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock) {
        let v0 = BlockMined{count: 111};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

