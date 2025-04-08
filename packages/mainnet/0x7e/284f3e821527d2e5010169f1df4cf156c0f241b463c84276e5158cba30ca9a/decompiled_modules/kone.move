module 0x7e284f3e821527d2e5010169f1df4cf156c0f241b463c84276e5158cba30ca9a::kone {
    struct KONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONE>(arg0, 6, b"KONE", b"Karrier One", b"Building the foundation for truly borderless connectivity through decentralized infrastructure. Our network of cellular Gatekeepers and WiFi hotspots empower local operators while connecting the billions of people left behind by traditional telecom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4415_176e38522a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

