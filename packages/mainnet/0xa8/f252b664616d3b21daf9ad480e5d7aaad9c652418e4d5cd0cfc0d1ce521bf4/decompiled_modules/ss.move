module 0xa8f252b664616d3b21daf9ad480e5d7aaad9c652418e4d5cd0cfc0d1ce521bf4::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"SuiStar", x"5375695374617220e28093206120637574652c20667269656e646c79206c6974746c652073746172666973682c206c6976696e672068617070696c79206f6e207468652053756920626c6f636b636861696e2120f09f909ff09f92ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730484276135.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

