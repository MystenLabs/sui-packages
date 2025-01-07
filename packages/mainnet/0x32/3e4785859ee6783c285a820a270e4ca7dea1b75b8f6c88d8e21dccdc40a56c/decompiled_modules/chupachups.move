module 0x323e4785859ee6783c285a820a270e4ca7dea1b75b8f6c88d8e21dccdc40a56c::chupachups {
    struct CHUPACHUPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUPACHUPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUPACHUPS>(arg0, 9, b"CHUPACHUPS", b"Chupa-chup", x"4974e2809973206d656d6520636f696e206368757061206368757073206f6e205375692e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b611630-dc73-4c34-90fb-adc8a8c37b5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUPACHUPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUPACHUPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

