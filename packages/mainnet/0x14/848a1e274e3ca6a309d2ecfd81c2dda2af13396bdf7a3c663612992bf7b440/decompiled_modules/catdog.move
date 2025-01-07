module 0x14848a1e274e3ca6a309d2ecfd81c2dda2af13396bdf7a3c663612992bf7b440::catdog {
    struct CATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDOG>(arg0, 9, b"CATDOG", b"Cat&Dog", b"everyone's favorite little catdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6903e6a2-d48e-4334-927f-74dd677e9a4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

