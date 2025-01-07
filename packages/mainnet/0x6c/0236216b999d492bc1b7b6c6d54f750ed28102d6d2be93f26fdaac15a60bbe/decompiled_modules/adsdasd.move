module 0x6c0236216b999d492bc1b7b6c6d54f750ed28102d6d2be93f26fdaac15a60bbe::adsdasd {
    struct ADSDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSDASD>(arg0, 9, b"ADSDASD", b"AASDASDAS", b"ASDSADSADSA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0dea67d0-1055-40f6-8d5e-1a0752a0be8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSDASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADSDASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

