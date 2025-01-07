module 0x99b3c2bc20d59011cf6f3644a616af968b0737f27a2d1cc52cafd3bfa769bb5b::dedai {
    struct DEDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEDAI>(arg0, 9, b"DEDAI", b"dedai", b"DADEIAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1a3f0c2-dfac-46ca-8649-94f57dad19cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

