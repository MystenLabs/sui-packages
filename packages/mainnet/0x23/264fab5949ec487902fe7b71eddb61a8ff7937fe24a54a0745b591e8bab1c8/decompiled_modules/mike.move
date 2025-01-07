module 0x23264fab5949ec487902fe7b71eddb61a8ff7937fe24a54a0745b591e8bab1c8::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKE>(arg0, 6, b"MIKE", b"IRONMIKE", b"Mike Tyson is a legendary athlete, a survivor of personal and professional challenges, and a charismatic individual with a distinctive voice and presence. He continues to captivate audiences with his raw honesty and fascinating life story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731698324873.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

