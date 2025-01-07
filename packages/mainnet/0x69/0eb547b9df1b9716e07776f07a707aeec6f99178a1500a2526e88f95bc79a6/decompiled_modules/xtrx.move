module 0x690eb547b9df1b9716e07776f07a707aeec6f99178a1500a2526e88f95bc79a6::xtrx {
    struct XTRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTRX>(arg0, 9, b"XTRX", b"Expertron", b"Expertron (XTRX) is a utility token designed to revolutionize education and training by empowering learners and trainers in the Expertron ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aeb57b5c-6092-4433-900c-dbd70e705d6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XTRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

