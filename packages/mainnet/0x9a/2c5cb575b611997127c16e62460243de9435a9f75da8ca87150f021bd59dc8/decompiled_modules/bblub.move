module 0x9a2c5cb575b611997127c16e62460243de9435a9f75da8ca87150f021bd59dc8::bblub {
    struct BBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLUB>(arg0, 6, b"BBLUB", b"The Baby Blug", x"4261627920426c756220736f6e206f6620612067756e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_15_003148770_3f0b7c8b9d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

