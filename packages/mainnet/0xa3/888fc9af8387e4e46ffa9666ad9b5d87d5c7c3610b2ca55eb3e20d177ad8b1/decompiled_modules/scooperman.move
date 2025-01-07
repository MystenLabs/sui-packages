module 0xa3888fc9af8387e4e46ffa9666ad9b5d87d5c7c3610b2ca55eb3e20d177ad8b1::scooperman {
    struct SCOOPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOOPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOOPERMAN>(arg0, 6, b"SCOOPERMAN", b"Scooperman Coin on SUI", b"Scooby Doo + Supperman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3v_Bae4uc_400x400_5e2439e7be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOOPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOOPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

