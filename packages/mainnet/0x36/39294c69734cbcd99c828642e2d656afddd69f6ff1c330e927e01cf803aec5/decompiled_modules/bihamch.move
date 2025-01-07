module 0x3639294c69734cbcd99c828642e2d656afddd69f6ff1c330e927e01cf803aec5::bihamch {
    struct BIHAMCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIHAMCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIHAMCH>(arg0, 9, b"BIHAMCH", b"Hamhapbi", b"Wowow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cd7a692-05e8-4d0b-b44d-0ebb332857a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIHAMCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIHAMCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

