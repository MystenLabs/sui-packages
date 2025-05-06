module 0x235f297254c6138ce0a810be244c85893225ccda682a6cc5029d48fc7a21929e::wavex__games_sui {
    struct WAVEX__GAMES_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEX__GAMES_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEX__GAMES_SUI>(arg0, 6, b"WaveX  Games Sui", b"WaveX", b"An On-chain Randomness Swim Race Game on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickuckypyl5riyeahoclqlee5ty34triy2mwcfzflf43ewuiztkpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEX__GAMES_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAVEX__GAMES_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

