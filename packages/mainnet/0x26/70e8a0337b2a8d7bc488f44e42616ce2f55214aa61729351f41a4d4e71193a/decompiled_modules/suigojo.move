module 0x2670e8a0337b2a8d7bc488f44e42616ce2f55214aa61729351f41a4d4e71193a::suigojo {
    struct SUIGOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOJO>(arg0, 9, b"SUIGOJO", b"Gojo", b"Just try it....plz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4281cdfe-e44e-411d-b67c-7c1b12f521af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

