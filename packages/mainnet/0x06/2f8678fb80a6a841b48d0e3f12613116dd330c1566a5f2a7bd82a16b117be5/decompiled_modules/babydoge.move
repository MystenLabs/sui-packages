module 0x62f8678fb80a6a841b48d0e3f12613116dd330c1566a5f2a7bd82a16b117be5::babydoge {
    struct BABYDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGE>(arg0, 6, b"BABYDOGE", b"Babydoge coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYDOGE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYDOGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABYDOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

