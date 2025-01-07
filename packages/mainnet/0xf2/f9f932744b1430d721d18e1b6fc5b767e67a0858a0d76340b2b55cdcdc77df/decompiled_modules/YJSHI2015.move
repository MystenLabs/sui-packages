module 0xf2f9f932744b1430d721d18e1b6fc5b767e67a0858a0d76340b2b55cdcdc77df::YJSHI2015 {
    struct YJSHI2015 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YJSHI2015>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YJSHI2015>>(0x2::coin::mint<YJSHI2015>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YJSHI2015, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJSHI2015>(arg0, 9, b"YJSHI2015", b"YJSHI2015", b"yjshi2015's coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YJSHI2015>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YJSHI2015>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

