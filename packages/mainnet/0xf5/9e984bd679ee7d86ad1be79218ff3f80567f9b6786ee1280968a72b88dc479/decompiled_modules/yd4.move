module 0xf59e984bd679ee7d86ad1be79218ff3f80567f9b6786ee1280968a72b88dc479::yd4 {
    struct YD4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: YD4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nYD4";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"daoi";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<YD4>(arg0, 6, b"YD4", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/KFjZkOVGGrgZXc9w")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YD4>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YD4>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

