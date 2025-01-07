module 0x1b3efdb9e2010b06064c956f6d4b9161511d21ee43312cda211ff7192f72dab9::mvini {
    struct MVINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVINI>(arg0, 9, b"MVINI", b"Vini", b"Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ba9bd6a-2f72-4ffe-83f1-cd91698aeb77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

