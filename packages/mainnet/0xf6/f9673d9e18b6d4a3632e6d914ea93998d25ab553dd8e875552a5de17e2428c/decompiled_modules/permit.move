module 0xf6f9673d9e18b6d4a3632e6d914ea93998d25ab553dd8e875552a5de17e2428c::permit {
    struct PermitMin has drop, store {
        token_id: u64,
        recipient: address,
    }

    public fun verify(arg0: u64, arg1: &vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = PermitMin{
            token_id  : arg0,
            recipient : 0x2::tx_context::sender(arg2),
        };
        let v1 = b"WEBUMP_BRIDGE_V1_MIN";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<PermitMin>(&v0));
        let v2 = 0x1::hash::sha3_256(v1);
        let v3 = x"8d24dedee50dd823eb0a17f819f4734e71fc343b74adc52e012ba1087c41ca30";
        0x2::ed25519::ed25519_verify(arg1, &v3, &v2)
    }

    // decompiled from Move bytecode v6
}

