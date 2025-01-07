module 0xddad451495b9c598e73aaddead53af5bfb3b1e1f55743ede8043cc1ac9d31429::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POG>(arg0, 9, b"POG", x"e2ad90efb88f506f6720737569", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POG>>(v1);
    }

    // decompiled from Move bytecode v6
}

