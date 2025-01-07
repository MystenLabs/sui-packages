module 0x25265caba30c3fbb91e17213f9c4bf80da271649adc7901c6918b10b1e8ee25::dft {
    struct DFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFT>(arg0, 9, b"DFT", b"DYOR", b"For faster transaction and swift movement ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6408ddf4-fdab-41e8-ba49-6a080753485d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

