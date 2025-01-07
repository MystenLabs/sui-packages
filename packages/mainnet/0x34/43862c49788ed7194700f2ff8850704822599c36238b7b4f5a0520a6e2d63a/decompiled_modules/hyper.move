module 0x3443862c49788ed7194700f2ff8850704822599c36238b7b4f5a0520a6e2d63a::hyper {
    struct HYPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPER>(arg0, 9, b"HYPER", b"HYPER", b"HYPER Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPER>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

