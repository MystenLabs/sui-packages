module 0x653d1224f93f4a54faa93e365427525c1700b6935aa9bea262881b49a31de1f8::chillhippo {
    struct CHILLHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLHIPPO>(arg0, 6, b"CHILLHIPPO", b"HIPPO", b"https://t.me/chillhipposui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_23_17_11_30_dedae88129.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

