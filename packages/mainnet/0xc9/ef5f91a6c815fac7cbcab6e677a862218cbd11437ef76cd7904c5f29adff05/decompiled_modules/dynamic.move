module 0xc9ef5f91a6c815fac7cbcab6e677a862218cbd11437ef76cd7904c5f29adff05::dynamic {
    struct DYNAMIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYNAMIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DYNAMIC>(arg0, 6, b"DYNAMIC", b"Dynamic 11 by SuiAI", b"The 11' is described as transcendent and ineffable. It is a key concept in understanding the structure of reality, the hierarchy of being, and the spiritual practices aimed at achieving union with this divine source.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/112_7b72751bc7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DYNAMIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYNAMIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

