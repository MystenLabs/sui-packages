module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose {
    struct LzComposeParam {
        from: address,
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        message: vector<u8>,
        executor: address,
        extra_data: vector<u8>,
        value: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    public(friend) fun create_param(arg0: address, arg1: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) : LzComposeParam {
        LzComposeParam{
            from       : arg0,
            guid       : arg1,
            message    : arg2,
            executor   : arg3,
            extra_data : arg4,
            value      : arg5,
        }
    }

    public fun destroy(arg0: LzComposeParam) : (address, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, vector<u8>, address, vector<u8>, 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) {
        let LzComposeParam {
            from       : v0,
            guid       : v1,
            message    : v2,
            executor   : v3,
            extra_data : v4,
            value      : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    public fun executor(arg0: &LzComposeParam) : address {
        arg0.executor
    }

    public fun extra_data(arg0: &LzComposeParam) : &vector<u8> {
        &arg0.extra_data
    }

    public fun from(arg0: &LzComposeParam) : address {
        arg0.from
    }

    public fun guid(arg0: &LzComposeParam) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        arg0.guid
    }

    public fun message(arg0: &LzComposeParam) : &vector<u8> {
        &arg0.message
    }

    public fun value(arg0: &LzComposeParam) : &0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

