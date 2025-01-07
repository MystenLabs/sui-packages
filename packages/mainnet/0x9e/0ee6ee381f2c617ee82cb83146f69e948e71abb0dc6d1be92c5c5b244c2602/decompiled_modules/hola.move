module 0x9e0ee6ee381f2c617ee82cb83146f69e948e71abb0dc6d1be92c5c5b244c2602::hola {
    struct HOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLA>(arg0, 9, b"HOLA", x"f09f918b486f6c61", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOLA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

