module 0x96ed3e79d1df8ba26580e487091ed40d85d1e0bd91c1d0b04fc13fc0fdb69d00::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"SMILE", b"smile", b"smile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/de3a81e2ecb5642d9334813515acc141713df32dfc4812a7cf8bd9f0b246db91.webp")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMILE>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

