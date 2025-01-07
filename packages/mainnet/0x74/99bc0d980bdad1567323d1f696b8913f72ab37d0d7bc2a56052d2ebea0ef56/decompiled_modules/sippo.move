module 0x7499bc0d980bdad1567323d1f696b8913f72ab37d0d7bc2a56052d2ebea0ef56::sippo {
    struct SIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPPO>(arg0, 6, b"SIPPO", b"Seal Hippo", b"Introducing $SIPPO. Seal Hippo, the ultimate aquatic oddity on Sui. Half seal, half hippo and 100% cute.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PNG_1_3e43b5201a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

