module 0xf28e8749d2241e8f94ae9cdea380d98a5972783a67f4621949fbb401f8fc588a::skbdi {
    struct SKBDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKBDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKBDI>(arg0, 6, b"SKBDI", b"Suikibidi", b"Skibidi on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KSF_a9eeba8ac8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKBDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKBDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

