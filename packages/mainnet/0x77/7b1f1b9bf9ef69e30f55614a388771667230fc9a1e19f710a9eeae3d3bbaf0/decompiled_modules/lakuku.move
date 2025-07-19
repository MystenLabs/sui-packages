module 0x777b1f1b9bf9ef69e30f55614a388771667230fc9a1e19f710a9eeae3d3bbaf0::lakuku {
    struct LAKUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAKUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAKUKU>(arg0, 6, b"LAKUKU", b"LABUBU", x"f09fa6b82042652061204c61627562752050696f6e6565723a0a0ae291a02042757920244c414b554b55206f6e20537569204445587320f09f93b20ae291a1205374616b6520e28692206561726e206172742d6261636b6564207969656c647320f09f96bcefb88ff09f92b00ae291a2204a6f696e20746865206d697363686965662120f09f90b0e29ca80a0a46696e616c20536c6964653a0a0af09f90b020244c414b554b553a204e6f74206120746f6b656e20e2809320612076696265210ae29aa120506f7765726564206279205375693a205768657265206d61676963206d65657473207363616c652e0af09f8c88204c6574e2809973207475726e206d6973636869656620696e746f206c656761637921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752950772642.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAKUKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAKUKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

