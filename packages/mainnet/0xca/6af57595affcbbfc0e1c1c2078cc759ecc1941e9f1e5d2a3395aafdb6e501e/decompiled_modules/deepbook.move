module 0xca6af57595affcbbfc0e1c1c2078cc759ecc1941e9f1e5d2a3395aafdb6e501e::deepbook {
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
            v1 : (0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_utils::to_decimals(1) as u64),
            v2 : 2,
        };
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

