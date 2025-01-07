module 0x6b1d27de0d5a8079468867a1373a4dc14d1010dc61f32ceb48effe051282af92::psd {
    struct PSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSD>(arg0, 9, b"PSD", b"PsyDuck", b"Meme PsyDuck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc8e009d-f481-480b-8f3f-ca26fd10d27a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

