module 0x79c293f773ff4cd96efa8c3852fedbd921175ada6bd4346a7bb6222f523c52b::GAMESTOP {
    struct GAMESTOP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GAMESTOP>, arg1: 0x2::coin::Coin<GAMESTOP>) {
        0x2::coin::burn<GAMESTOP>(arg0, arg1);
    }

    fun init(arg0: GAMESTOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMESTOP>(arg0, 2, b"GME", b"GAMESTOP", b"GME TO THE MOON, LETS MAKE THIS SHORT SQUEEZE", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMESTOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMESTOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GAMESTOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GAMESTOP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

