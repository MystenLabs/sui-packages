module 0x4c920312cbe3ecb21b8fdfa352db2a66e4b7298f7f79772667524f983efdc002::conan {
    struct CONAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONAN>(arg0, 6, b"Conan", b"Conan The Military Dog on SUI", b"New launch. Trump gave this famous dog a medal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trumpdog_53058950d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

