module 0x9d32b0ce919d6f9e35fffd7223bc5494b8d8202f493008db01424a7c40f20980::aim {
    struct AIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIM>(arg0, 6, b"AIM", b"AI ROOM", b"Leverages the power of artificial intelligence with AI ROOM / $AIM to ensure top-notch security for every transaction. Developed using SUI clouds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_24_06_50_49_cf70e743ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

