module 0x86950e854ee56f8447188e41e242fb77b0768bfb630289b884323bcf1879c4dd::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"Brett", b"First - ever $BRETT token on sui ! Inspired by Brett from matt furie's Boys Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733791067600.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRETT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

