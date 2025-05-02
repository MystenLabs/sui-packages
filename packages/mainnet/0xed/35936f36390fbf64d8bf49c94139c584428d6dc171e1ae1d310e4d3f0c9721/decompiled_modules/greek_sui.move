module 0xed35936f36390fbf64d8bf49c94139c584428d6dc171e1ae1d310e4d3f0c9721::greek_sui {
    struct GREEK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEK_SUI>(arg0, 9, b"greekSUI", b"Greece Staked SUI", b"For lovers of Greece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/2fb2b955-bc66-4cc6-9cbf-1f1bd9c14092/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEK_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREEK_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

