module 0x333479e520d84f7f5675a5cc8900fc37864472453462c271f8090a2944c72e7f::adsf {
    struct ADSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSF>(arg0, 6, b"ADSF", b"aewF", b"ADSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/de3a81e2ecb5642d9334813515acc141713df32dfc4812a7cf8bd9f0b246db91.webp")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSF>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADSF>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

