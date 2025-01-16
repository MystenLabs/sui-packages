module 0xe219cf7a8d74d343373f560bcd8f3ce586f28afaa9183513e7921ab69069e4d0::flup {
    struct FLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUP>(arg0, 6, b"FLUP", b"FLUPPY RUN", b"Endless fun with FLUPPY RUN. A legendary game in the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_fb42c36dce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

