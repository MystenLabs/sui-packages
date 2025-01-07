module 0xb7fe9e71458767d35924ee77687b521c79106c65ca33e5e0de5f85eac7a3bb8e::cune {
    struct CUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUNE>(arg0, 6, b"CUNE", b"SuiCune", b"The Legendary Beast of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Eyi_1u5_T_400x400_debb94cf5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

