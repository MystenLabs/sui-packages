module 0x6ff467932567e2a2c465cb26cc57efba2576623910af8f81c7b98291a128f806::deepbook {
    struct TestEvent has copy, drop {
        v1: u64,
        v2: u64,
    }

    public fun adjust_input_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    public fun getConst() : u8 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::option_type_withdraw()
    }

    fun init(arg0: &0x2::tx_context::TxContext) {
        let v0 = TestEvent{
            v1 : (getConst() as u64),
            v2 : 2,
        };
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

