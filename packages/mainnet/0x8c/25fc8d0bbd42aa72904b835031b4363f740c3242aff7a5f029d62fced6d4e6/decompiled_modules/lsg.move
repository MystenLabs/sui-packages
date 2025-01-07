module 0x8c25fc8d0bbd42aa72904b835031b4363f740c3242aff7a5f029d62fced6d4e6::lsg {
    struct LSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSG>(arg0, 9, b"LSG", b"Lesgo", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d7a746e-6a7a-48c2-9b89-95de6c6653df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

