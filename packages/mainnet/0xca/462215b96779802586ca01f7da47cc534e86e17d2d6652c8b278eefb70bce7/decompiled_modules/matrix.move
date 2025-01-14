module 0xca462215b96779802586ca01f7da47cc534e86e17d2d6652c8b278eefb70bce7::matrix {
    struct MATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MATRIX>(arg0, 6, b"MATRIX", b"Red Matrix by SuiAI", b"Have you ever had a dream so vivid, so real, that you couldn't shake the feeling it was actually happening? What if you couldn't wake up? How would you know the difference between the dream and reality?.Website: https://redmatrix.world.https://t.me/RedMatrixSuiAi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Red_Matrix_6250d6b0e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MATRIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

