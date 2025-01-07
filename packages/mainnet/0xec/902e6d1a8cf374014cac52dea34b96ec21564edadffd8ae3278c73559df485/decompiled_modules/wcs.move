module 0xec902e6d1a8cf374014cac52dea34b96ec21564edadffd8ae3278c73559df485::wcs {
    struct WCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCS>(arg0, 6, b"WCS", b"WEED COIN SUI", b"WCS is the official representative of WEED on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008731_d0c34f717a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

