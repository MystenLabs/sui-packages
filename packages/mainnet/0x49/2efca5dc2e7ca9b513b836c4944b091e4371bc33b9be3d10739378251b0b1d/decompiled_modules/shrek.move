module 0x492efca5dc2e7ca9b513b836c4944b091e4371bc33b9be3d10739378251b0b1d::shrek {
    struct SHREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREK>(arg0, 6, b"SHREK", b"SUIREK", b"SUI REK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirek_93c244bc6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

