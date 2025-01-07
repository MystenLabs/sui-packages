module 0x6b7a8f1d3c367f62486a750e6b63551bc615e543f84255b3e563d5c09b732ac6::suq {
    struct SUQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUQ>(arg0, 6, b"SUQ", b"SuQuirtle", x"537551756972746c652069732061206e6f7374616c67696120636f6d6d756e6974792d64726976656e206d656d652064657369676e656420746f20696e6a6563742068756d6f7220616e642063726561746976697479206f6e2074686520537569204e6574776f726b2e2047657420726561647920746f2072696465207468652077617665206265636175736520537551756972746c65206973206865726520746f206d616b652061206f7267616e69632073706c61736821200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2dbec8373b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

