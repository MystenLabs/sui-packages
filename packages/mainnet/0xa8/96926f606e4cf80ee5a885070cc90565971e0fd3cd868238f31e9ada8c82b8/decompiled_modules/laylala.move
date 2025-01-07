module 0xa896926f606e4cf80ee5a885070cc90565971e0fd3cd868238f31e9ada8c82b8::laylala {
    struct LAYLALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAYLALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAYLALA>(arg0, 9, b"LAYLALA", b"laylalaTok", b"moa Jack ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f745bf6-47b0-431d-b9a7-5fdb9b09d3bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAYLALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAYLALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

