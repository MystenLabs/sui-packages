module 0xd5235b6b7521740b7169b1a08edf5a0c8f78d803416c38f7f5a5635e3e15ba::suilluminati {
    struct SUILLUMINATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLUMINATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLUMINATI>(arg0, 6, b"SUILLUMINATI", b"SUILUMINATI", b"IYKYK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_164036721_a2f83efc59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLUMINATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLUMINATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

