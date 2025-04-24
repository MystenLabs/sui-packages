module 0xf06a31436f4fceb6fa0bedd7b892e7307a75e970539f6c34d3e0c5902d853d9::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"POKEMON", b"Pikachu on Sui", b"Pikachu is a leading meme coin within the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745526347939.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKEMON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

