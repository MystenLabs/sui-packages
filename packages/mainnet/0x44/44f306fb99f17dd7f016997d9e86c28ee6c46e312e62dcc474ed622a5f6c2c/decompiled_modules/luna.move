module 0x4444f306fb99f17dd7f016997d9e86c28ee6c46e312e62dcc474ed622a5f6c2c::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"Luna", b"Presenting the most hated potato head to you, Luna.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731004168152.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

