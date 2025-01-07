module 0xd81880e13ebe9b4ef6f714c42924b038dc1e4718bf3cd9a41c225c183086f346::BUDLIGHTSCAM {
    struct BUDLIGHTSCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDLIGHTSCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDLIGHTSCAM>(arg0, 9, b"BUDLIGHTSCAM", b"BUDLIGHTSCAM", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUDLIGHTSCAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDLIGHTSCAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUDLIGHTSCAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BUDLIGHTSCAM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

