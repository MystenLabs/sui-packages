module 0xbeb0cb2ba377a381aec5a20cbcdbfc3a8f4b2d559f9341ab61f6f79db5c37ad6::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"LUCE", b"Luce The Savior", x"4c756365206973206120796f756e6720776f6d616e2064657374696e656420746f206265636f6d652074686520736176696f7220696e206120776f726c6420656e67756c66656420696e206368616f732e2053696e6365206368696c64686f6f642c204c7563652068617320706f737365737365642061207370656369616c206162696c69747920746861742073686520646f65736ee28099742066756c6c7920756e6465727374616e64207965742c206275742069742069732072656c6174656420746f206c696768742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731008002910.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

