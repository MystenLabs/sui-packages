module 0x83a56d027bec77663e0bc40a22a0590d2cd675801293ea8b4de672e2490529e2::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKI>(arg0, 9, b"SUIKI", b"Suiki", b"Sui Suiki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKI>>(v2, @0x394a29f13a518801d253dd20d7e094ebc7fcc5982cd3e8d5d2c3a31f01f8cc01);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

