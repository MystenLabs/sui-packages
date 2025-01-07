module 0xe2c615d05cc6689f3bc8f4bbd6b7fc58b5756818d7defac184d30a3c62d0bd44::rcar {
    struct RCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCAR>(arg0, 9, b"RCAR", b"RED CAR", b"lively MEMECOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50f93b41-d38d-4e5d-89fc-46f92729d3a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

