module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive {
    struct LzReceiveParam {
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        nonce: u64,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        message: vector<u8>,
        executor: address,
        extra_data: vector<u8>,
        value: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    public(friend) fun create_param(arg0: u32, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg2: u64, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) : LzReceiveParam {
        LzReceiveParam{
            src_eid    : arg0,
            sender     : arg1,
            nonce      : arg2,
            guid       : arg3,
            message    : arg4,
            executor   : arg5,
            extra_data : arg6,
            value      : arg7,
        }
    }

    public fun destroy(arg0: LzReceiveParam) : (u32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, vector<u8>, address, vector<u8>, 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) {
        let LzReceiveParam {
            src_eid    : v0,
            sender     : v1,
            nonce      : v2,
            guid       : v3,
            message    : v4,
            executor   : v5,
            extra_data : v6,
            value      : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun executor(arg0: &LzReceiveParam) : address {
        arg0.executor
    }

    public fun extra_data(arg0: &LzReceiveParam) : &vector<u8> {
        &arg0.extra_data
    }

    public fun guid(arg0: &LzReceiveParam) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.guid
    }

    public fun message(arg0: &LzReceiveParam) : &vector<u8> {
        &arg0.message
    }

    public fun nonce(arg0: &LzReceiveParam) : u64 {
        arg0.nonce
    }

    public fun sender(arg0: &LzReceiveParam) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.sender
    }

    public fun src_eid(arg0: &LzReceiveParam) : u32 {
        arg0.src_eid
    }

    public fun value(arg0: &LzReceiveParam) : &0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

