module 0x611b5491ee9725e7e4a4f43458b4f84d562ded84ea8f0201a9c463d68a6dc21::memewhale7 {
    struct MEMEWHALE7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEWHALE7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEWHALE7>(arg0, 9, b"MEMEWHALE7", b"Molvain", b"Ai whale shouts out support for the project Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7402ce66-453b-4d6f-a967-40a547bd4b20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEWHALE7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEWHALE7>>(v1);
    }

    // decompiled from Move bytecode v6
}

