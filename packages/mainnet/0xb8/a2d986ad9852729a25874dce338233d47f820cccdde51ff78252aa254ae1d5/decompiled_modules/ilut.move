module 0xb8a2d986ad9852729a25874dce338233d47f820cccdde51ff78252aa254ae1d5::ilut {
    struct ILUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILUT>(arg0, 9, b"ILUT", b"Illuminati", b"136.17.13.6.7.6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c349fb65-350e-49c8-a263-8331000f9b21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

