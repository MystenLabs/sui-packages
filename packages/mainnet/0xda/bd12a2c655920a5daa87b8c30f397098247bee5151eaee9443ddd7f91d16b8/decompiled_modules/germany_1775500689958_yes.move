module 0xdabd12a2c655920a5daa87b8c30f397098247bee5151eaee9443ddd7f91d16b8::germany_1775500689958_yes {
    struct GERMANY_1775500689958_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERMANY_1775500689958_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERMANY_1775500689958_YES>(arg0, 0, b"GERMANY_1775500689958_YES", b"GERMANY_1775500689958 YES", b"GERMANY_1775500689958 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERMANY_1775500689958_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERMANY_1775500689958_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

