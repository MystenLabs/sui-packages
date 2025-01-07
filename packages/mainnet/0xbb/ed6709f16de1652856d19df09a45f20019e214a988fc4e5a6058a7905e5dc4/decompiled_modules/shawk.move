module 0xbbed6709f16de1652856d19df09a45f20019e214a988fc4e5a6058a7905e5dc4::shawk {
    struct SHAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWK>(arg0, 6, b"SHAWK", b"SUI SHAWK", x"536861776b206e696d626c792063726f7373657320697473207761746572732c206c75726564206279207468652061726f6d61746963207363656e74206f662074686520626c6f6f6479206d61726b65742c20697420717569636b6c792073686f6f747320746f776172647320697473207072657920616e64206561747320616c6c20726564206469707320636f6d696e67206163726f73732068696d2e0a0a68747470733a2f2f737569736861776b2e78797a2f0a0a68747470733a2f2f782e636f6d2f737569736861776b0a0a68747470733a2f2f742e6d652f737569736861776b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4p_RY_Vf_MZ_400x400_ad3745907b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

