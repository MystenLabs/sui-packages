module 0x323c1128d9e051c59fdaa5e8b164a21f2c277b44dda47e214da1c94fc171002a::gdsag {
    struct GDSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSAG>(arg0, 9, b"GDSAG", b"DAG", b"SAF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75ad701e-a76d-45f1-a06a-83d7226e308f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

