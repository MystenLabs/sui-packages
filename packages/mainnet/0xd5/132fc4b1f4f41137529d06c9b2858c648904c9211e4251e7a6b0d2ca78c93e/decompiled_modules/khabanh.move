module 0xd5132fc4b1f4f41137529d06c9b2858c648904c9211e4251e7a6b0d2ca78c93e::khabanh {
    struct KHABANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHABANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHABANH>(arg0, 9, b"KHABANH", x"4b68c3a12042e1baa36e68", x"4e47c3942042c381204b48c381", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ce30c70-e637-4bee-a510-0767cce50f4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHABANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHABANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

