module 0xad0afce05601a6582071611576f47c1128d917fa3b4b7258a1d63631283be91c::biaocto {
    struct BIAOCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAOCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAOCTO>(arg0, 6, b"BIAOCTO", b"Biaotoken CTO on Sui", b"Monday strikes again, BIAOCTO's alarm never rang, Rush without a plan. Snack in hand, BIAOCTO trips, Food meets the floor, Five-second rule fails.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_logo_1x1_1_180x180_3edac115e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAOCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIAOCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

