module 0xdc865142268169a30709b1c3507cc3cc0da8d23f6819f195adb45607983bc351::crystalcaves {
    struct TestEvent has copy, drop {
        testNum: u256,
    }

    struct RewardClaimed has copy, drop {
        userAddress: address,
        tokenAddress: address,
        tokenAmount: u64,
    }

    public fun testFun(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TestEvent{testNum: arg0};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

