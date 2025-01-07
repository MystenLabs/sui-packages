module 0x3364e7a45483e0edc6eea87de5ee2c4cad6acb891c70f09866738c4554bd3075::pa {
    struct PA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PA>(arg0, 9, b"PA", b"Paw", b"The first pa on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/288d7722-fc30-4fea-a408-122e4f84fd6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PA>>(v1);
    }

    // decompiled from Move bytecode v6
}

