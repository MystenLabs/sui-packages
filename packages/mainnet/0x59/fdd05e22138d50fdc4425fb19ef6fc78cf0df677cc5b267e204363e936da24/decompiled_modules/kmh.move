module 0x59fdd05e22138d50fdc4425fb19ef6fc78cf0df677cc5b267e204363e936da24::kmh {
    struct KMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KMH>(arg0, 6, b"KMH", b"KAMEHA", b"The Dragon Ball Series", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_6_6686259503.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

