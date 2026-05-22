module 0x25c0af294a5e0221279e9fb76359a2550e9bdb5408f47e2b148d5b0dfaadd6f::tbeta {
    struct TBETA has drop {
        dummy_field: bool,
    }

    public fun dummy_field(arg0: &mut 0x2::coin::TreasuryCap<TBETA>) {
    }

    public fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<TBETA>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBETA>>(arg0);
    }

    fun init(arg0: TBETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBETA>(arg0, 6, b"TBETA", b"Beta Testing Toilet", b"Beta test token for validating the TOILET quote ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://placehold.co/256x256/png?text=TBETA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TBETA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

