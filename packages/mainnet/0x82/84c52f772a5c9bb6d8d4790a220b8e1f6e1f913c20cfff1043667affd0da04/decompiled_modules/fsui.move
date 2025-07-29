module 0x8284c52f772a5c9bb6d8d4790a220b8e1f6e1f913c20cfff1043667affd0da04::fsui {
    struct FSUI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FSUI>, arg1: 0x2::coin::Coin<FSUI>) {
        0x2::coin::burn<FSUI>(arg0, arg1);
    }

    fun init(arg0: FSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSUI>(arg0, 6, b"FSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

