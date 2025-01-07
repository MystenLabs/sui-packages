module 0xc0fd2dcb06a8d3bf08add5fa0e47fdc0d8a85363229b189a6bd40ec309ea3565::iwme {
    struct IWME has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWME>(arg0, 9, b"IWME", b"bskwn", b"hebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03dc4abd-7006-41ea-8471-0e3954348cb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWME>>(v1);
    }

    // decompiled from Move bytecode v6
}

