module 0x6c71ae402f2cfd52cd65a7fc2a76cd57df561c0e03785a25c8c17781f18ad716::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 6, b"BOOM", b"Sui Boom", b"Ready to blow away the bears? https://x.com/TheSuiBoom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_1faba5890f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

