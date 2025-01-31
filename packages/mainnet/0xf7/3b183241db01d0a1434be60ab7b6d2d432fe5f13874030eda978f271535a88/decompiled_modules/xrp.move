module 0xf73b183241db01d0a1434be60ab7b6d2d432fe5f13874030eda978f271535a88::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 6, b"XRP", b"XRP on Sui ", b"XRP on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738297531311.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

