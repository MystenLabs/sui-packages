module 0xa008b8c09554e36aef5cb6f611384987e04561af11b1aea284aa6fa89242fdbc::oft_receipt {
    struct OFTReceipt has copy, drop, store {
        amount_sent_ld: u64,
        amount_received_ld: u64,
    }

    public fun amount_received_ld(arg0: &OFTReceipt) : u64 {
        arg0.amount_received_ld
    }

    public fun amount_sent_ld(arg0: &OFTReceipt) : u64 {
        arg0.amount_sent_ld
    }

    public(friend) fun create(arg0: u64, arg1: u64) : OFTReceipt {
        OFTReceipt{
            amount_sent_ld     : arg0,
            amount_received_ld : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

