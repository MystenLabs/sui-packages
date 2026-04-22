module 0xf207ade6d685efb769843233ccf23af55df2f52fa402e107b456f2bdd6202dac::barcelona_1775638815819_yes {
    struct BARCELONA_1775638815819_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARCELONA_1775638815819_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARCELONA_1775638815819_YES>(arg0, 0, b"BARCELONA_1775638815819_YES", b"BARCELONA_1775638815819 YES", b"BARCELONA_1775638815819 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARCELONA_1775638815819_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARCELONA_1775638815819_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

