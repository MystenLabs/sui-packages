module 0x6a307f169d3e878e2b559bafa196e2da8ed878d2e8dafe059cff766520a3d7d9::sooi {
    struct SOOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOI>(arg0, 9, b"SOOI", b"SOOI", b"So good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOOI>(&mut v2, 6000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

