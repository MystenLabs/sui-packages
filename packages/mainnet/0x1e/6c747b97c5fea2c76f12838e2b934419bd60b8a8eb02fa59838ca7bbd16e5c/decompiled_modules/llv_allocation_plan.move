module 0x1e6c747b97c5fea2c76f12838e2b934419bd60b8a8eb02fa59838ca7bbd16e5c::llv_allocation_plan {
    struct ProtocolAmount has copy, drop, store {
        protocol_id: u8,
        amount: u128,
    }

    public fun empty() : vector<ProtocolAmount> {
        0x1::vector::empty<ProtocolAmount>()
    }

    public fun PROTOCOL_CETUS() : u8 {
        1
    }

    public fun PROTOCOL_NAVI() : u8 {
        4
    }

    public fun PROTOCOL_SCALLOP() : u8 {
        3
    }

    public fun PROTOCOL_SUILEND() : u8 {
        2
    }

    public fun PROTOCOL_VAULT() : u8 {
        0
    }

    public fun amount(arg0: &ProtocolAmount) : u128 {
        arg0.amount
    }

    public fun create(arg0: u8, arg1: u128) : ProtocolAmount {
        ProtocolAmount{
            protocol_id : arg0,
            amount      : arg1,
        }
    }

    public fun get_amount(arg0: &vector<ProtocolAmount>, arg1: u8) : u128 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ProtocolAmount>(arg0)) {
            let v1 = 0x1::vector::borrow<ProtocolAmount>(arg0, v0);
            if (v1.protocol_id == arg1) {
                return v1.amount
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun protocol_id(arg0: &ProtocolAmount) : u8 {
        arg0.protocol_id
    }

    public fun total_amount(arg0: &vector<ProtocolAmount>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<ProtocolAmount>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<ProtocolAmount>(arg0, v1).amount;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

