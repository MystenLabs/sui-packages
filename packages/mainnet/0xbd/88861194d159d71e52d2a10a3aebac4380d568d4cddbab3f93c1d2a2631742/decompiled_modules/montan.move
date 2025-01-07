module 0xbd88861194d159d71e52d2a10a3aebac4380d568d4cddbab3f93c1d2a2631742::montan {
    struct MONTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONTAN>(arg0, 9, b"MONTAN", b"monta", b"Montan is a very suitable sui compatibility token for gaming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2afb8b16-f672-4ed7-832c-5a9cb0156703.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONTAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONTAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

