module 0xe5cf33baad57e9c8c843451a0963c7d5f6aa05e76109e0a85e8d54233a567be4::nairoai {
    struct NAIROAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAIROAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAIROAI>(arg0, 6, b"NAIROAI", b"NairoAI agent", b"the first ai agent on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735837011877.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAIROAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAIROAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

