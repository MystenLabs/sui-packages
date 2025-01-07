module 0x1023f3fa2038cfc977614f984ede7ccdeb68dbe9d51e564519289b7f72cf61e2::fdvgf {
    struct FDVGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDVGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDVGF>(arg0, 6, b"fdvgf", b"fdvgf", b"ff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FDVGF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDVGF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDVGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

