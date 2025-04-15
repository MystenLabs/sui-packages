module 0xf1f79beb980b61f3d1f0e4f1e456bcffca318e90d0ed753d9bfa9929dc1b5245::rango {
    struct RANGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RANGO>(arg0, 6, b"RANGO", b"SUI RANGO", x"52616e676f20697320646976696e6720696e746f20746865205355492065636f73797374656d21200a0a54686520446573657274204b696e672069732061626f757420746f206d616b65207761766520696e2074686520576174657220436861696e202824535549292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihnqh2se6m2oxj6tw44h2epxwg7phfuhh73ilqzwkabo7736crgqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RANGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RANGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

