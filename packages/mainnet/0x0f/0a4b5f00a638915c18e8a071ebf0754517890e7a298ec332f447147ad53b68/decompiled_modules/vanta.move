module 0xf0a4b5f00a638915c18e8a071ebf0754517890e7a298ec332f447147ad53b68::vanta {
    struct VANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANTA>(arg0, 6, b"VANTA", b"Vanta Sui", b"#000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vanta_016118d718.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

