module 0x7206f7f07353cd8e08020d5e973fac4776dc6c2e67c5a37fa2d92fee91b1480a::sayaka {
    struct SAYAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAYAKA>(arg0, 6, b"SAYAKA", b"Executive Sayaka", x"416e20414920706f776572656420506f6bc3a96d6f6e207468656d656420696e666c75656e636572206167656e742074686174206c6574732074686520636f6d6d756e69747920696e7665737420696e20697473207375636365737320626c656e64696e67206e6f7374616c676961206d656d657320616e6420636f6d6d756e6974792064726976656e20726577617264732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/q2wsx_a6d91bb8e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAYAKA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYAKA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

