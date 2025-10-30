module 0x59201c85e9559d56bd81cb6c942af2252605b3cdd7134ed858b9fd25a4786db4::oft_receipt {
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

