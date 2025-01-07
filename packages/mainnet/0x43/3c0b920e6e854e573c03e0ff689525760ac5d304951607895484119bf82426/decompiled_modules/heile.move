module 0x433c0b920e6e854e573c03e0ff689525760ac5d304951607895484119bf82426::heile {
    struct HEILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEILE>(arg0, 9, b"HEILE", b"HEILE", b"HEILE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEILE>(&mut v2, 987654321000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEILE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

