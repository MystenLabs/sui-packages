module 0xc237d612ae1e03e4371c8d308d2241eb60424d776c58373f1ee636a618ff9189::sabi {
    struct SABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABI>(arg0, 6, b"SABI", b"SUISABI", b"$SABI on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ARD_Kc7lt_400x400_36a02ef275.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

