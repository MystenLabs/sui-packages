module 0xbc964a94363b25c135a3098518ecd2c11b525965629d957b937dc5b4cdbb753a::SKI {
    struct SKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKI>(arg0, 6, b"SKI", b"SKI", b"SKI TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/SKI_03b37ed889.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKI>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SKI>(&mut v2, 1000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKI>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

