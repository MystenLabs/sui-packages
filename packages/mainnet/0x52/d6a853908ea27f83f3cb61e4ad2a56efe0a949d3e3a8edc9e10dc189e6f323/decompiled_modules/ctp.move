module 0x52d6a853908ea27f83f3cb61e4ad2a56efe0a949d3e3a8edc9e10dc189e6f323::ctp {
    struct CTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTP>(arg0, 9, b"CTP", b"CTP", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

