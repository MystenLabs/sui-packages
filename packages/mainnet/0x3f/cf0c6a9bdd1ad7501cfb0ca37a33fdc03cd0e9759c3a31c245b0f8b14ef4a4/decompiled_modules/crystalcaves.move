module 0x3fcf0c6a9bdd1ad7501cfb0ca37a33fdc03cd0e9759c3a31c245b0f8b14ef4a4::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u256,
    }

    public fun testFun<T0>(arg0: u256) {
        let v0 = TestEvent{testNum: arg0};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

