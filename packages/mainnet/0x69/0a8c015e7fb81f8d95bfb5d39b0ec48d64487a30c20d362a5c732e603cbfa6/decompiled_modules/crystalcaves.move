module 0x690a8c015e7fb81f8d95bfb5d39b0ec48d64487a30c20d362a5c732e603cbfa6::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

