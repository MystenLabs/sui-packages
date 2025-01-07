module 0x6fbeab291fb75dbcd3a6cf16553ffa3c31b45e28e2338c9b575dbdc0a03cfa06::gicko {
    struct GICKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GICKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GICKO>(arg0, 6, b"GICKO", b"THE GICKO", b"gicko is here on SUI! This gecko may look chill, but he's ready to shake up the crypto world. Are you in? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profil_1_909b802379.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GICKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GICKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

