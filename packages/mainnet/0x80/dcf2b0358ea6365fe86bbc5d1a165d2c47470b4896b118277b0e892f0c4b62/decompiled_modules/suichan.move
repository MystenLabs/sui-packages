module 0x80dcf2b0358ea6365fe86bbc5d1a165d2c47470b4896b118277b0e892f0c4b62::suichan {
    struct SUICHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAN>(arg0, 1, b"SUICHAN", b"SUICHAN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICHAN>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

