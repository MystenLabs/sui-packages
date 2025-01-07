module 0x290d9944ec88fb0ea41baf05f3819e794af3b96c59f8b945656ec7b4d6bc586c::snipy {
    struct SNIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPY>(arg0, 6, b"SNIPY", b"Sharp Shooter", b"THE FLUFFIEST SNIPER IN CRYPTO, ALWAYS ON TARGET (WELL, ALMOST)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0132_6efd093a98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

