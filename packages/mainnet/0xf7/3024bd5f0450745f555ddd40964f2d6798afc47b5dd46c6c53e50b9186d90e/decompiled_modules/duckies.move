module 0xf73024bd5f0450745f555ddd40964f2d6798afc47b5dd46c6c53e50b9186d90e::duckies {
    struct DUCKIES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCKIES>, arg1: 0x2::coin::Coin<DUCKIES>) {
        0x2::coin::burn<DUCKIES>(arg0, arg1);
    }

    fun init(arg0: DUCKIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKIES>(arg0, 6, b"DUCKIES", b"DUCKIES", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/nCtyk3h/duckies.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKIES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKIES>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCKIES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUCKIES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

