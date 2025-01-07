module 0x1980fa23e0e3c2cd718db0e9ee9802dcac8aa4085bfee8424a9fc810696e16c9::adeni {
    struct ADENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENI>(arg0, 6, b"ADENI", b"Adebibutaxolo", b"Adeniyi is my daddy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tumblr_n0038u3x_Li1rdilhwo1_1280_ff76824e49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENI>>(v1);
    }

    // decompiled from Move bytecode v6
}

