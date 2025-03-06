module 0xba567f1b25771da45a8f91f1cde626dc167b7b7221a46fbb50f427e4b01d23db::top {
    struct TOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOP>(arg0, 9, b"TOP", b"Top Token", b"A new token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

