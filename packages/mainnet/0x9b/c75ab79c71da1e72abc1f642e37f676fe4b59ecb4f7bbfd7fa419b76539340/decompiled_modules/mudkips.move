module 0x9bc75ab79c71da1e72abc1f642e37f676fe4b59ecb4f7bbfd7fa419b76539340::mudkips {
    struct MUDKIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIPS>(arg0, 6, b"Mudkips", b"Mudkiponsui", x"437574657374204d75646b6970206973206c61756e6368206f6e202353756920626c7570707020626c7570707020f09faba7f09faba7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954474308.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

