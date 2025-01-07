module 0x84a0264557f16cfa42490dfa3299cf1cb04cbd62810b825461c275cf8ebcdc22::suidragon {
    struct SUIDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRAGON>(arg0, 6, b"SUIDRAGON", b"Sui Dragon", b"Meet the $SUIDRAGON. In the Sui mountains, the Sui Dragon sleeps, guarding old mysteries. Once in a lifetime, it wakes up, bringing ancient power and stories.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Dragon_1_425d4c8c98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

