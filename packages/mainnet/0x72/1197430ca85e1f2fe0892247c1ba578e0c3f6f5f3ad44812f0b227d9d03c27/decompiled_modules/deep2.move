module 0x721197430ca85e1f2fe0892247c1ba578e0c3f6f5f3ad44812f0b227d9d03c27::deep2 {
    struct DEEP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP2>(arg0, 9, b"DEEP2", b"DeepTwo", b"A test token for the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEP2>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP2>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP2>>(v1);
    }

    // decompiled from Move bytecode v6
}

