module 0x5b11f0449f3aa1f91955e87f60f2493933a526946357cf408868d222fa47fd37::zappy {
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

