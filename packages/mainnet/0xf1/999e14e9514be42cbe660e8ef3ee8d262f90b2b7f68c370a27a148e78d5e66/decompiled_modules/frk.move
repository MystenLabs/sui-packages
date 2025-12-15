module 0xf1999e14e9514be42cbe660e8ef3ee8d262f90b2b7f68c370a27a148e78d5e66::frk {
    struct FRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRK>(arg0, 6, b"FRK", b"FREAK", b"Free Real Education And Knowledge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765767248007.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

