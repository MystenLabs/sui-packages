module 0xcb106294e28a8aae5f757992f3976062af5dc0437d30b7fa4a6daec2c1d8f72f::scam4 {
    struct SCAM4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM4>(arg0, 6, b"SCAM4", b"SCAM", b"Scam Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_bda1dcc697.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM4>>(v1);
    }

    // decompiled from Move bytecode v6
}

