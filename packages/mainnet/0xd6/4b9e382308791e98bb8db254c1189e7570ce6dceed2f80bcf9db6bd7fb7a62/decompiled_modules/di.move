module 0xd64b9e382308791e98bb8db254c1189e7570ce6dceed2f80bcf9db6bd7fb7a62::di {
    struct DI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DI>(arg0, 9, b"DI", b"Dixie ", b"Disks and a lot more of ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e66f8008-f4cd-4148-be66-e1bd370a7167.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DI>>(v1);
    }

    // decompiled from Move bytecode v6
}

