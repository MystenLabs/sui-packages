module 0x613364d90a6240293b5bc45eb947c77503c76e2d6a9aaacab38e4910ec80952a::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"blue whale", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALE>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

