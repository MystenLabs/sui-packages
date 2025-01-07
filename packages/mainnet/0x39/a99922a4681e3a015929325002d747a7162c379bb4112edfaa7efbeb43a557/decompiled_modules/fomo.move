module 0x39a99922a4681e3a015929325002d747a7162c379bb4112edfaa7efbeb43a557::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: 0x2::coin::Coin<FOMO>) {
        0x2::coin::burn<FOMO>(arg0, arg1);
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 9, b"SUP", b"FOMO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOMO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

