module 0xa3c874052036b51b7306462fa7ef765c0a1b0e3c36abbe5fb0a9e5aedc5a7911::str {
    struct STR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STR>(arg0, 6, b"STR", b"Strategic Trump Reserve", x"5768657265204149206d6565747320797567652072657475726e730a0a2453545220756e6c656173686573205472756d70204149206f6e205355492c20726561647920746f206275696c6420612062656175746966756c2077616c6c206f662070726f66697473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_040642_929_4d9ad88e41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STR>>(v1);
    }

    // decompiled from Move bytecode v6
}

