module 0xd5e36ff7f6bb5ae7c3a5b2c2d3015966377f54a8874ded09bbe8a7d614a2ca44::gaylo {
    struct GAYLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYLO>(arg0, 9, b"GAYLO", b"masterchief gay", b"well done Melissa Boone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAYLO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

