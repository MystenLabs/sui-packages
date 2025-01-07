module 0x33f9c6b9f15232d7f6d48e53985141cff60e93bfeb88413fbc522e1a5e0271b1::hopfish {
    struct HOPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFISH>(arg0, 6, b"HOPFISH", b"HOP FISH SUI", x"46726f6d20486f702077697468204c4f56450a5468657920736179206669736820646f6e2774206a756d702c2049276d20616e20657863657074696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopfish_7264cbf695.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

