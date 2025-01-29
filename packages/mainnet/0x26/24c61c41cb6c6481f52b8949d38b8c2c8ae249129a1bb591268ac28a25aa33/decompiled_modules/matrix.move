module 0x2624c61c41cb6c6481f52b8949d38b8c2c8ae249129a1bb591268ac28a25aa33::matrix {
    struct MATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATRIX>(arg0, 6, b"MATRIX", b"Matrix Oracle", b"Matrix Oracle: The 1st AI agent crafting evolving, user-shaped stories for a personalized, immersive experience built on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738182107468.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATRIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

