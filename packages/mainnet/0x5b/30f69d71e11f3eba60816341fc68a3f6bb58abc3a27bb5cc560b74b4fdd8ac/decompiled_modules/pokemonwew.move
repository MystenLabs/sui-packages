module 0x5b30f69d71e11f3eba60816341fc68a3f6bb58abc3a27bb5cc560b74b4fdd8ac::pokemonwew {
    struct POKEMONWEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMONWEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMONWEW>(arg0, 9, b"POKEMONWEW", b"POKE", b"This coin to support pokemon community,if you love pokemon hobby or others. please buy this coin . thank you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd7c6627-2bdf-4e85-a39d-b482e9877a90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMONWEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKEMONWEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

