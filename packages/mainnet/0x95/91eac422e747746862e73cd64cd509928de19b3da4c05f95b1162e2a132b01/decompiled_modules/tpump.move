module 0x9591eac422e747746862e73cd64cd509928de19b3da4c05f95b1162e2a132b01::tpump {
    struct TPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPUMP>(arg0, 9, b"TPUMP", b"Trump Pump", b"TPump is created to celebrate Donald J. Trump success in 2024 US election. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0fcf6f4-28dd-445a-824c-1d74804a36e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

