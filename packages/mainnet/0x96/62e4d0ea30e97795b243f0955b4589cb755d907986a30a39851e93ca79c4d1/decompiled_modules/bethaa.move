module 0x9662e4d0ea30e97795b243f0955b4589cb755d907986a30a39851e93ca79c4d1::bethaa {
    struct BETHAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETHAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETHAA>(arg0, 9, b"BETHAA", b"betha", b"s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BETHAA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETHAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETHAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

