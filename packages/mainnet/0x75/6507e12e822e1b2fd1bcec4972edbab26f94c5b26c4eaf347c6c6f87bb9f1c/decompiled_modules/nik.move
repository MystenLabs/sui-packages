module 0x756507e12e822e1b2fd1bcec4972edbab26f94c5b26c4eaf347c6c6f87bb9f1c::nik {
    struct NIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIK>(arg0, 9, b"NIK", b"Nikzo", b"An inspired newbea in the crypto space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0979b9db-17e3-485a-b2ef-b46bf8983664.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

