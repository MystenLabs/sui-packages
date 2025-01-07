module 0x16593258722a7e7c0257535222ac7be68bfbc0f91075c236c06651d85a4d0e3b::tj {
    struct TJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJ>(arg0, 9, b"TJ", b"WAVE", b"For funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be18d65b-e0da-4cad-ae08-443edfd5afaf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

