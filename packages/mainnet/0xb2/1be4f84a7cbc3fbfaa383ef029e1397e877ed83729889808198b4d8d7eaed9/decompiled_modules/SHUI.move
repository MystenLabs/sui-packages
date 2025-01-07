module 0xb21be4f84a7cbc3fbfaa383ef029e1397e877ed83729889808198b4d8d7eaed9::SHUI {
    struct SHUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHUI>, arg1: 0x2::coin::Coin<SHUI>) {
        0x2::coin::burn<SHUI>(arg0, arg1);
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 2, b"SHUI", b"Feng Shui", b"Harmony and Balance", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

