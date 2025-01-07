module 0xcbe95424aa79717c4738e9414c2a7c6a173c9e7cd7de9c590db5a7516701cb5::dubai {
    struct DUBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBAI>(arg0, 9, b"dubai", b"dubai", b"dubait", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUBAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

