module 0x98b4d3bbd4f06600f2ce3b554bc7f4ccd7675e8b302729d597497e6d5eab678d::sinkbowl {
    struct SINKBOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINKBOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINKBOWL>(arg0, 6, b"SINKBOWL", b"Sink Bowl", x"5768657468657220796f75277265206865726520746f20636f6c6c6563742c2073686172652c206f72206a757374206d656d652061726f756e642c2053696e6b20426f776c20697320796f7572206e6577206661766f726974652073706f742e204469766520696e2077652070726f6d6973652069742773206e6f7420636c6f67676564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sinkbowl1_68fbb2e063.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINKBOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINKBOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

