module 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify {
    struct VerifyParam has copy, drop, store {
        packet_header: vector<u8>,
        payload_hash: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        confirmations: u64,
    }

    public fun confirmations(arg0: &VerifyParam) : u64 {
        arg0.confirmations
    }

    public fun create_param(arg0: vector<u8>, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg2: u64) : VerifyParam {
        VerifyParam{
            packet_header : arg0,
            payload_hash  : arg1,
            confirmations : arg2,
        }
    }

    public fun packet_header(arg0: &VerifyParam) : &vector<u8> {
        &arg0.packet_header
    }

    public fun payload_hash(arg0: &VerifyParam) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.payload_hash
    }

    // decompiled from Move bytecode v6
}

