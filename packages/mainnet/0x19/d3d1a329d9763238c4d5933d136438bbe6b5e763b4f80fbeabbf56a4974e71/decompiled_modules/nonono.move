module 0x19d3d1a329d9763238c4d5933d136438bbe6b5e763b4f80fbeabbf56a4974e71::nonono {
    struct NONONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONONO>(arg0, 6, b"NONONO", b"TEST_COIN_PLZ_IGNORE", x"7468697320697320406d6f72616c5f6361706974616c2e20646f6e27742062757920746869732073747570696420636f696e2e207765277265206a7573742074657374696e6720666f722061206675747572652064726f702e0a0a616761696e2c20646f6e277420627579207468697320636f696e2e207765206172656e277420676f696e6720746f20737570706f72742069742e207765277265206e6f7420676f696e6720746f20646f20616e797468696e6720776974682069742e0a0a697420776f756c642062652073747570696420746f20627579207468697320636f696e2e20646f6e277420646f2069742e20736572696f75736c792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_16_at_11_18_26a_PM_c342a6c8ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

