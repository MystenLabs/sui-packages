module 0x3a2836302eee514536038d907fcdcafd0ac5a6f55d4f46f8ab1b55d831a3d626::acapulco {
    struct ACAPULCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACAPULCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACAPULCO>(arg0, 9, b"ACAPULCO", x"f09f91995375692041636170756c636f", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ACAPULCO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAPULCO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACAPULCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

