module 0x5666b99dbfa314f1cef056862d45a3a83fbb5acc01cd3ef9f4f6904690f7c6a3::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD>(arg0, 9, b"GOOD", b"Ewere", b"I love this project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8aa34b43-d4eb-41e1-a344-1abfd30d6cf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

