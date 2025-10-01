module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee {
    struct MessagingFee has copy, drop, store {
        native_fee: u64,
        zro_fee: u64,
    }

    public fun create(arg0: u64, arg1: u64) : MessagingFee {
        MessagingFee{
            native_fee : arg0,
            zro_fee    : arg1,
        }
    }

    public fun native_fee(arg0: &MessagingFee) : u64 {
        arg0.native_fee
    }

    public fun zro_fee(arg0: &MessagingFee) : u64 {
        arg0.zro_fee
    }

    // decompiled from Move bytecode v6
}

