module 0x518bea71422f14c3b0bd1ecabea88b4a0a928cd80c68064df8c3eb9af1376f88::yumssui {
    struct YUMSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMSSUI>(arg0, 6, b"YUMSsui", b"YUMS", b"Yum Party is offering a multi-stage community sale to reward early supporters with access to our token, $YUMS. This sale allows our community to acquire tokens at varying valuations across three phases, leading up to the Token Generation Event (TGE) at the end of December.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0165_8e5921b490.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

