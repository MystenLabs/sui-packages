module 0x4373072edf80cf0876fdd62791508a6d430b12be63133b3633020bd200e5e2ea::szd {
    struct SZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZD>(arg0, 6, b"SZD", b"SUIZARD", b"GOVERNANCE TOKEN FOR SUIZARD PROJECT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_18_55_10_8d0e3b9f9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZD>>(v1);
    }

    // decompiled from Move bytecode v6
}

