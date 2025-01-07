module 0xff8667ce137d239a08f86a903d1fa68bfd3006666276c1cc4e38090d2d4f983::suirrel {
    struct SUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRREL>(arg0, 6, b"Suirrel", b"Peanut the Suirrel", b"Peanut the Suirrel also known as P'Nut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/954ef87f_9a0e_40ce_81e5_949708asdasdadwqe1d31be_Convertido_0315ac369c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRREL>>(v1);
    }

    // decompiled from Move bytecode v6
}

