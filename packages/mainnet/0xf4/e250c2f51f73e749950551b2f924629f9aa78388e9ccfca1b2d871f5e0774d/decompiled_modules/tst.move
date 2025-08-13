module 0xf4e250c2f51f73e749950551b2f924629f9aa78388e9ccfca1b2d871f5e0774d::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TightToken", b"TightToken for learn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.5148959844.2540/st,small,507x507-pad,600x600,f8f8f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

