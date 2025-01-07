module 0x15a98b723aca2730355b1d69ea58ff72530597a40505516fc7b1b4f38ae0a7c4::heile {
    struct HEILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEILE>(arg0, 9, b"HEILE", b"HEILE", b"HEILE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEILE>(&mut v2, 98764321000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEILE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

