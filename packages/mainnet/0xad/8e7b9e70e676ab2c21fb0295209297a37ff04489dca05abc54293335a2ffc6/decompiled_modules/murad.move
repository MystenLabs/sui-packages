module 0xad8e7b9e70e676ab2c21fb0295209297a37ff04489dca05abc54293335a2ffc6::murad {
    struct MURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAD>(arg0, 9, b"MURAD", b"MURAD CTO", b"Murad to billioner ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af82826f-6c1d-4ebe-8ba9-1b1d43d96716.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

