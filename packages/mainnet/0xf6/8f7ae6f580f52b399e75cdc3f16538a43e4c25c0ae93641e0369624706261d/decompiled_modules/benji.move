module 0xf68f7ae6f580f52b399e75cdc3f16538a43e4c25c0ae93641e0369624706261d::benji {
    struct BENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENJI>(arg0, 6, b"BENJI", b"Sui Benji", b"Meet Basenji, the oldest dog breed in history, with SUI in its name.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/awb_Zr_XUZ_400x400_022e3adce4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

