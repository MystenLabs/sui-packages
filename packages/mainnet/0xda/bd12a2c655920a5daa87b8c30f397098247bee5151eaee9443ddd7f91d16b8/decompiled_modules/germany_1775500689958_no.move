module 0xdabd12a2c655920a5daa87b8c30f397098247bee5151eaee9443ddd7f91d16b8::germany_1775500689958_no {
    struct GERMANY_1775500689958_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERMANY_1775500689958_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERMANY_1775500689958_NO>(arg0, 0, b"GERMANY_1775500689958_NO", b"GERMANY_1775500689958 NO", b"GERMANY_1775500689958 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERMANY_1775500689958_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERMANY_1775500689958_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

