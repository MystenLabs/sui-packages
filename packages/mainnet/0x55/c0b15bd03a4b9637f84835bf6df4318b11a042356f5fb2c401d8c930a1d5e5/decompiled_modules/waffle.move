module 0x55c0b15bd03a4b9637f84835bf6df4318b11a042356f5fb2c401d8c930a1d5e5::waffle {
    struct WAFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAFFLE>(arg0, 6, b"Waffle", b"Blue Waffle", b"diseased pussy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949768051.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAFFLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAFFLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

