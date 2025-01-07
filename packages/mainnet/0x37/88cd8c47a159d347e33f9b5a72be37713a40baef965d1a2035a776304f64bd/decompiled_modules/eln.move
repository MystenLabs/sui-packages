module 0x3788cd8c47a159d347e33f9b5a72be37713a40baef965d1a2035a776304f64bd::eln {
    struct ELN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELN>(arg0, 9, b"ELN", b"Elon sui", b"Elon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/085a0730-d661-4a87-8c18-f79f88a0bb87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELN>>(v1);
    }

    // decompiled from Move bytecode v6
}

