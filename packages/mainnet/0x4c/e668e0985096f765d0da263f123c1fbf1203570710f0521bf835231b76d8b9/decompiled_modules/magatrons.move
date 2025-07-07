module 0x4ce668e0985096f765d0da263f123c1fbf1203570710f0521bf835231b76d8b9::magatrons {
    struct MAGATRONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGATRONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGATRONS>(arg0, 6, b"MAGATRONS", b"MAGATRON", x"4d41474154524f4e207c2054686520556c74696d617465204d656d65204f7665726c6f7264206f6e205355490a0a4e4f205055424c494320534f4349414c530a0a4e4f2050565020202050757265204d454d452121210a0a4c4f434b494e4720414e44204255524e494e472065766572792031304b204d432c206166746572203130304b2065766572792035304b204d432c206166746572203530304b206576657279203130304b204d432e0a0a4d656574204d41474154524f4e20206e6f74206a757374206120746f6b656e2c2061206d6f76656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifeybn63hk3ztetipzuwqx2uo5kxgafc4h7wqkfb4kfklksxrszse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGATRONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGATRONS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

