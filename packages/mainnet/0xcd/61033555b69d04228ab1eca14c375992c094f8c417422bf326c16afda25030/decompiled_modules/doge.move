module 0xcd61033555b69d04228ab1eca14c375992c094f8c417422bf326c16afda25030::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"Sleep Dog", x"57616b65206d65207570207768656e2077652068697420746865206d756c74692d6d696c6c696f6e20646f6c6c6172206d61726b6574206361700a0a4e6f20736f6369616c732c206e6f20776562736974652c206c657427732077616b652068696d2075702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9970_454ccdd652.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

