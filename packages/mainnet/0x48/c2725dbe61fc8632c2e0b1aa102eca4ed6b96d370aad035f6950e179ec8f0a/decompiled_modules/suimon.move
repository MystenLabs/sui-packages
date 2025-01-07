module 0x48c2725dbe61fc8632c2e0b1aa102eca4ed6b96d370aad035f6950e179ec8f0a::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"SUIMON", b"Suimon", b"Hello Traveler, Suimon will guide you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d4fdaca155fd56e11235dc167c2bbf5d74_22e10e5630.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

