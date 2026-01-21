module 0x1af9cf04ae5568edd6bc6e5b3ef4f90da9b668b8ec320b457439941ae587b1be::send_param {
    struct SendParam has drop {
        dst_eid: u32,
        to: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        amount_ld: u64,
        min_amount_ld: u64,
        extra_options: vector<u8>,
        compose_msg: vector<u8>,
        oft_cmd: vector<u8>,
    }

    public fun amount_ld(arg0: &SendParam) : u64 {
        arg0.amount_ld
    }

    public fun compose_msg(arg0: &SendParam) : &vector<u8> {
        &arg0.compose_msg
    }

    public fun create(arg0: u32, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : SendParam {
        SendParam{
            dst_eid       : arg0,
            to            : arg1,
            amount_ld     : arg2,
            min_amount_ld : arg3,
            extra_options : arg4,
            compose_msg   : arg5,
            oft_cmd       : arg6,
        }
    }

    public fun dst_eid(arg0: &SendParam) : u32 {
        arg0.dst_eid
    }

    public fun extra_options(arg0: &SendParam) : &vector<u8> {
        &arg0.extra_options
    }

    public fun min_amount_ld(arg0: &SendParam) : u64 {
        arg0.min_amount_ld
    }

    public fun oft_cmd(arg0: &SendParam) : &vector<u8> {
        &arg0.oft_cmd
    }

    public fun to(arg0: &SendParam) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.to
    }

    // decompiled from Move bytecode v6
}

