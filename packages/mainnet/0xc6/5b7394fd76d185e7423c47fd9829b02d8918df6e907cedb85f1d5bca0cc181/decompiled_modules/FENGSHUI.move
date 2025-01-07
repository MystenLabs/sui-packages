module 0xc65b7394fd76d185e7423c47fd9829b02d8918df6e907cedb85f1d5bca0cc181::FENGSHUI {
    struct FENGSHUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FENGSHUI>, arg1: 0x2::coin::Coin<FENGSHUI>) {
        0x2::coin::burn<FENGSHUI>(arg0, arg1);
    }

    fun init(arg0: FENGSHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGSHUI>(arg0, 2, b"SHUI", b"FENGSHUI", b"Harmony and balance become one, stay neutral and become meme", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FENGSHUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGSHUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FENGSHUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FENGSHUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

