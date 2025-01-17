module 0x2a089c7a829528fb6953ca9927c2575e892f6be7e86d1062e0016907ad2d396::pose {
    struct POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSE>(arg0, 6, b"POSE", b"POSUIDON", b"Majestic guardian of the $SUI ocean. Protecting the community from scams and rug pulls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737141583803.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

