module 0x8e6e2afc7bbf5fdad04ceb5b0a3516b61694ef5df404f04b87fd0437bbb8dcc::grad {
    struct GRAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nGRAD";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dGRAD";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<GRAD>(arg0, 6, b"GRAD", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidotfun.onrender.com/i/vXDx3EdvaBNUtOsP")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

