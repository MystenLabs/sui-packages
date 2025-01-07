module 0x36bb9d27e0fbdf51bee56b26aeb7787f55e417a25f86beae34c1907da38b13e9::melon {
    struct MELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELON>(arg0, 6, b"Melon", b"Free Melon", b"Save the Melon People now!!! Join the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/watermelon_6be8e01566.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

