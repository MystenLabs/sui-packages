module 0x82397c0c84fe8981815b34a62bd6441769d53f0ce387061baad76ecf23692eb6::spain_1765296582267_yes {
    struct SPAIN_1765296582267_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAIN_1765296582267_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAIN_1765296582267_YES>(arg0, 0, b"SPAIN_1765296582267_YES", b"SPAIN_1765296582267 YES", b"SPAIN_1765296582267 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAIN_1765296582267_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAIN_1765296582267_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

