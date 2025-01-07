module 0x6cb716b7d1170b042058f399501a004ac18cabb4ab7c37e0b982b8196e4d9062::dong {
    struct DONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONG>(arg0, 6, b"DONG", b"SUI DONG", x"48492c20494d2024444f4e47210a50454f504c452054454c4c204d452049204c4f4f4b204c494b452044454e472e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluepeng_9da931c6b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

