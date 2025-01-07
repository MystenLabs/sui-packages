module 0x2fa524fcc59eaf2e6e90c4cf8c3a276e4f1041b4e7118ab4302384a46ef45075::aowl {
    struct AOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOWL>(arg0, 6, b"AOWL", b"APPLE OWL", b"This is APPLE OWL. OG coin. No community. JPEG coin. OWL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Apple_Owl_7bb9387252.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

