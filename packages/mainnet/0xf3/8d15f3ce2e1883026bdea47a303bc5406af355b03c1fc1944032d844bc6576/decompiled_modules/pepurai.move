module 0xf38d15f3ce2e1883026bdea47a303bc5406af355b03c1fc1944032d844bc6576::pepurai {
    struct PEPURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPURAI>(arg0, 6, b"PEPURAI", b"Sui Pepurai", x"4974206973206120636f6d6d756e6974792d64726976656e20746f6b656e207468617420636f6d62696e657320746865206c6f766520666f72204a6170616e6573652063756c7475726520616e64206172742e2049742069732074686520666972737420746f6b656e2074686174206d6572676573207468652027506570652d6d616e696127207068656e6f6d656e6f6e2077697468204a6170616e6573652063756c7475726520617320612073696e676c65206d656d652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iru_Imp_Go_400x400_ba0c2e7751_330f49fb48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

