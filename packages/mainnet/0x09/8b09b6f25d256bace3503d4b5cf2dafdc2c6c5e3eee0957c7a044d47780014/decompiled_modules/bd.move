module 0x98b09b6f25d256bace3503d4b5cf2dafdc2c6c5e3eee0957c7a044d47780014::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 9, b"BD", b"HED", b"BXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58b2a394-00cd-482a-a57b-d78d6c85f79b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BD>>(v1);
    }

    // decompiled from Move bytecode v6
}

