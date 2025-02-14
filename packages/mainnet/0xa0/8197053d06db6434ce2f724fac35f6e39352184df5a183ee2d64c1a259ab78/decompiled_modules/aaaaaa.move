module 0xa08197053d06db6434ce2f724fac35f6e39352184df5a183ee2d64c1a259ab78::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAA>(arg0, 9, b"aaaaaa", b"aaaaaa", b"aaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"aaaaaa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAAAA>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAAAA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AAAAAA>>(v2);
    }

    // decompiled from Move bytecode v6
}

