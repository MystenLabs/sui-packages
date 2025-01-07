module 0x46026ca9a393802d9c36f9ea5badf46779e29fd716eef88101a59ae8815ca61d::beep {
    struct BEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEP>(arg0, 6, b"BEEP", b"BEEP BOOM", x"57686f20776f756c6420686176652074686f7567687420746861742c204245455020424545502c20776f756c64206265636f6d65206120736f756e64206f6620746572726f723f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Beep_bd793e4797.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

