module 0x603106d5d30baf5bc9ea40c345493c28e7e38237bd742f8b6398060fa8c49078::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

