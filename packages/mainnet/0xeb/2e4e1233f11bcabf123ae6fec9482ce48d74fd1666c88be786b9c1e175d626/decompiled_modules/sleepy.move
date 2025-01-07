module 0xeb2e4e1233f11bcabf123ae6fec9482ce48d74fd1666c88be786b9c1e175d626::sleepy {
    struct SLEEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEEPY>(arg0, 6, b"Sleepy", b"Sleep", x"4120746f6b656e20492063616e2062757920616e6420736c65657020706561636566756c6c790a492077696c6c206e6f742062652073656c6c696e6720492077696c6c2062652061736c6565700a476f6f646e69676874", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sleeping_8ab1b0bd6f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

