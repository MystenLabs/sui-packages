module 0x5b307a97b00165fc8a0dd4a263a3de3225331b20290e187432e2b4ad011f82e4::nubb {
    struct NUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBB>(arg0, 6, b"NUBB", b"Nubb", x"f09f8c9f2057656c636f6d65212049e280996d206865726520746f20696e74726f64756365204e7562622c2074686520667269656e646c69657374206372656174757265206f6e2074686520537569206e6574776f726b2120f09f90bee29ca82041726520796f7520726561647920746f206469766520696e20616e642074687269766520776974682075733f204c6574e2809973206d616b652074686973206a6f75726e657920756e666f726765747461626c652120f09f9a80f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731040484029.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

