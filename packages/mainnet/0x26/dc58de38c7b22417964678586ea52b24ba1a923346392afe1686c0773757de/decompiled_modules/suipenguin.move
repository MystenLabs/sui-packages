module 0x26dc58de38c7b22417964678586ea52b24ba1a923346392afe1686c0773757de::suipenguin {
    struct SUIPENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENGUIN>(arg0, 9, b"SUIPENGUIN", x"f09f90a753756950656e6775696e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPENGUIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENGUIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

