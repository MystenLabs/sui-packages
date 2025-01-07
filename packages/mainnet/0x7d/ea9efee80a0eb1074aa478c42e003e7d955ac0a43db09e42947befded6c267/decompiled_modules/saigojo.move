module 0x7dea9efee80a0eb1074aa478c42e003e7d955ac0a43db09e42947befded6c267::saigojo {
    struct SAIGOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIGOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIGOJO>(arg0, 9, b"SAIGOJO", b"Gojo", b"Just try it....plz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc7f230d-7e26-4bef-9ff3-8ce65ffd5c26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIGOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIGOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

