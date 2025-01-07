module 0xa4430295d8fed2cea0a2b355650c16417d4467a6c39b5ed65a891faad5fe53f5::ser {
    struct SER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SER>(arg0, 9, b"SER", b"Sereg", b"Ser45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c7538cd-4484-4711-a1e8-2c9181f563d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SER>>(v1);
    }

    // decompiled from Move bytecode v6
}

