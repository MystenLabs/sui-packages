module 0xa5a2b0db5b4e71de21239a002dfa6717465f15b5c289a44765df0f4d2f0bb959::oneoneone {
    struct ONEONEONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEONEONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEONEONE>(arg0, 9, b"OneoNeOne", b"111", b"hufbhebhebhebhbef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONEONEONE>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEONEONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEONEONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

