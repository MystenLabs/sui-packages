module 0x1512e06762bbb9439ca72ebade1aaf2edd583d101700c3fe81d79ed103c9f55e::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 9, b"JOLIE", b"Jolie Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.sarapnow.com/cdn/shop/products/pecknorder-art-collectibles-red-jolly-bee-food-mascot-sticker-30056228323415.jpg?v=1676779431&width=1295"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ACT>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

