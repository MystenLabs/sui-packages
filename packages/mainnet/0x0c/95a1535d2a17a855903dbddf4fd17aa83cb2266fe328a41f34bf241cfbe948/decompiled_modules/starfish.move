module 0xc95a1535d2a17a855903dbddf4fd17aa83cb2266fe328a41f34bf241cfbe948::starfish {
    struct STARFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARFISH>(arg0, 6, b"Starfish", b"STARF", b"A starfish wandering in the sea, afraid of being eaten by big fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OW_8_MX_Ciy_400x400_7b339b6f8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

