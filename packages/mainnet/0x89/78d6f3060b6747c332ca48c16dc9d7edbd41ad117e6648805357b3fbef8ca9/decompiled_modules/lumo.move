module 0x8978d6f3060b6747c332ca48c16dc9d7edbd41ad117e6648805357b3fbef8ca9::lumo {
    struct LUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMO>(arg0, 9, b"LUMO", b"LUMO Finance", b"LUMO Finance - Real World Asset Token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihe3fjm3a2f7pnyr46tcdlryhxh5dofuod7u7ckyf33h5zwsgzuii?filename=lumo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMO>>(0x2::coin::mint<LUMO>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LUMO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

