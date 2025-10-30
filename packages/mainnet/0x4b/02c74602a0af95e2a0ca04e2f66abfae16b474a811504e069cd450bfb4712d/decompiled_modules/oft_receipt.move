module 0x4b02c74602a0af95e2a0ca04e2f66abfae16b474a811504e069cd450bfb4712d::oft_receipt {
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

