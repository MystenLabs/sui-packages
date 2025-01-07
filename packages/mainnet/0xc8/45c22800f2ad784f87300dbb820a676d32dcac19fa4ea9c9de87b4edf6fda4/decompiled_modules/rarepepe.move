module 0xc845c22800f2ad784f87300dbb820a676d32dcac19fa4ea9c9de87b4edf6fda4::rarepepe {
    struct RAREPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RAREPEPE>, arg1: 0x2::coin::Coin<RAREPEPE>) {
        0x2::coin::burn<RAREPEPE>(arg0, arg1);
    }

    fun init(arg0: RAREPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAREPEPE>(arg0, 2, b"RRPEPE", b"RRPEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAREPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAREPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAREPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RAREPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

