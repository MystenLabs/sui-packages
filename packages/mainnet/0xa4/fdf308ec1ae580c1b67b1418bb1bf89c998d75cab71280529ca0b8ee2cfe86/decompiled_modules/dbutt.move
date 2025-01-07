module 0xa4fdf308ec1ae580c1b67b1418bb1bf89c998d75cab71280529ca0b8ee2cfe86::dbutt {
    struct DBUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBUTT>(arg0, 6, b"DBUTT", b"Dickbutt", x"4469636b4275747420686173206f6666696369616c6c792061727269766564206f6e204d6f766550756d7021200a0a546865206d656d6520796f75206c6f76652c206e6f77206120636f696e20796f756c6c206f6273657373206f7665722e20556e6974696e67207468652061627375726420776974682074686520756e73746f707061626c652c20244449434b42555454206973206865726520746f20646f6d696e61746521204a6f696e20746865206d61646e6573732e20456d627261636520746865204469636b42757474", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_0e5b0d70e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

