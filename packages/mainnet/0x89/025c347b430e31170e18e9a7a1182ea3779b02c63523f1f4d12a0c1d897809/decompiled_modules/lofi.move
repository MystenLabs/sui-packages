module 0x89025c347b430e31170e18e9a7a1182ea3779b02c63523f1f4d12a0c1d897809::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nLOFI";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dlofi";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/mjMQ06WNdq6XVxTU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

