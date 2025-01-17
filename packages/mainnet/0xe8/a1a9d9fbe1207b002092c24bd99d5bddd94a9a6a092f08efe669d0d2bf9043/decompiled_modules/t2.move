module 0xe8a1a9d9fbe1207b002092c24bd99d5bddd94a9a6a092f08efe669d0d2bf9043::t2 {
    struct T2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T2>(arg0, 9, b"T2", b"TEST2", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T2>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T2>>(v1);
    }

    // decompiled from Move bytecode v6
}

