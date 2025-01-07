module 0xc801e0914b9eda2353393d2929577483b4e6e738261f2fd5c6e9430a0edd9bf0::yijg {
    struct YIJG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIJG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIJG>(arg0, 9, b"YIJG", b"Wave", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d9f0dd5-e61c-43ae-81b2-6dc4fe15e43e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIJG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIJG>>(v1);
    }

    // decompiled from Move bytecode v6
}

