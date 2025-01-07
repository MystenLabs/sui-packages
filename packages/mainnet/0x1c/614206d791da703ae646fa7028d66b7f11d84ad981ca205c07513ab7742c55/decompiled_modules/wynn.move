module 0x1c614206d791da703ae646fa7028d66b7f11d84ad981ca205c07513ab7742c55::wynn {
    struct WYNN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WYNN>, arg1: 0x2::coin::Coin<WYNN>) {
        0x2::coin::burn<WYNN>(arg0, arg1);
    }

    fun init(arg0: WYNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYNN>(arg0, 9, b"WYNN", b"Anita Max Wynn", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WYNN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WYNN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

