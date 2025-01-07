module 0x2f393fd0821aaaf3bd2db90686d522cf1e1f2bfc7eb069731140b745a9b35911::suix999 {
    struct SUIX999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX999>(arg0, 6, b"SuiX999", b"SuiX999 NOT BUY", b"100% OR REFUND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020630_3cad1f5815.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX999>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIX999>>(v1);
    }

    // decompiled from Move bytecode v6
}

