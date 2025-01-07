module 0x2a6f05614b958cceacd9cdcc3b3a7166ab3a75fa70f6532d2659e117bce522f::suiping {
    struct SUIPING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPING>(arg0, 6, b"SUIPING", b"SUIPINGUIN", b"PENGUIN MASCOT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3589_cfc5169e10.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPING>>(v1);
    }

    // decompiled from Move bytecode v6
}

