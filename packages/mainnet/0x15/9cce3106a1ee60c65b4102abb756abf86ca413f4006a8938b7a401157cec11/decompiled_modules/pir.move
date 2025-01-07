module 0x159cce3106a1ee60c65b4102abb756abf86ca413f4006a8938b7a401157cec11::pir {
    struct PIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIR>(arg0, 9, b"PIR", b"DISSA PIR", b"DI SSA PIR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dfb5d4e-5931-4bc3-8b36-34ef2f12fbb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

