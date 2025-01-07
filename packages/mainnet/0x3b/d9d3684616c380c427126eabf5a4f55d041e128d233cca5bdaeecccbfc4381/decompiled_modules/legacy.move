module 0x3bd9d3684616c380c427126eabf5a4f55d041e128d233cca5bdaeecccbfc4381::legacy {
    struct LEGACY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGACY>(arg0, 6, b"Legacy", b"Legacy token", x"4f4720636f6c6c656374696f6e206f6e205375692e200a0a42652070617274206f6620746865206d6f7374206578636c75736976652062756e6368206f6620646567656e73206f6e205375692e20576520766962696e6720746f6765746865722c20776520736861726520616c70686120746f6765746865722c20776520636172652e200a0a4c6574277320707574207468697320746f2077686572652069742062656c6f6e6773202d2074686520746f702e0a0a5448495320495320412046414e20544f4b454e202d204e4f542052454c4154454420544f205448452050524f4a454354", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_fx_Wj0v_400x400_7071f23b63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGACY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGACY>>(v1);
    }

    // decompiled from Move bytecode v6
}

