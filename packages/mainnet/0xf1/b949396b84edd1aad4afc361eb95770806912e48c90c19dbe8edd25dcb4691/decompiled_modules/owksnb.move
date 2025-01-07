module 0xf1b949396b84edd1aad4afc361eb95770806912e48c90c19dbe8edd25dcb4691::owksnb {
    struct OWKSNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKSNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKSNB>(arg0, 9, b"OWKSNB", b"isksn", b"hsjanwb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f979c51-acbe-4a34-935b-51ae346775fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKSNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKSNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

