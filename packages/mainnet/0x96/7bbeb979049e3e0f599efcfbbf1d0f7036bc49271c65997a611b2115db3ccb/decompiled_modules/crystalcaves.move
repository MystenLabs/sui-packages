module 0x967bbeb979049e3e0f599efcfbbf1d0f7036bc49271c65997a611b2115db3ccb::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u64,
    }

    entry fun testFun<T0>(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = TestEvent{testNum: 42};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

