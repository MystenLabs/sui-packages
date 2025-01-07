module 0x148273f94a89f5aebea1c2d4e2c21a30442f62042a1ac6e4bec09400621b2e9::salty {
    struct SALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALTY>(arg0, 9, b"SALTY", b"Salty", b"Salty Coin operates on a decentralized blockchain, meaning that no single entity controls the network. This ensures that transactions are secure and cannot be manipulated by any individual or group.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d09bcc98-a06c-46d5-98dd-9d5d2dd5ea1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

