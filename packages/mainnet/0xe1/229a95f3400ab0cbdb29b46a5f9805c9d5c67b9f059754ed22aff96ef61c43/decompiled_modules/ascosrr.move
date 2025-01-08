module 0xe1229a95f3400ab0cbdb29b46a5f9805c9d5c67b9f059754ed22aff96ef61c43::ascosrr {
    struct ASCOSRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASCOSRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASCOSRR>(arg0, 9, b"ASCOSRR", b"ASCOSR", b"SAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASCOSRR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASCOSRR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASCOSRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

