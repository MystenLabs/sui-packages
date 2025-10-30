module 0xb058cb3858e6583d9000cfd4c8e0df0704ad37d0c2bba0e7cac47df48322924::oft_send_context {
    struct OFTSendContext {
        oft_receipt: 0xb058cb3858e6583d9000cfd4c8e0df0704ad37d0c2bba0e7cac47df48322924::oft_receipt::OFTReceipt,
        sender: address,
        call_id: address,
    }

    public fun oft_receipt(arg0: &OFTSendContext) : &0xb058cb3858e6583d9000cfd4c8e0df0704ad37d0c2bba0e7cac47df48322924::oft_receipt::OFTReceipt {
        &arg0.oft_receipt
    }

    public fun call_id(arg0: &OFTSendContext) : address {
        arg0.call_id
    }

    public(friend) fun create(arg0: 0xb058cb3858e6583d9000cfd4c8e0df0704ad37d0c2bba0e7cac47df48322924::oft_receipt::OFTReceipt, arg1: address, arg2: address) : OFTSendContext {
        OFTSendContext{
            oft_receipt : arg0,
            sender      : arg1,
            call_id     : arg2,
        }
    }

    public(friend) fun destroy(arg0: OFTSendContext) : (0xb058cb3858e6583d9000cfd4c8e0df0704ad37d0c2bba0e7cac47df48322924::oft_receipt::OFTReceipt, address, address) {
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

