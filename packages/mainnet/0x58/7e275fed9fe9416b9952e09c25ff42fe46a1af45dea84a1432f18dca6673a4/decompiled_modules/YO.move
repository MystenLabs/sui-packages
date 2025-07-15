module 0x587e275fed9fe9416b9952e09c25ff42fe46a1af45dea84a1432f18dca6673a4::YO {
    struct YO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YO>(arg0, 6, b"Ero", b"YO", x"2249276d206e6f7420612070657276657274e280a62049276d206120737570657220706572766572742122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YO>>(v1);
    }

    // decompiled from Move bytecode v6
}

