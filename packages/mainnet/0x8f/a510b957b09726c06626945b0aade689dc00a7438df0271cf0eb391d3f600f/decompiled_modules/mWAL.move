module 0x8fa510b957b09726c06626945b0aade689dc00a7438df0271cf0eb391d3f600f::mWAL {
    struct MWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWAL>(arg0, 9, b"symWAL", b"SY mWAL", b"SY Mirai Staked WAL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

