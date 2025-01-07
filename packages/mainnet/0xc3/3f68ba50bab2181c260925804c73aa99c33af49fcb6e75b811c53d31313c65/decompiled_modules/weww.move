module 0xc33f68ba50bab2181c260925804c73aa99c33af49fcb6e75b811c53d31313c65::weww {
    struct WEWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWW>(arg0, 9, b"WEWW", b"Juju", b"Just fon to wave wallet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/beb63de4-7f3c-41a2-8ec8-f463402003b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

