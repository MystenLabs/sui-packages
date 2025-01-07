module 0x573cf6b01f14d883c4ceec5d146993b0eecc34b6253caf88c66128ebdaa61fe8::mret {
    struct MRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRET>(arg0, 6, b"MRET", b"Mr.ET", x"4d722e45542069732068657265206e6f772c20736f20646f6e2774206265206120666f6f6c2c20636f7573652077652070697479206120666f6f6c210a4a6f696e207468652067616e672c20616e64206c657473206669676874206372696d6520746f67657468657220666f6f6c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_04b5eb383f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRET>>(v1);
    }

    // decompiled from Move bytecode v6
}

