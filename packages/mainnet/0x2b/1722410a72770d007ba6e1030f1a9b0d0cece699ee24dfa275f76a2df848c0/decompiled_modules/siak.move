module 0x2b1722410a72770d007ba6e1030f1a9b0d0cece699ee24dfa275f76a2df848c0::siak {
    struct SIAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIAK>(arg0, 9, b"SIAK", b"Siavashk", b"Best cati", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e21846bd-e4af-42f8-b8fe-b6c6d26a1755.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

