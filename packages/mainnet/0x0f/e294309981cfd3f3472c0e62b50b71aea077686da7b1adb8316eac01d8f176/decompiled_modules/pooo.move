module 0xfe294309981cfd3f3472c0e62b50b71aea077686da7b1adb8316eac01d8f176::pooo {
    struct POOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOO>(arg0, 9, b"POOO", b"Poo", b"100", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aecfc5b7-8c73-4135-a6d8-7b5a195686ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

