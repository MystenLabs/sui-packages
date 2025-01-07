module 0xdaaa571168945cb4f666f8a80b3020d67da5876306d8a08ebb0bb20927eb832d::trumpump {
    struct TRUMPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPUMP>(arg0, 9, b"TRUMPUMP", b"TRUMCOIN", x"4d656d6520436f696e207768696368206d616b65206c6574732072696368206e6f772c20646f6ee2809974206d697373206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54480664-a44f-462d-97af-38523b3ebed6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

