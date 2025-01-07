module 0x7a6d498791826460af111525125be3c27d62c8fd654b6a843a97a6ffb35968bd::rexo {
    struct REXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REXO>(arg0, 9, b"REXO", b"Rexo", b"REXOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REXO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REXO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

