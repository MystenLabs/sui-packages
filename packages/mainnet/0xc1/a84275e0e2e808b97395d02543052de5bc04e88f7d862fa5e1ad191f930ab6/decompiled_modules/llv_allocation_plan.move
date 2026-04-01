module 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan {
    struct ProtocolAmount has copy, drop, store {
        protocol_id: u8,
        amount: u128,
    }

    public(friend) fun empty() : vector<ProtocolAmount> {
        0x1::vector::empty<ProtocolAmount>()
    }

    public fun PROTOCOL_ALPHALEND() : u8 {
        5
    }

    public fun PROTOCOL_CETUS() : u8 {
        1
    }

    public fun PROTOCOL_IDLE() : u8 {
        255
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

    public(friend) fun accumulate(arg0: &mut vector<ProtocolAmount>, arg1: u8, arg2: u128) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<ProtocolAmount>(arg0)) {
            let v1 = 0x1::vector::borrow<ProtocolAmount>(arg0, v0);
            if (v1.protocol_id == arg1) {
                *0x1::vector::borrow_mut<ProtocolAmount>(arg0, v0) = create(arg1, v1.amount + arg2);
                return
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<ProtocolAmount>(arg0, create(arg1, arg2));
    }

    public fun amount(arg0: &ProtocolAmount) : u128 {
        arg0.amount
    }

    public(friend) fun create(arg0: u8, arg1: u128) : ProtocolAmount {
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

    public fun is_idle_protocol(arg0: u8) : bool {
        arg0 == 255
    }

    public fun is_known_protocol(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 255
        }
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

    // decompiled from Move bytecode v7
}

