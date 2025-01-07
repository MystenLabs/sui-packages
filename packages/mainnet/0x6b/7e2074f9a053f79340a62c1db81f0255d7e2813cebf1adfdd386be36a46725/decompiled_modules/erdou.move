module 0x6b7e2074f9a053f79340a62c1db81f0255d7e2813cebf1adfdd386be36a46725::erdou {
    struct ERDOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERDOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERDOU>(arg0, 6, b"ERDOU", b"LiuErdou", b"Liu Erdou, Cat of Douyin Fame. Respect The Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ERDOU_70240c3dfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERDOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERDOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

