module 0xdf66e3007ac3b05d852679ba9d6bf0739c8591ac908811ae3c816833ee5cbcf::zyz {
    struct ZYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYZ>(arg0, 6, b"Zyz", b"0xzyz", b"New degen ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidpjzmtkl4q62jsi2ue6krdxb2eug3f6bluvkwravxg4kyeu4omnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZYZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

