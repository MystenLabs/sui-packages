module 0xcb4fff5943fc42bc8bdcaab3ea5058661f3c443708b59ef689d31d2595f21cbd::suimangroup {
    struct SUIMANGROUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMANGROUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMANGROUP>(arg0, 6, b"SUIMANGROUP", b"Sui Man Group", x"5468652069636f6e696320426c7565204d616e2047726f75702c20245355494d414e47524f5550206272696e67732072687974686d2c20637265617469766974792c20616e6420616e206f74686572776f726c646c79207669626520746f2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_e52f068c75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMANGROUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMANGROUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

