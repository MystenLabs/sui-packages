module 0x55e9843da0b0e7cbc75d9142a631135ef2fe54cac23dff8f6c80161a22b4dd82::heo {
    struct HEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEO>(arg0, 6, b"HEO", b"HELP EACH OTHER", b"When you make money, please help those around you who need help.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9192_9c550b78a9.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

