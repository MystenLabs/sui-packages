module 0x202b9dc462f43435d9d7c00f478d0fdaa0b083f27317636cb18010f04aa91551::elonmusk {
    struct ELONMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUSK>(arg0, 9, b"ELONMUSK", b"Muskelon ", b"Fan token of king elon musk ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4c13094-8a48-4b1e-8d63-d4131c82fdea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

