module 0x708d00585890be62da4e3eae299162ca5964fc82c29b5841affc455ef1372eed::dengwif {
    struct DENGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGWIF>(arg0, 6, b"DENGWIF", b"Moodeng wif hat", b"First Moodeng wif hat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dengwif_aa5a03aba2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

