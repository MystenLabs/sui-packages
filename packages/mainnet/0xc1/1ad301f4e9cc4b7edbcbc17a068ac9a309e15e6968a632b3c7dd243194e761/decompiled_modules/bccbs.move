module 0xc11ad301f4e9cc4b7edbcbc17a068ac9a309e15e6968a632b3c7dd243194e761::bccbs {
    struct BCCBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCCBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCCBS>(arg0, 6, b"BCCBS", b"cats", b"ntbsbh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739654750928.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCCBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCCBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

