module 0x30dc300d6e9040d617fb7e1ddfc9385955ea16a1dd7eee820db90cb287ec53::korra {
    struct KORRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORRA>(arg0, 6, b"KORRA", b"Korra on Sui", b"Just a Water Bender ready to protect the Sui Clan with all I have. Join my tribe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_64a718afbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

