module 0xb263a0e1cde9bf377e0a1c11ebfeb98723e08aa56150526b2a800a8329675fad::toti {
    struct TOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTI>(arg0, 9, b"TOTI", b"TOTI", b"TOTIL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOTI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

