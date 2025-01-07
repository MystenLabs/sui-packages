module 0x5fb0f43fd9abe04f5b93d772bdf3e9505d415142cb34627e3a3210822552c385::sets {
    struct SETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETS>(arg0, 6, b"SETS", b"Sui Estates", b"The first real world assets (RWA) built on SUI. Rewarding investors for life forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731371165861.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SETS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

