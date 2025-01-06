module 0x71a9baf7e8a943f903c02efb552003fbdb814ba00398c86550834c5d5c9a73a9::suicy {
    struct SUICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICY>(arg0, 6, b"SUICY", b"Suicy", x"537569637920746865205365616c20697320746865206963792d636f6f6c206d6173636f74206f66207468652053756920626c6f636b636861696e2c2066726f73747920766962657320616e64206d656d652d776f7274687920636861726d2e202453756963790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_040439_425_43c770ca67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICY>>(v1);
    }

    // decompiled from Move bytecode v6
}

