module 0xf7a6b950452f54fdebd445336a43ba6f1403b3cfb1bb8f6cd70ae0f016694305::sui_pi {
    struct SUI_PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PI>(arg0, 9, b"SUI_PI", b"SUIPi", b"SUI-Pi is a connection of the future and the present, Blockchain and World marketplace, connecting Pioneers to the $Sui for prospective 'RWA'.. The main token to merge Pi and Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0ce1004-e737-4497-a53d-59a2257f8853.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

