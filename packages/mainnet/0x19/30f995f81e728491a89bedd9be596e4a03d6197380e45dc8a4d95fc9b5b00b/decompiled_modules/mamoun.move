module 0x1930f995f81e728491a89bedd9be596e4a03d6197380e45dc8a4d95fc9b5b00b::mamoun {
    struct MAMOUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMOUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMOUN>(arg0, 9, b"MAMOUN", b"MAMOUN", b"MAMOUN token deployed with vanity package ID", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MAMOUN>>(0x2::coin::mint<MAMOUN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMOUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMOUN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

