module 0xbc897f4d83d8585ec1a68b1e1973fece6d93d3125722defb26248c382dd19d10::spdog {
    struct SPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPDOG>(arg0, 6, b"SPDOG", b"Space Dogs", b"SpaceDog: A resilient crypto mascot inspired by water bears, surviving extreme conditions while navigating financial markets with unshakeable strength.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_Xx_GB_Fj_E_400x400_04bd2b99d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

