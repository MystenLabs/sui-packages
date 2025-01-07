module 0x722d9aa85554e99ec33efe89eac5319aa5c8977877ebb96e4272fe4b1d99f103::zvanton {
    struct ZVANTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZVANTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZVANTON>(arg0, 6, b"ZVANTON", b"Antot_ZVyakov", b"fdsfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986670702.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZVANTON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZVANTON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

