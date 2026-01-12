module 0x6f74523f9fbf78da5666ffefd0fe822cc6fa18ea2eb8f75be0ed6dbda5b4c8a0::test {
    struct TestResult has copy, drop {
        value: u64,
    }

    public fun call_add() : u64 {
        let v0 = 0xd170488e84ffa9e834791af4970bd1f6b95558587e2181b3990e1f5a98763c6::math::add_with_magic(10, 20);
        let v1 = TestResult{value: v0};
        0x2::event::emit<TestResult>(v1);
        v0
    }

    public fun call_compute() : (u64, u64) {
        let v0 = 0xd170488e84ffa9e834791af4970bd1f6b95558587e2181b3990e1f5a98763c6::math::compute(50);
        (0xd170488e84ffa9e834791af4970bd1f6b95558587e2181b3990e1f5a98763c6::math::get_value(&v0), 0xd170488e84ffa9e834791af4970bd1f6b95558587e2181b3990e1f5a98763c6::math::get_magic(&v0))
    }

    // decompiled from Move bytecode v6
}

