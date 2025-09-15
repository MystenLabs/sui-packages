module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee {
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

