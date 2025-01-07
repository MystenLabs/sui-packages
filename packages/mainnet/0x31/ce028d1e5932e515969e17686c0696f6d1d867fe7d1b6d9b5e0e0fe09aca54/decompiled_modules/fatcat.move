module 0x31ce028d1e5932e515969e17686c0696f6d1d867fe7d1b6d9b5e0e0fe09aca54::fatcat {
    struct FATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATCAT>(arg0, 9, b"FATCAT", b"Fat Cat", b"World fastest cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a31b9cc6-9de3-4db7-8049-54109ed8ea71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

