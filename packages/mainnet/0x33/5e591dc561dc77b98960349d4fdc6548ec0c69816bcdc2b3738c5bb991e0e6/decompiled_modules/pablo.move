module 0x335e591dc561dc77b98960349d4fdc6548ec0c69816bcdc2b3738c5bb991e0e6::pablo {
    struct PABLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PABLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PABLO>(arg0, 9, b"PABLO", b"Sad pablo", b"Pablo escobar waiting, lonly man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/830a2a38-cdad-4c38-9de4-51eebd359d66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PABLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PABLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

