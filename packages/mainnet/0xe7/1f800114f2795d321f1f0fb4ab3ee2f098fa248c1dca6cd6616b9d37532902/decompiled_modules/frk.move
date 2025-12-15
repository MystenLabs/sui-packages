module 0xe71f800114f2795d321f1f0fb4ab3ee2f098fa248c1dca6cd6616b9d37532902::frk {
    struct FRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRK>(arg0, 6, b"FRK", b"FREAK", b"Free Real Education And Knowledge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765776863281.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

