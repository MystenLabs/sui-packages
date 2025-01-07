module 0x975b18e85044078f98918916f039a1355843b9129a20b9c1d0c5964eeb21a82::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 6, b"Test1", b"Test", b"Test11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a231062d_b1c2_460e_a3f2_e7099daf4d8b_a14e61ed8c_5fd024ae45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST1>>(v1);
    }

    // decompiled from Move bytecode v6
}

