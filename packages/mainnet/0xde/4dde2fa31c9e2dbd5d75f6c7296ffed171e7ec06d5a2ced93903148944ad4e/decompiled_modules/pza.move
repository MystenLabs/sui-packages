module 0xde4dde2fa31c9e2dbd5d75f6c7296ffed171e7ec06d5a2ced93903148944ad4e::pza {
    struct PZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZA>(arg0, 9, b"PZA", b"Pizza", b"Best Pizza Meme Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PZA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

