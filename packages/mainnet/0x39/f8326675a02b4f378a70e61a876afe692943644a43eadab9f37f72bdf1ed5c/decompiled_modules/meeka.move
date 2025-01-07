module 0x39f8326675a02b4f378a70e61a876afe692943644a43eadab9f37f72bdf1ed5c::meeka {
    struct MEEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEKA>(arg0, 6, b"MEEKA", b"Meeka", b"Tik Tok Talking Husky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732194899043.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

