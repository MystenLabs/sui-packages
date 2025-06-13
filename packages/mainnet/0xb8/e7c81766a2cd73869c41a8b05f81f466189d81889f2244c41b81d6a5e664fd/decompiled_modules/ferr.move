module 0xb8e7c81766a2cd73869c41a8b05f81f466189d81889f2244c41b81d6a5e664fd::ferr {
    struct FERR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FERR>, arg1: 0x2::coin::Coin<FERR>) {
        0x2::coin::burn<FERR>(arg0, arg1);
    }

    fun init(arg0: FERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERR>(arg0, 9, b"FERR", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FERR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FERR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FERR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

