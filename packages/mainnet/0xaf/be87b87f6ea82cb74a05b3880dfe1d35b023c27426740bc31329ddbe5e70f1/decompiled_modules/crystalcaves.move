module 0xafbe87b87f6ea82cb74a05b3880dfe1d35b023c27426740bc31329ddbe5e70f1::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

