module 0xc82a81753da20833751996d70bb01d0fac11c4faacad0060041638fa84642369::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"JIGGLY", b"Moon Jiggly", x"4d6f6f6e204a6967676c792069732074686520756e6f6666696369616c20506f6b656d6f6e206f66206d6f6f6e626167732e696f0a4a6f696e20746865206a6967676c79206d6f76656d656e7420746f20746865206d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmgb5mfdbj2pceirsc2dwhprxwhdrpx4ob5tcut4yg54grtht7hy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

