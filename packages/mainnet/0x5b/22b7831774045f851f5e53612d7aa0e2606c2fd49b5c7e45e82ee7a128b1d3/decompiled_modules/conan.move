module 0x5b22b7831774045f851f5e53612d7aa0e2606c2fd49b5c7e45e82ee7a128b1d3::conan {
    struct CONAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONAN>(arg0, 9, b"CONAN", b"CONAN VLLC", x"436f6e616e436f696e206573206dc3a1732071756520756e61206d6f6e6564612c20657320656c20656d626c656d61206465206c61206c6962657274616420676c6f62616c2e20496e7370697261646120656e20436f6e616e2c206c61206669656c20636f6d7061c3b1657261206465204a6176696572204d696c65692c2073696d626f6c697a61206c6120696e646570656e64656e6369612066696e616e63696572612e20c39a6e65746520616c206d6f76696d69656e746f20717565206465736166c3ad6120656c207374617475732071756f2c2072657370616c6461646f20706f7220436f6e616e2079206c612076697369c3b36e206c6962657274617269612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eca47edc-8069-4781-a105-de018b19f403.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

