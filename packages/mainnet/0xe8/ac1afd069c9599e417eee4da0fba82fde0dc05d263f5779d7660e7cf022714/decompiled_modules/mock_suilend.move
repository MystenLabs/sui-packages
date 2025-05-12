module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::mock_suilend {
    struct MockSuilendPool has store, key {
        id: 0x2::object::UID,
    }

    struct MockSuilendObligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        usd_value: u64,
    }

    public fun calculate_suilend_obligation_value<T0>(arg0: &MockSuilendObligation<T0>) : u256 {
        (arg0.usd_value as u256)
    }

    public fun create_mock_obligation<T0>(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : MockSuilendObligation<T0> {
        MockSuilendObligation<T0>{
            id        : 0x2::object::new(arg0),
            usd_value : arg1,
        }
    }

    public fun set_usd_value<T0>(arg0: &mut MockSuilendObligation<T0>, arg1: u64) {
        arg0.usd_value = arg1;
    }

    public fun usd_value<T0>(arg0: &MockSuilendObligation<T0>) : u64 {
        arg0.usd_value
    }

    // decompiled from Move bytecode v6
}

