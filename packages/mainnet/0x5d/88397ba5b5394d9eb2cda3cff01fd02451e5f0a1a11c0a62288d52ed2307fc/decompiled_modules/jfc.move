module 0x5d88397ba5b5394d9eb2cda3cff01fd02451e5f0a1a11c0a62288d52ed2307fc::jfc {
    struct JFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFC>(arg0, 9, b"JFC", b"J-Force", b"Defi Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46528cfa-14e8-49b0-907e-7f4b83b59d14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

