module 0xaa5f807a886473196d4aa704e92e3908ae1636a69dc18aaa08c0b238f914d29d::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPSON>(arg0, 6, b"Suimpson", b"Bart Suimpson", b"Bart, the mischievous son of Homer Suimpson, is known for his rebellious personality and memorable catchphrases like \"Ay, caramba!\" and \"Don't have a cow, man!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eb73023f64fa48c889262717503d46e2_ba5e3e85c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

