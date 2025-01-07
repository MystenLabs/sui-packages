module 0xe011846ce6df32ca7b7634291354b4344d08e21b1333d0f3670334203a5019d1::bili {
    struct BILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILI>(arg0, 9, b"BILI", b"Billion", b"Good ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc45abb0-8f23-4d48-849e-35553733fee7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

