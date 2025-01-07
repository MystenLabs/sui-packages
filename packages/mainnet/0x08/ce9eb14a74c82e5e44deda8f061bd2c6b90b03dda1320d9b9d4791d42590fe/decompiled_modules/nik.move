module 0x8ce9eb14a74c82e5e44deda8f061bd2c6b90b03dda1320d9b9d4791d42590fe::nik {
    struct NIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIK>(arg0, 9, b"NIK", b"Nikzo", b"Lone Wolf ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f82c3f70-e5ea-4608-b17f-77c39a45e3d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

