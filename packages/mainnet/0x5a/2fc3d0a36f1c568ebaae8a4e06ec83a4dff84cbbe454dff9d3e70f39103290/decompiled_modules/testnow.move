module 0x5a2fc3d0a36f1c568ebaae8a4e06ec83a4dff84cbbe454dff9d3e70f39103290::testnow {
    struct TESTNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTNOW>(arg0, 9, b"testnow", b"testnow", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTNOW>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTNOW>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

