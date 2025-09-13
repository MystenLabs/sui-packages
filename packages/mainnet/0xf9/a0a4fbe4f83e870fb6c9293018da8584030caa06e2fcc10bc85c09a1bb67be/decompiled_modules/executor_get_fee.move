module 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_get_fee {
    struct GetFeeParam has copy, drop, store {
        dst_eid: u32,
        sender: address,
        calldata_size: u64,
        options: vector<u8>,
    }

    public fun calldata_size(arg0: &GetFeeParam) : u64 {
        arg0.calldata_size
    }

    public(friend) fun create_param(arg0: u32, arg1: address, arg2: u64, arg3: vector<u8>) : GetFeeParam {
        GetFeeParam{
            dst_eid       : arg0,
            sender        : arg1,
            calldata_size : arg2,
            options       : arg3,
        }
    }

    public fun dst_eid(arg0: &GetFeeParam) : u32 {
        arg0.dst_eid
    }

    public fun options(arg0: &GetFeeParam) : &vector<u8> {
        &arg0.options
    }

    public fun sender(arg0: &GetFeeParam) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

