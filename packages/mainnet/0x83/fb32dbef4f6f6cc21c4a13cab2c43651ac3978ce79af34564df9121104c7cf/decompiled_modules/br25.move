module 0x83fb32dbef4f6f6cc21c4a13cab2c43651ac3978ce79af34564df9121104c7cf::br25 {
    struct BR25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BR25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BR25>(arg0, 9, b"BR25", b"BullRun 25", b"The bull run 2025 is about to kickoff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfd5c278-6354-45e1-8073-691b722d90ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BR25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BR25>>(v1);
    }

    // decompiled from Move bytecode v6
}

