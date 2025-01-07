module 0x4206ae6a6b62e71afa8f8410346eadd937a28ba39e2e5f27b1a85a2df86d4711::newcoin {
    struct NEWCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWCOIN>(arg0, 6, b"MYCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWCOIN>>(v1);
        0x2::coin::mint_and_transfer<NEWCOIN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

