module 0xf8d8663263cdb8b3bbddc4d024d0b40ebd251e9be50fef2f46a3b76912cc53da::deadai {
    struct DEADAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEADAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEADAI>(arg0, 6, b"DEADAI", b"DEAD AI", b"The bot will be activated at 15k Market Cap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736073270651.18")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEADAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

