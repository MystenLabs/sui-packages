module 0x744426307459c55c5f31ce06b94ebf08f96b3f7e12eab96e2d065d1added12dc::troge {
    struct TROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROGE>(arg0, 6, b"TROGE", b"Trump Doge", b"Trump + Doge = $TROGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_13_40_28_3b008ea3ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

