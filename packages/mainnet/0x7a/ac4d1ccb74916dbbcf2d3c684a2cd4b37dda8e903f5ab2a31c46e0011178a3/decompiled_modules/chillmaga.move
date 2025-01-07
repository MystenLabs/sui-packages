module 0x7aac4d1ccb74916dbbcf2d3c684a2cd4b37dda8e903f5ab2a31c46e0011178a3::chillmaga {
    struct CHILLMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMAGA>(arg0, 6, b"CHILLMAGA", b"Token Just a chill ", b"Token Just a chill president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732503954343.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLMAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

