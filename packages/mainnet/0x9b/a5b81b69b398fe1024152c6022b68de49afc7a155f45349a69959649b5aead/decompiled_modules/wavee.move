module 0x9ba5b81b69b398fe1024152c6022b68de49afc7a155f45349a69959649b5aead::wavee {
    struct WAVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEE>(arg0, 9, b"WAVEE", b"wavee", b"wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6de6ea79-eeb9-4368-aeac-6bfdd22c2e54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

