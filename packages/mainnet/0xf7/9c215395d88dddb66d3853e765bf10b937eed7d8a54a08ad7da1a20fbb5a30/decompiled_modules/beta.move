module 0xf79c215395d88dddb66d3853e765bf10b937eed7d8a54a08ad7da1a20fbb5a30::beta {
    struct BETA has drop {
        dummy_field: bool,
    }

    public fun dummy_field(arg0: &mut 0x2::coin::TreasuryCap<BETA>) {
    }

    public fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<BETA>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETA>>(arg0);
    }

    fun init(arg0: BETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETA>(arg0, 6, b"BETA", b"Beta Testing Strategy", b"Beta test token for validating the updated STRATEGY bonding target.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://placehold.co/256x256/png?text=BETA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BETA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

