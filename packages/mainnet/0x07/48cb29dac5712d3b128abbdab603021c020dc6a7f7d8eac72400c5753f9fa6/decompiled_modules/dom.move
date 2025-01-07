module 0x748cb29dac5712d3b128abbdab603021c020dc6a7f7d8eac72400c5753f9fa6::dom {
    struct DOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM>(arg0, 9, b"DOM", b"Dominus", b"Dominus for the win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ba2db1d-23f5-414b-97a0-85c21b1135b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

