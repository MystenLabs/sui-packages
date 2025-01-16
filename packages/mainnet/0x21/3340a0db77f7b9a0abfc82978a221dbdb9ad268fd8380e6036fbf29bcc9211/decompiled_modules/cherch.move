module 0x213340a0db77f7b9a0abfc82978a221dbdb9ad268fd8380e6036fbf29bcc9211::cherch {
    struct CHERCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHERCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHERCH>(arg0, 6, b"CHeRCH", b"CHeRCH SUI", x"4a7573742061206368757263682e20536572696f75736c792e204120706c61696e206f6c64206368757263682e204e6f7468696e672073696e6973746572206f7220706f737369626c79206576696c206c75726b696e6720756e6465722074686520737572666163652e2057652073776561722e2052656c6967696f6e20686173206265656e2061726f756e642073696e636520746865206461776e206f662074696d652e2057656c636f6d6520746f204348655243482c2061206d756c74692d6379636c652063756c74206d656d6520636f696e2e205768617420636f756c6420676f2077726f6e673f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737010832611.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHERCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHERCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

