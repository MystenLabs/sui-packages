module 0x143795b25db221fab9b93a1949b8f8607ce81d88c052aebfc9ec40fb4e73dbac::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random) {
        let v0 = TestEvent{testNum: arg0};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

