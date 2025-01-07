module 0xe249ebc3d2e173a876dd369f73eda80a3a55f20a13e92d6d9da1dbfd9a465c5c::cyber {
    struct CYBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBER>(arg0, 6, b"CYBER", b"Cyber Frog on SUI", b"$Cyber combines speed, security, and real utility in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_THE_BUILDER_9c283e02f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

