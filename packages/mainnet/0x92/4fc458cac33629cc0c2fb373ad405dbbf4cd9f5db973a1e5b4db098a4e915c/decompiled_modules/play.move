module 0x924fc458cac33629cc0c2fb373ad405dbbf4cd9f5db973a1e5b4db098a4e915c::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PLAY>(arg0, 6, b"PLAY", b"Sayu by SuiAI", b"play", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Image_2_db1b44ceec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLAY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

