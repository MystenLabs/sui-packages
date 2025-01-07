module 0xf014cff220cfdf1872c45d0611f7588e781309ac26a41482574b69f51f1a191e::blumje {
    struct BLUMJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUMJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUMJE>(arg0, 9, b"BLUMJE", b"Blum", b"Je", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4403e211-2f83-4aa3-8928-93a4d1dd7036.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUMJE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUMJE>>(v1);
    }

    // decompiled from Move bytecode v6
}

