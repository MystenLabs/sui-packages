module 0x46f95590344a4cba172be08dfaa91daf6db3f6ddf3d84827f2dfacd04f747664::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"Suai", b"The first real Ai on $sui -launched on Turbo NOW LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731449661850.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

