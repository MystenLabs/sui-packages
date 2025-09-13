module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee {
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

