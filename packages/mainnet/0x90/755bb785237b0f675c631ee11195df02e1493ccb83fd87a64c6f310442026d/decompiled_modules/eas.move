module 0x90755bb785237b0f675c631ee11195df02e1493ccb83fd87a64c6f310442026d::eas {
    struct EAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAS>(arg0, 6, b"EAS", b"RW", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifpd2yzx66kpoz5txm4l57lylv36ygbdfcpteafhkwvmnp3rxwaiy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

