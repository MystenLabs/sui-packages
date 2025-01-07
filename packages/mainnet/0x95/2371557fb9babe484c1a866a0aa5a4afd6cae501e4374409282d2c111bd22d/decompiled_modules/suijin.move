module 0x952371557fb9babe484c1a866a0aa5a4afd6cae501e4374409282d2c111bd22d::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"Suijin God", x"0a54686520776174657220676f642069732074686520677561726469616e2064656974792077686f20676f7665726e732077617465722028737569292e0a0a68747470733a2f2f747769747465722e636f6d2f5375696a696e5f676f640a68747470733a2f2f7375696a696e2e6d656d652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027961_167f3f8729.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

