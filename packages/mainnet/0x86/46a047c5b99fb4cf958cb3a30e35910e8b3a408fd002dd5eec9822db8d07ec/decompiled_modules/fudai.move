module 0x8646a047c5b99fb4cf958cb3a30e35910e8b3a408fd002dd5eec9822db8d07ec::fudai {
    struct FUDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDAI>(arg0, 6, b"FUDAI", b"FUD AI", b"Leveraging Al to destroy spam and FUD on Telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736037293398.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUDAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

