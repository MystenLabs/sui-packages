module 0xd787cb4a23c9b1918dd41f1fd55c824589d2fc45591ff4c8c8a7edd3ba5f5d9::suiwifhat {
    struct SUIWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIFHAT>(arg0, 6, b"SUIWIFHAT", b"SUICATWIFHAT", b"Get trending", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000123942_64a5acb32a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

