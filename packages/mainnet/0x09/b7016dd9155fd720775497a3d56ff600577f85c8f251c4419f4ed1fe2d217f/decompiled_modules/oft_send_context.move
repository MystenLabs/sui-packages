module 0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::oft_send_context {
    struct OFTSendContext {
        oft_receipt: 0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::oft_receipt::OFTReceipt,
        sender: address,
        call_id: address,
    }

    public fun oft_receipt(arg0: &OFTSendContext) : &0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::oft_receipt::OFTReceipt {
        &arg0.oft_receipt
    }

    public fun call_id(arg0: &OFTSendContext) : address {
        arg0.call_id
    }

    public(friend) fun create(arg0: 0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::oft_receipt::OFTReceipt, arg1: address, arg2: address) : OFTSendContext {
        OFTSendContext{
            oft_receipt : arg0,
            sender      : arg1,
            call_id     : arg2,
        }
    }

    public(friend) fun destroy(arg0: OFTSendContext) : (0x9b7016dd9155fd720775497a3d56ff600577f85c8f251c4419f4ed1fe2d217f::oft_receipt::OFTReceipt, address, address) {
        let OFTSendContext {
            oft_receipt : v0,
            sender      : v1,
            call_id     : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun sender(arg0: &OFTSendContext) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

