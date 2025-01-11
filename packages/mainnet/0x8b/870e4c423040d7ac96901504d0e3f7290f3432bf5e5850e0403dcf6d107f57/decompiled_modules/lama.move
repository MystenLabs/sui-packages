module 0x8b870e4c423040d7ac96901504d0e3f7290f3432bf5e5850e0403dcf6d107f57::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"LAMA", b"SuiLAMA", b"$LAMA is herelightning-fast, low fees, and packed with fun on the SUI. Hop in and join the moon mission!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198822_0a0a75e8a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

