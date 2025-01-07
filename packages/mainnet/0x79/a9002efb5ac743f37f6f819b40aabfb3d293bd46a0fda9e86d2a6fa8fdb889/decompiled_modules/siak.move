module 0x79a9002efb5ac743f37f6f819b40aabfb3d293bd46a0fda9e86d2a6fa8fdb889::siak {
    struct SIAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIAK>(arg0, 9, b"SIAK", b"Siavashk", b"Best cati", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/168e058d-b305-43b1-a010-4205fef31bcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

