module 0xbd54342fdb919dee4163806483ea8e14c4f53d3cb41528faa393a77e295c8244::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: vector<u8>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

