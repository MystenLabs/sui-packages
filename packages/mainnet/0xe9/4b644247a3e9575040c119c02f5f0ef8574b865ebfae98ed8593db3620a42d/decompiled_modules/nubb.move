module 0xe94b644247a3e9575040c119c02f5f0ef8574b865ebfae98ed8593db3620a42d::nubb {
    struct NUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBB>(arg0, 6, b"NUBB", b"SUI_NUBB", b"Meet Nubb, a cute, quirky, loving creature. Here to include everyone on our incredible journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731090360152.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

