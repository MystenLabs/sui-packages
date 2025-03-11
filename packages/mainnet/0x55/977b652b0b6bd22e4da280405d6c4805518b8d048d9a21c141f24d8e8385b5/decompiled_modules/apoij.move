module 0x55977b652b0b6bd22e4da280405d6c4805518b8d048d9a21c141f24d8e8385b5::apoij {
    struct APOIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOIJ>(arg0, 9, b"APOIJ", b"Apoij Token", b"Apoij Token for community use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APOIJ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOIJ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APOIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

