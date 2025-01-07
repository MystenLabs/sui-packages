module 0x226879e522b8fa661b2e47f9aca33596ba4e047d82b714fcf84293eb552d38b3::zappy {
    struct ZAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAPPY>(arg0, 6, b"ZAPPY", b"ZAPPY ON SUI", b"ZAPPY is a vibrant, electrified chameleon who gained super crypto powers after being struck by lightning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DEX_BANNER_LOGO_1b788b449c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

