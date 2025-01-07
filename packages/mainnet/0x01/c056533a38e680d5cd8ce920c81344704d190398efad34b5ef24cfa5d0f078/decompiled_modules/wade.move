module 0x1c056533a38e680d5cd8ce920c81344704d190398efad34b5ef24cfa5d0f078::wade {
    struct WADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADE>(arg0, 6, b"Wade", b"Wade Ripple", b"wade just arrived on sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qrqwe_40261f7bf0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

