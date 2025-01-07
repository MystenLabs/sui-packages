module 0x6c27971f9e311b40eed07d0e940067971028f13b27f724064f7bf8b4f7de2b57::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 6, b"SBB", b"SUI BRIDGE BOT", x"4272696467652066726f6d20616e7920636861696e20746f205355490a68747470733a2f2f742e6d652f535549427269646765426f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047875_88758f52f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

