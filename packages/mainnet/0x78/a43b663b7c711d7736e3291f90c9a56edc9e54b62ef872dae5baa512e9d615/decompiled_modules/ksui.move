module 0x78a43b663b7c711d7736e3291f90c9a56edc9e54b62ef872dae5baa512e9d615::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 9, b"KSUI", b"Krisui ", b"Meme for charity to people in Sub-Sahara Africa's & India affected by flood, terrorism, Bad government etc ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54e6d2ce-74aa-4e2a-b3ca-89cbab14efbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

