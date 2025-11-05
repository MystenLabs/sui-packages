module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::types_receipt {
    struct Receipt has copy, drop, store {
        asset: 0x1::string::String,
        chain: 0x1::string::String,
        tx_id: 0x1::string::String,
        amount: u64,
        recipient: address,
    }

    public(friend) fun get_amount(arg0: &Receipt) : u64 {
        arg0.amount
    }

    public(friend) fun get_asset(arg0: &Receipt) : 0x1::string::String {
        arg0.asset
    }

    public(friend) fun get_chain(arg0: &Receipt) : 0x1::string::String {
        arg0.chain
    }

    public(friend) fun get_recipient(arg0: &Receipt) : address {
        arg0.recipient
    }

    public(friend) fun get_tx_id(arg0: &Receipt) : 0x1::string::String {
        arg0.tx_id
    }

    public(friend) fun new_receipt(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: address) : Receipt {
        Receipt{
            asset     : arg0,
            chain     : arg1,
            tx_id     : arg2,
            amount    : arg3,
            recipient : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

