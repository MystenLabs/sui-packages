module 0xb4414cdddbc587273e9110eca1acfa86f4cf2191ebe60c58fc0fc0bb58d5e7c::kite {
    struct KITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITE>(arg0, 9, b"KITE", b"kite", b"A token named Kite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KITE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

