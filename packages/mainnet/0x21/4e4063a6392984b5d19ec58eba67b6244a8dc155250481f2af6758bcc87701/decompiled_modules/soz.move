module 0x214e4063a6392984b5d19ec58eba67b6244a8dc155250481f2af6758bcc87701::soz {
    struct SOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOZ>(arg0, 9, b"SOZ", b"Zamar", b"Sound of Zamar musical group fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3eaad76-4c82-4315-afd0-85afb06df14e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

