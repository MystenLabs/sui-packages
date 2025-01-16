module 0x4000c405f40c71bedb9e11f49413f16064fc1112b1e705d9ca6e29766877f234::jolie {
    struct JOLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLIE>(arg0, 9, b"JOLIE", b"Jolie Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.sarapnow.com/cdn/shop/products/pecknorder-art-collectibles-red-jolly-bee-food-mascot-sticker-30056228323415.jpg?v=1676779431&width=1295"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOLIE>(&mut v2, 100000000000000000, @0x5300ccbb61ca3d8665c1bdb57da71dd221cf65e78f960bd23a8aea83d10559ca, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOLIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

