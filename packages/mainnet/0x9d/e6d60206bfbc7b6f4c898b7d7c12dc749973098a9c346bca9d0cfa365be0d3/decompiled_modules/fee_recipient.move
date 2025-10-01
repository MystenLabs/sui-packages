module 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient {
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

