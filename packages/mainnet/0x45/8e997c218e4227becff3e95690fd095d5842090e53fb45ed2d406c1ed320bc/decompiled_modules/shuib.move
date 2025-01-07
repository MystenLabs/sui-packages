module 0x458e997c218e4227becff3e95690fd095d5842090e53fb45ed2d406c1ed320bc::shuib {
    struct SHUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIB>(arg0, 6, b"SHUIB", b"SHUIB INU", b"SHUIB is the new hype on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22da3628_430a_4d88_aea4_4609ec5571f1_17716735a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

