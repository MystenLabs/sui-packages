module 0xf2951143abc8a376f890feece460205aafbac0b326eb41015f456c942d73098c::axel {
    struct AXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXEL>(arg0, 6, b"AXEL", b"Axel Inu", x"436f6d65206a6f696e206f757220737570657220617765736f6d652063656c6562726174696f6e2077697468206c6f7473206f662063757465206d6f6d656e747320616e64206265737465737420667269656e64736869707320657665722c207768657265207765206d616b652074686520636f6f6c657374206d656d6f72696573210a0a596f7520746f74616c6c79206861766520746f2062652070617274206f662074686520616d617a696e67206a6f75726e65792077697468204158454c2120574f4f4621", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f10922f3_e296_414e_aa7e_a11dff634ac1_0638ecb8f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

