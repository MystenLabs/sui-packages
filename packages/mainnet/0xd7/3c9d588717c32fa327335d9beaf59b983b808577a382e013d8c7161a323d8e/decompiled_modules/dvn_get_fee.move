module 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee {
    struct GetFeeParam has copy, drop, store {
        dst_eid: u32,
        packet_header: vector<u8>,
        payload_hash: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        confirmations: u64,
        sender: address,
        options: vector<u8>,
    }

    public fun confirmations(arg0: &GetFeeParam) : u64 {
        arg0.confirmations
    }

    public(friend) fun create_param(arg0: u32, arg1: vector<u8>, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u64, arg4: address, arg5: vector<u8>) : GetFeeParam {
        GetFeeParam{
            dst_eid       : arg0,
            packet_header : arg1,
            payload_hash  : arg2,
            confirmations : arg3,
            sender        : arg4,
            options       : arg5,
        }
    }

    public fun dst_eid(arg0: &GetFeeParam) : u32 {
        arg0.dst_eid
    }

    public fun options(arg0: &GetFeeParam) : &vector<u8> {
        &arg0.options
    }

    public fun packet_header(arg0: &GetFeeParam) : &vector<u8> {
        &arg0.packet_header
    }

    public fun payload_hash(arg0: &GetFeeParam) : &0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        &arg0.payload_hash
    }

    public fun sender(arg0: &GetFeeParam) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

