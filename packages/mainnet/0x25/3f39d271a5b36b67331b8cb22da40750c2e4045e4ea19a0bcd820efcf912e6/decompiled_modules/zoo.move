module 0x253f39d271a5b36b67331b8cb22da40750c2e4045e4ea19a0bcd820efcf912e6::zoo {
    struct ZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOO>(arg0, 9, b"Zoo", b"Zoo Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.sarapnow.com/cdn/shop/products/pecknorder-art-collectibles-red-jolly-bee-food-mascot-sticker-30056228323415.jpg?v=1676779431&width=1295"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZOO>(&mut v2, 100000000000, @0x5300ccbb61ca3d8665c1bdb57da71dd221cf65e78f960bd23a8aea83d10559ca, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

