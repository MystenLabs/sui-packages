module 0x3083f763a4a70c21706618edbb9e36938edf89868818866a95bcec0dfa1cbbc0::crystalcaves {
    struct BlockMined has copy, drop {
        count: u64,
    }

    entry fun testFun<T0>(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock) {
        let v0 = BlockMined{count: 111};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

