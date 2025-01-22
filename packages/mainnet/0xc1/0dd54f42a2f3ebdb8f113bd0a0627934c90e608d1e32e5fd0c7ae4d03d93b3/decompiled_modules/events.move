module 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::events {
    struct GasPaid<phantom T0> has copy, drop {
        sender: address,
        destination_chain: 0x1::ascii::String,
        destination_address: 0x1::ascii::String,
        payload_hash: address,
        value: u64,
        refund_address: address,
        params: vector<u8>,
    }

    struct GasAdded<phantom T0> has copy, drop {
        message_id: 0x1::ascii::String,
        value: u64,
        refund_address: address,
        params: vector<u8>,
    }

    struct Refunded<phantom T0> has copy, drop {
        message_id: 0x1::ascii::String,
        value: u64,
        refund_address: address,
    }

    struct GasCollected<phantom T0> has copy, drop {
        receiver: address,
        value: u64,
    }

    public(friend) fun gas_added<T0>(arg0: 0x1::ascii::String, arg1: u64, arg2: address, arg3: vector<u8>) {
        let v0 = GasAdded<T0>{
            message_id     : arg0,
            value          : arg1,
            refund_address : arg2,
            params         : arg3,
        };
        0x2::event::emit<GasAdded<T0>>(v0);
    }

    public(friend) fun gas_collected<T0>(arg0: address, arg1: u64) {
        let v0 = GasCollected<T0>{
            receiver : arg0,
            value    : arg1,
        };
        0x2::event::emit<GasCollected<T0>>(v0);
    }

    public(friend) fun gas_paid<T0>(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: address, arg6: vector<u8>) {
        let v0 = GasPaid<T0>{
            sender              : arg0,
            destination_chain   : arg1,
            destination_address : arg2,
            payload_hash        : arg3,
            value               : arg4,
            refund_address      : arg5,
            params              : arg6,
        };
        0x2::event::emit<GasPaid<T0>>(v0);
    }

    public(friend) fun refunded<T0>(arg0: 0x1::ascii::String, arg1: u64, arg2: address) {
        let v0 = Refunded<T0>{
            message_id     : arg0,
            value          : arg1,
            refund_address : arg2,
        };
        0x2::event::emit<Refunded<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

