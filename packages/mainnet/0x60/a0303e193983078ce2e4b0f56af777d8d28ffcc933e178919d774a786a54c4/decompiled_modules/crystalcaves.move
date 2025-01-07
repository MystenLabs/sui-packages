module 0x60a0303e193983078ce2e4b0f56af777d8d28ffcc933e178919d774a786a54c4::crystalcaves {
    struct BlockMined has copy, drop {
        count: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock) {
        let v0 = BlockMined{count: arg0};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

