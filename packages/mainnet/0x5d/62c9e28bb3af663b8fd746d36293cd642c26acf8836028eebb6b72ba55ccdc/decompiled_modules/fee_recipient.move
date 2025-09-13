module 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient {
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

