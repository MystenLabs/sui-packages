module 0x1172387215025bd452a015da6837eff4b87cb933f5813ba31f9987c6c975821::dnt {
    struct DNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNT>(arg0, 9, b"DNT", b"DANTE", b"DANTE IN THA HELL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00d5dd5f-997e-4dfe-9757-a09c21247057.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

