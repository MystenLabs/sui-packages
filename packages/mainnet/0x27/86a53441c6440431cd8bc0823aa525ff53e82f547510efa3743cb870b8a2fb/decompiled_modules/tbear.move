module 0x2786a53441c6440431cd8bc0823aa525ff53e82f547510efa3743cb870b8a2fb::tbear {
    struct TBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBEAR>(arg0, 6, b"TBEAR", b"Tranquilized Bear", b"Just a Tranquilized Bear Vibes on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4162_9b3b631b7b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

