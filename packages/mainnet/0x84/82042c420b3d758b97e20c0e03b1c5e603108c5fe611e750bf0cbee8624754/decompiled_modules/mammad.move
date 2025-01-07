module 0x8482042c420b3d758b97e20c0e03b1c5e603108c5fe611e750bf0cbee8624754::mammad {
    struct MAMMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMMAD>(arg0, 9, b"MAMMAD", b"Mmd", b"Its Mmd , plz buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b0baa3f-8c50-4473-869e-f064cb65c6fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMMAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMMAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

