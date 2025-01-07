module 0xfd4039e286d8974e1e80a813cb6ddc2a62a3775e9cdce81716b6b4b4ee8e7bec::pixy {
    struct PIXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXY>(arg0, 9, b"PIXY", b"Pixel girl", b"Pixel girl token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02f781a7-906a-4478-a5e1-ce45495c065e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

