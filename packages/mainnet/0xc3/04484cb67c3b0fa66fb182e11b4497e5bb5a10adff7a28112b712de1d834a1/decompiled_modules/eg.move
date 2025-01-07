module 0xc304484cb67c3b0fa66fb182e11b4497e5bb5a10adff7a28112b712de1d834a1::eg {
    struct EG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EG>(arg0, 9, b"EG", b"Eagle", b"Eagle fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe62fda5-b14c-4b83-a866-20d7b00d4442.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EG>>(v1);
    }

    // decompiled from Move bytecode v6
}

