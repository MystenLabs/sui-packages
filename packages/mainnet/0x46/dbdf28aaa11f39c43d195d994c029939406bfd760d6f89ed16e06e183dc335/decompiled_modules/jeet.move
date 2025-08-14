module 0x46dbdf28aaa11f39c43d195d994c029939406bfd760d6f89ed16e06e183dc335::jeet {
    struct JEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEET>(arg0, 9, b"JEET", b"JEET", b"ONLY JEET HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JEET>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEET>>(v2, @0x4888d9d2d81d2451e6fb78c071f6a7514a2bb126fcae8d5f3d296f8b68b140b4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

