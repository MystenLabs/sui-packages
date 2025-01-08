module 0x52b8baa67b2775445054780baba965fbf0b930af7bf64974a9610374a9df8db2::mckosra {
    struct MCKOSRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCKOSRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCKOSRA>(arg0, 9, b"MCKOSRA", b"MKOSR", b"MOCKBETHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCKOSRA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCKOSRA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCKOSRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

