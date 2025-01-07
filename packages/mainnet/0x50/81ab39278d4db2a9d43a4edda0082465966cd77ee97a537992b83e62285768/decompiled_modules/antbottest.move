module 0x5081ab39278d4db2a9d43a4edda0082465966cd77ee97a537992b83e62285768::antbottest {
    struct ANTBOTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTBOTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTBOTTEST>(arg0, 6, b"ANTBOTTEST", b"testtt", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_8_79aef92ffa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTBOTTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTBOTTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

