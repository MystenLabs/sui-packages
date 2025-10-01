module 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee {
    struct GetFeeParam has copy, drop, store {
        dst_eid: u32,
        sender: address,
        calldata_size: u64,
        options: vector<u8>,
    }

    public fun calldata_size(arg0: &GetFeeParam) : u64 {
        arg0.calldata_size
    }

    public fun create_param(arg0: u32, arg1: address, arg2: u64, arg3: vector<u8>) : GetFeeParam {
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

