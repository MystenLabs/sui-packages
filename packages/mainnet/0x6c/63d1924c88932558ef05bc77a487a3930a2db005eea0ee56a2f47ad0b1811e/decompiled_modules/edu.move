module 0x6c63d1924c88932558ef05bc77a487a3930a2db005eea0ee56a2f47ad0b1811e::edu {
    struct EDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDU>(arg0, 9, b"EDU", b"Chinedu", b"Personal name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/abb1b263-027c-4619-bea4-064994f43e16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

