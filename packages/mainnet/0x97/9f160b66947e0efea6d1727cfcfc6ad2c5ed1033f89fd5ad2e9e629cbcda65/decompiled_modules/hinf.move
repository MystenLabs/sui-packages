module 0x979f160b66947e0efea6d1727cfcfc6ad2c5ed1033f89fd5ad2e9e629cbcda65::hinf {
    struct HINF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HINF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HINF>(arg0, 6, b"HINF", b"Hop Is Not Fun", b"Fuck Hop with the delay! We stay on movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOP_3ad6201eb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HINF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HINF>>(v1);
    }

    // decompiled from Move bytecode v6
}

