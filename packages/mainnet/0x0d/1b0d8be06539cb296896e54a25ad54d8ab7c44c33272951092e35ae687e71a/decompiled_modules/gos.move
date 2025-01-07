module 0xd1b0d8be06539cb296896e54a25ad54d8ab7c44c33272951092e35ae687e71a::gos {
    struct GOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOS>(arg0, 6, b"GOS", b"Garcia On SUI", b"Which memecoin got that dawg in him?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241002_220421_334d2fe80c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

