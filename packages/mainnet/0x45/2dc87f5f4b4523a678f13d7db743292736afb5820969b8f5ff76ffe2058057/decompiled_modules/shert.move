module 0x452dc87f5f4b4523a678f13d7db743292736afb5820969b8f5ff76ffe2058057::shert {
    struct SHERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERT>(arg0, 6, b"SHERT", b"SUI HEART", b"Love sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000084554_f1375a8109.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

