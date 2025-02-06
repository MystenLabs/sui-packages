module 0x2a30b9f2a284dd9f3753f62aa55c0c5ccbc8a47f7e1bea46afe92a1159113342::minh2 {
    struct MINH2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINH2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINH2>(arg0, 9, b"Minh2", b"Minh2", b"string", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"string")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINH2>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINH2>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINH2>>(v2);
    }

    // decompiled from Move bytecode v6
}

