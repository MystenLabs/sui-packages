module 0xf3f385da62fc20e1f9e3833cb0d8bf1b56dc39cb41e8ec3b47349bdd77a43eb9::trybetttt {
    struct TRYBETTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYBETTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYBETTTT>(arg0, 9, b"TRYBETTTT", b"TRYBETTT", b"SDs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYBETTTT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYBETTTT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYBETTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

