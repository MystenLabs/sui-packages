module 0xf183fb3dffd52df4e12c8b0d0ccf79c58cc92ecbbe9a2fb7f2651ebc87070a8b::vcx {
    struct VCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCX>(arg0, 9, b"VCX", b"HDF", b"SDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc914556-0eaf-4fbd-9c27-1648a550f513.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

