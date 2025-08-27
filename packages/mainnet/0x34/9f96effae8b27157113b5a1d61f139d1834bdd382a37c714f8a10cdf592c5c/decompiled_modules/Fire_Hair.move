module 0x349f96effae8b27157113b5a1d61f139d1834bdd382a37c714f8a10cdf592c5c::Fire_Hair {
    struct FIRE_HAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE_HAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE_HAIR>(arg0, 9, b"FIRE", b"Fire Hair", b"hair thats on fire ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gd1ZBpfWEAAl5hl?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRE_HAIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE_HAIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

