module 0x5d50bf07b84e1b5d13886342933b8a29cd8e53f06d9fe639179d895ab3a7b456::dojij {
    struct DOJIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJIJ>(arg0, 6, b"Dojij", b"SuiDojij", b"Only degens are allowed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yu50_KSWIAA_8_X_Wo_72a001f8bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOJIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

