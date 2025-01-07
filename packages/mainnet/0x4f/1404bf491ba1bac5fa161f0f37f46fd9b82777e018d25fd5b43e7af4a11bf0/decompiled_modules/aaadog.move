module 0x4f1404bf491ba1bac5fa161f0f37f46fd9b82777e018d25fd5b43e7af4a11bf0::aaadog {
    struct AAADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADOG>(arg0, 6, b"AAADOG", b"aaaDog", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_d606e2f5d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

