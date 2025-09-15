module 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient {
    struct FeeRecipient has copy, drop, store {
        fee: u64,
        recipient: address,
    }

    public fun create(arg0: u64, arg1: address) : FeeRecipient {
        FeeRecipient{
            fee       : arg0,
            recipient : arg1,
        }
    }

    public fun fee(arg0: &FeeRecipient) : u64 {
        arg0.fee
    }

    public fun recipient(arg0: &FeeRecipient) : address {
        arg0.recipient
    }

    // decompiled from Move bytecode v6
}

