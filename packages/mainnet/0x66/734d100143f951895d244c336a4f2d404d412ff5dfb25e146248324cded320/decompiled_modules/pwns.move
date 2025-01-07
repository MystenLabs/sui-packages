module 0x66734d100143f951895d244c336a4f2d404d412ff5dfb25e146248324cded320::pwns {
    struct PWNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWNS>(arg0, 9, b"PWNS", b"nddn", b"hejd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe4f46ab-06e3-42b0-ab5b-44ba7b9adff2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

