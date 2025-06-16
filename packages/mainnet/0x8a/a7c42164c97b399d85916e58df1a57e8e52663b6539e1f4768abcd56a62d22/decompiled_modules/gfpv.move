module 0x8aa7c42164c97b399d85916e58df1a57e8e52663b6539e1f4768abcd56a62d22::gfpv {
    struct GFPV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFPV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFPV>(arg0, 6, b"GFPV", b"xcvxc", b"dsfcxv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigavbkgffx3ajszeqmfv32xywlz654mrp6sow4zmc5r7gka32srzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFPV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GFPV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

