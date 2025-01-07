module 0x86eaa2dc06f573a376c22f12c7a26101d1a24c844693a99bfc05f9602fa2a3d6::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"Beluga", b"BelugaOnSui ", b"First Whale on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954867810.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

