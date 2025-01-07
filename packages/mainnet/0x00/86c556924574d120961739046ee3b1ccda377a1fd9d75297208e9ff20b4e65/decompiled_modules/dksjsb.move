module 0x86c556924574d120961739046ee3b1ccda377a1fd9d75297208e9ff20b4e65::dksjsb {
    struct DKSJSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKSJSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKSJSB>(arg0, 9, b"DKSJSB", b"Suskmd", b"Sjahsjn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42984ea1-daef-40ba-ae6d-68bb6bfefb47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKSJSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKSJSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

