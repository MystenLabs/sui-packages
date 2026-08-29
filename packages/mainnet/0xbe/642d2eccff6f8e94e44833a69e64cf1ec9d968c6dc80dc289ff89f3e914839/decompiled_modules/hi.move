module 0xbe642d2eccff6f8e94e44833a69e64cf1ec9d968c6dc80dc289ff89f3e914839::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HI>(arg0, 6, b"HI", b"hi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/de3a81e2ecb5642d9334813515acc141713df32dfc4812a7cf8bd9f0b246db91.webp")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HI>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HI>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

