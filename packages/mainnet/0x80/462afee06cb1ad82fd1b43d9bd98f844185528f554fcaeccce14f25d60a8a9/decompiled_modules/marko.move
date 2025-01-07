module 0x80462afee06cb1ad82fd1b43d9bd98f844185528f554fcaeccce14f25d60a8a9::marko {
    struct MARKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKO>(arg0, 9, b"marko", b"MK", b"Marko coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARKO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

