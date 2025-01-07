module 0xadfc7b2d59af60ecfd7e3343d35e6f4f7a258786247878ce5e85b7df91a1f8a8::sfx {
    struct SFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFX>(arg0, 6, b"SFX", b"Suuflex", b"not just another streaming platfrom. we make moves we make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0955_321e944c89.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFX>>(v1);
    }

    // decompiled from Move bytecode v6
}

