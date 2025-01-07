module 0x5c9aff16103ed1409dc93bcc6786edd1280292605f009ec5479e9f15f6e89606::aquas {
    struct AQUAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAS>(arg0, 6, b"AQUAS", b"AQUA SUI", b"/Sent_it_to_the_moon (https://t.me/nfd_sui_trade_bot?start=GlCQJN1EYiBa)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_11_26_29_86efc0f8e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

