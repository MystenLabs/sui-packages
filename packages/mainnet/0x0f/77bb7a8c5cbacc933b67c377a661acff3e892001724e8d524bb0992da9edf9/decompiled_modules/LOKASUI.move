module 0xf77bb7a8c5cbacc933b67c377a661acff3e892001724e8d524bb0992da9edf9::LOKASUI {
    struct LOKASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOKASUI>, arg1: 0x2::coin::Coin<LOKASUI>) {
        0x2::coin::burn<LOKASUI>(arg0, arg1);
    }

    fun init(arg0: LOKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKASUI>(arg0, 9, b"LOKA", b"LOKASUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOKASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOKASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOKASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

