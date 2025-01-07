module 0xd80f76c42ad987c35b70c7333faaca17d45f13183f284e188fdc37ebad4a5941::mtd {
    struct MTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTD>(arg0, 6, b"MTD", b"MEWTWO DESTRO", b"In a dimension where blockchain meets ambition, MewTwo Destro was bornan evolved fusion of power and digital mastery. Forged from both legendary code and meme magic, MewTwo Destro emerged as the savior for the disenfranchised crypto dreamers, destined to conquer the volatile landscapes of the crypto-verse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/50f053e7_f387_46a0_824d_3d43c98517d5_65522fc2ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

