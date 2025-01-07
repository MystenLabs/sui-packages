module 0xa1a40145e83e5f10a5b7c55d1646540c1edd0f3dda4decfa3945ecf44fb7bd55::aisuidoge {
    struct AISUIDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AISUIDOGE>, arg1: 0x2::coin::Coin<AISUIDOGE>) {
        0x2::coin::burn<AISUIDOGE>(arg0, arg1);
    }

    fun init(arg0: AISUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUIDOGE>(arg0, 2, b"AISUIDOGE", b"SUID", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISUIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUIDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AISUIDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AISUIDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

