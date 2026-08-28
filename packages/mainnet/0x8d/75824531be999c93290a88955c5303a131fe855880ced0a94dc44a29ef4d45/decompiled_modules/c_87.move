module 0x8d75824531be999c93290a88955c5303a131fe855880ced0a94dc44a29ef4d45::c_87 {
    struct C_87 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_87, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_87>(arg0, 6, b"87", b"41", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_87>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_87>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

