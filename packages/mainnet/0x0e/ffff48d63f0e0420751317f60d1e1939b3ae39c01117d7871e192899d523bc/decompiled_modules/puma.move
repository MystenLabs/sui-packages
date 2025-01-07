module 0xeffff48d63f0e0420751317f60d1e1939b3ae39c01117d7871e192899d523bc::puma {
    struct PUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMA>(arg0, 6, b"PUMA", b"SUIPUMA", b"SUIPUMA aims to help wild animals and endangered animals in the evolving and developing world, and we will transfer a portion of our profits to the rescue of these animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197734_be4d571df8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

