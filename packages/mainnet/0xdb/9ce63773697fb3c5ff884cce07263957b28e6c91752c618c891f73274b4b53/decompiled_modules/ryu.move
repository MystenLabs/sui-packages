module 0xdb9ce63773697fb3c5ff884cce07263957b28e6c91752c618c891f73274b4b53::ryu {
    struct RYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYU>(arg0, 6, b"Ryu", b"Suiryudan", x"576174657220447261676f6e204f66205375690a74686520776174657220647261676f6e20746861742077696c6c20646f6d696e61746520746865206d656d6520737569206d61726b6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069691_8382cf2389.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

