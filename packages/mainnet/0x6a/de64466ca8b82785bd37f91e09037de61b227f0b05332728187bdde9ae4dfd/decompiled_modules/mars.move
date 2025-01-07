module 0x6ade64466ca8b82785bd37f91e09037de61b227f0b05332728187bdde9ae4dfd::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 9, b"MARS", b"ElonwifSuiOn", x"456c6f6e7769665375694f6e20697320612066756e2c206d656d652d696e73706972656420746f6b656e206f6e207468652053554920626c6f636b636861696e2c206f66666572696e67206661737420616e6420736563757265207472616e73616374696f6e732e20576974682069747320706c617966756c2c20686967682d656e6572677920766962652c206974e280997320616c6c2061626f757420636f6d6d756e69747920616e64206578636974656d656e7420696e207468652063727970746f20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1788248922244390917/ql0Kgnen.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARS>(&mut v2, 80000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

