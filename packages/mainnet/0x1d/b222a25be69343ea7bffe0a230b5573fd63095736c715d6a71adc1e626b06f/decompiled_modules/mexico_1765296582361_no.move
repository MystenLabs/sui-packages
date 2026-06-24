module 0x1db222a25be69343ea7bffe0a230b5573fd63095736c715d6a71adc1e626b06f::mexico_1765296582361_no {
    struct MEXICO_1765296582361_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEXICO_1765296582361_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEXICO_1765296582361_NO>(arg0, 0, b"MEXICO_1765296582361_NO", b"MEXICO_1765296582361 NO", b"MEXICO_1765296582361 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEXICO_1765296582361_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEXICO_1765296582361_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

