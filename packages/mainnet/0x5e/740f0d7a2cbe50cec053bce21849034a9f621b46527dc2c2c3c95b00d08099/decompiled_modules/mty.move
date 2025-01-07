module 0x5e740f0d7a2cbe50cec053bce21849034a9f621b46527dc2c2c3c95b00d08099::mty {
    struct MTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTY>(arg0, 6, b"MTY", b"Mamuty", x"456e7465727461696e6d656e7420666f7220656e636f75726167656d656e740a0a66756e6e7920616e64207368616e6e79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735918435273.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

