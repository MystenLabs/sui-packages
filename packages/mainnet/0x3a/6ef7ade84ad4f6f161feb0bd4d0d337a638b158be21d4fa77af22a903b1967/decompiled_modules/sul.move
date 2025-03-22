module 0x3a6ef7ade84ad4f6f161feb0bd4d0d337a638b158be21d4fa77af22a903b1967::sul {
    struct SUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUL>(arg0, 9, b"SUl", b"Sul", b"SULSULSUIOLSI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

