module 0x2dae5d4d628141981f5b2df7bd9a7115d4ca41b55cbc7cd553fb5d40fe725c3c::purpeplan {
    struct PURPEPLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPEPLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPEPLAN>(arg0, 6, b"PURPEPLAN", b"purpeplan", b"PURPEPLANET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731722923959.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURPEPLAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPEPLAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

