module 0xdaa28b3d05f706ddb223eca7516b698cc8a00179db6e892463441112734724ed::crystalcaves {
    struct BlockMined has copy, drop {
        count: u64,
    }

    entry fun testFun<T0>(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock) {
        let v0 = BlockMined{count: 111};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

