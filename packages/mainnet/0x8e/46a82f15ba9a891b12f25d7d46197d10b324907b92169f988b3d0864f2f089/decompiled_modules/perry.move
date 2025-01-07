module 0x8e46a82f15ba9a891b12f25d7d46197d10b324907b92169f988b3d0864f2f089::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 6, b"Perry", b"BLUE PERRY", x"0a506572727920697320626c75652d7465616c20706c61747970757320776974682079656c6c6f772074696e6765642074616e676572696e652077656262696e67206f6e6c79206f6e20686973206261636b206665657420286f646420747261697473207468617420706c6174797075736573206f757473696465206f662044616e76696c6c6520646f6e27742068617665290a0a68747470733a2f2f742e6d652f706c61747970757375690a0a68747470733a2f2f7065727279746865706c617469707573746d2e66756e2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3892_adfee30bec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

