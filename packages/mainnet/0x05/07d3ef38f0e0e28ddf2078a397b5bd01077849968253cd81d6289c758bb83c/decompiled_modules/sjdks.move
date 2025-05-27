module 0x507d3ef38f0e0e28ddf2078a397b5bd01077849968253cd81d6289c758bb83c::sjdks {
    struct SJDKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJDKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJDKS>(arg0, 9, b"SJDKS", b"DSNFKJDFKJD", b"DFHDKFJDKFJKFJD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SJDKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJDKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJDKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

