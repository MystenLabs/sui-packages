module 0x5f14f599fd2e4a50129a366c93cc541551f68a619defc3634bd9c42ece502645::vgod {
    struct VGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VGOD>(arg0, 9, b"VGOD", b"Vergod", b"Smily kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b680744-38c7-4282-879b-5e6385850a68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

