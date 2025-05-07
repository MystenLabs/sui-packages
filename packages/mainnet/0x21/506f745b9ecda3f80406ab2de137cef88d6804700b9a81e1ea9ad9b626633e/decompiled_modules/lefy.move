module 0x21506f745b9ecda3f80406ab2de137cef88d6804700b9a81e1ea9ad9b626633e::lefy {
    struct LEFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEFY>(arg0, 6, b"LEFY", b"Lefy The Sui", b"SUIBEAR intense drive and unflinching conviction will undoubtedly have a long-term impact on the market this season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250508_034826_356_5e97ddaf55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

