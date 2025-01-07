module 0x2ad8061c96af24eaf90d6d63ca8165112f9421e0c546909c895ac3af4b664905::pokemonwew {
    struct POKEMONWEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMONWEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMONWEW>(arg0, 9, b"POKEMONWEW", b"POKE", b"This coin to support pokemon community,if you love pokemon hobby or others. please buy this coin . thank you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc7f0ace-47e9-42a0-9a49-8c923b61711a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMONWEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKEMONWEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

