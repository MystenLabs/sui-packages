module 0xbacc280a15504821aa440d720fcc17487a9ae75db23fdfa60df5cc1ff9f6000b::crystalcaves {
    struct BlockMined has copy, drop {
        count: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: vector<u8>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock) {
        let v0 = BlockMined{count: arg0};
        0x2::event::emit<BlockMined>(v0);
    }

    // decompiled from Move bytecode v6
}

