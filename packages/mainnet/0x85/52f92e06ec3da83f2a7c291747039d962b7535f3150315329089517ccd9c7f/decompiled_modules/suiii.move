module 0x8552f92e06ec3da83f2a7c291747039d962b7535f3150315329089517ccd9c7f::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"SUIII", b"Suiii on SUI", x"2253756969693a20546865206f6e6c7920636f696e207769746820526f6e616c646f2d6c6576656c2063656c6562726174696f6e20204275696c7420666f7220686f6c6465727320776974682074686520474f4154206d696e6473657420204a6f696e2075732061732077652073636f7265206f75722077617920746f20746865206d6f6f6e212020235375696969202343727970746f220a0a5355494949494949494949494949", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_54a1ffefdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

