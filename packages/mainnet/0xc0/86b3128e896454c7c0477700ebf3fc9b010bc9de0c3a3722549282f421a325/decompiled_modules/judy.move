module 0xc086b3128e896454c7c0477700ebf3fc9b010bc9de0c3a3722549282f421a325::judy {
    struct JUDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUDY>(arg0, 6, b"JUDY", b"JudyAi on SUI", x"4a554459204149206973206e6f74206f6e6c79206120736d61727420746f6f6c2c2062757420616c736f2061207472757374776f7274687920636f6d70616e696f6e2e205769746820746865206162696c69747920746f20756e6465727374616e6420616e64206d6565742075736572206e656564732c204a55445920414920717569636b6c7920626563616d652061207068656e6f6d656e6f6e206f6e20736f6369616c206e6574776f726b732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/darling_1_4632d1deba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

