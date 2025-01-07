module 0xb1c99850101b46ad3300934e16b06d9c0fcd9c2ad3a88017dd6b342c0e3a6f75::kas {
    struct KAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAS>(arg0, 6, b"KAS", b"KASKY", b"LETS GO MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1080x360_647dfb1fa2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

