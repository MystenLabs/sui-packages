module 0x9300417f21de52ba4c4194630304b87e66b38d54f23aa6f59f4b70c54f2a6312::wcs {
    struct WCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCS>(arg0, 6, b"WCS", b"Wet cock on sui", b"Dive in and get your cock wet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5732_9109c221ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

