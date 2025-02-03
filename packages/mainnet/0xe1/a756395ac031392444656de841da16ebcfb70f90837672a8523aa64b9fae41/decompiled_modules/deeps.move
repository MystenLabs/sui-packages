module 0xe1a756395ac031392444656de841da16ebcfb70f90837672a8523aa64b9fae41::deeps {
    struct DEEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEEPS>(arg0, 6, b"DEEPS", b"DEEP SEEK by SuiAI", b"x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/banner_7e609002ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEEPS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

