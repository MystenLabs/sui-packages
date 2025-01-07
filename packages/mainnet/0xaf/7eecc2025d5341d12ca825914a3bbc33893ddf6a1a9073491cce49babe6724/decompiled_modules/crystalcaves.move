module 0xaf7eecc2025d5341d12ca825914a3bbc33893ddf6a1a9073491cce49babe6724::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: vector<u8>, arg2: vector<u64>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

