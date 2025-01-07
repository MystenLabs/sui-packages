module 0x3eda95dd689e7a6e0bf6cb145dee055b8286cd9098e6c1c33f7559e5ad0a94f4::pwme {
    struct PWME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWME>(arg0, 9, b"PWME", b"jejr", b"jdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf1d7d9a-9d55-4d53-a54a-9d73af45825d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWME>>(v1);
    }

    // decompiled from Move bytecode v6
}

