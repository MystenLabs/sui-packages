module 0x9d5f62a3ee6e77e2aa7b7e2f6e198a91af0fe346d5afa2b5702999f8a894884c::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

