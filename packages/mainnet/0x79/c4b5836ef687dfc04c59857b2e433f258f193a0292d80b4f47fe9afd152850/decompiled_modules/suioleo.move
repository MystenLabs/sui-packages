module 0x79c4b5836ef687dfc04c59857b2e433f258f193a0292d80b4f47fe9afd152850::suioleo {
    struct SUIOLEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOLEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOLEO>(arg0, 6, b"Suioleo", b"Suiole", b"Suiole is a dragon from South Korea on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_intro_1622093873_2411176298_99fe6d0abb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOLEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOLEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

