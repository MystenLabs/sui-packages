module 0x398c9ce354684425f2fdfbb05394d6a4c96500d01a4c2adf23e35ee9bf6607ed::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIME>(arg0, 6, b"PRIME", b"PRIME MACHIN", b"Prime Machin #2550 manufactured by the Triangle Company.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PM_cce7a96448.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

