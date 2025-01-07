module 0x813a5b8bfe779ab3e72015b098cd31d239418f1debb992ecdfb71e612a021e9e::minion {
    struct MINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINION>(arg0, 6, b"MINION", b"Minion", b"Community take over for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730487985639.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

