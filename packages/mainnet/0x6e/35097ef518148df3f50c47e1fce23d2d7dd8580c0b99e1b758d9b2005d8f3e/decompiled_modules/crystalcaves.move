module 0x6e35097ef518148df3f50c47e1fce23d2d7dd8580c0b99e1b758d9b2005d8f3e::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: vector<u8>, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

