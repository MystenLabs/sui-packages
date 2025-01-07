module 0xe3671e1e15bb0e4301bca2d14f7bbbba95770f5c3e8bc0d2d21fc36166afffad::hfc {
    struct HFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFC>(arg0, 9, b"HFC", b"Hind Future", b"Social coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HFC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

