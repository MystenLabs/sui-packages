module 0x81dd8487ba13182fdd95b401ef4688a17396527518ec3a7a9c41838e0697e085::PUGSUI {
    struct PUGSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUGSUI>, arg1: 0x2::coin::Coin<PUGSUI>) {
        0x2::coin::burn<PUGSUI>(arg0, arg1);
    }

    fun init(arg0: PUGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGSUI>(arg0, 2, b"PUGSUI", b"PUGSUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUGSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PUGSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

