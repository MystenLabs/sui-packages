module 0xcb88aca5dbcd5e1deb46ed6382ce7e23e130c2fcbc3e6bd85b6dd9dd2159d739::spoo {
    struct SPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOO>(arg0, 6, b"Spoo", b"Sui Pooey", b"Feeling pooey on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3b28af1d_0b0c_4dfb_b46b_1d32751d71d9_3c5628301a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

