module 0x898dcda8dd3d48e4214285e79d2c3cb907314c6ad312f7025b21f88431a77157::north_corea {
    struct NORTH_COREA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORTH_COREA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORTH_COREA>(arg0, 9, b"North Corea", x"f09f8c894e4f52544820434f524541", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NORTH_COREA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORTH_COREA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORTH_COREA>>(v1);
    }

    // decompiled from Move bytecode v6
}

