module 0x922a7116be16f2597c0ab93fd5782a19d238483a7a152b6b1f42f866c2c048e3::sis {
    struct SIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIS>(arg0, 9, b"SIS", b"Sistem", b"Sistem1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c57c7947-cdd2-4aee-9623-9ae8ecd0329f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

