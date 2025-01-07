module 0x7feee4a55314ba9e8dabca475d71e7015b2a1e159aba8f44ad6144b33e043297::crystalcaves {
    struct BlockMined has copy, drop {
        count: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock) {
        let v0 = BlockMined{count: arg0};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

