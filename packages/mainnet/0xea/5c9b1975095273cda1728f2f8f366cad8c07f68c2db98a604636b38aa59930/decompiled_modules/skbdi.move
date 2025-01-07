module 0xea5c9b1975095273cda1728f2f8f366cad8c07f68c2db98a604636b38aa59930::skbdi {
    struct SKBDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKBDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKBDI>(arg0, 6, b"SKBDI", b"Suikibidi", x"536b6962696469206f6e205375690a0a214f4e4c5920464f5220425241494e524f545445525321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ASLFK_88344b3942.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKBDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKBDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

