module 0xd669a70fef56e7fd8583d7489b12e66e092f8bf0755ccc367958c757e7469c3::pochitai {
    struct POCHITAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITAI>(arg0, 6, b"POCHITAI", b"POCHITA", b"SUII MEME PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pochita_5c52704cf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

