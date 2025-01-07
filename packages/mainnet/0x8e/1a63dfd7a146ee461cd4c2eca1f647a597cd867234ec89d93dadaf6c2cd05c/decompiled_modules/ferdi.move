module 0x8e1a63dfd7a146ee461cd4c2eca1f647a597cd867234ec89d93dadaf6c2cd05c::ferdi {
    struct FERDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERDI>(arg0, 9, b"FERDI", b"Ferdi dog", b"Ferdidog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa1d61f9-2e86-48e8-bad7-cbcc73ff20c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FERDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

