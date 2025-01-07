module 0xb2320db72e0e1e330644a6930be9096e47f11c5bfc8f1c68a52376e8a13165a7::zombiesui {
    struct ZOMBIESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIESUI>(arg0, 6, b"ZombieSui", b"Zombie Sui", b"World of Zombia is an innovative crypto token that combines elements of entertainment and technology in a unique ecosystem. This project is inspired by popular zombie culture and creates an interactive environment for cryptocurrency enthusiasts and the gaming community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_20_18_36_2_95c9947f2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMBIESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

