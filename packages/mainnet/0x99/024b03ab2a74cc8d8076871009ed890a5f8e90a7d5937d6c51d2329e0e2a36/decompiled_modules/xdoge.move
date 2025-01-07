module 0x99024b03ab2a74cc8d8076871009ed890a5f8e90a7d5937d6c51d2329e0e2a36::xdoge {
    struct XDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDOGE>(arg0, 6, b"XDOGE", b"X DOGE", b"X Account created by Elon for the Department of Government Efficiency ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_13_19_25_48_97fe06aeff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

