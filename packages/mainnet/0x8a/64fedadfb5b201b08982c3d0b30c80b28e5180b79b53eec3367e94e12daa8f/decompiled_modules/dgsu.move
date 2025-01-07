module 0x8a64fedadfb5b201b08982c3d0b30c80b28e5180b79b53eec3367e94e12daa8f::dgsu {
    struct DGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSU>(arg0, 9, b"DGSU", b"Dragonsui", b"Dragonite in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://areajugones.sport.es/wp-content/uploads/2024/03/dragonite-pokemon.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DGSU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

