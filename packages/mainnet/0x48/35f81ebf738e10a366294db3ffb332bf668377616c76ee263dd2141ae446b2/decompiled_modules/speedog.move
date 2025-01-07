module 0x4835f81ebf738e10a366294db3ffb332bf668377616c76ee263dd2141ae446b2::speedog {
    struct SPEEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDOG>(arg0, 6, b"SPEEDOG", b"SPEEDOG ON SUI ", x"48692c2049276d2053706565646f672c2070656f706c652063616c6c0a0a6d6520746865206661737465737420646f67206f6e2074686520706c616e65742c0a0a616e6420492061677265652e204d7920686f6d65206973206f6e207468650a0a53756920626c6f636b636861696e2e0a0a456e747275737420796f757220636f6e666964656e636520696e206d652c0a0a616e6420492077696c6c2073686f7720796f7520686f7720666173740a0a77652063616e20726561636820616d617a696e6720737563636573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731064150273.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEEDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

