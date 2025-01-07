module 0x4cc7871ee53447d2e0aa041b02e80b59d7122e0dabff8fe5c2629a51c57d2b3a::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"PUFFI", b"PUFFI ON SUI REAL", b"The pufferfish in the SUI sea that brings you gainz with a smile!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puffi_984c7de947.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

