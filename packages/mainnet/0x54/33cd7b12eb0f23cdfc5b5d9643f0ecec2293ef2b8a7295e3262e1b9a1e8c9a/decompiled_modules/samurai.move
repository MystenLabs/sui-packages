module 0x5433cd7b12eb0f23cdfc5b5d9643f0ecec2293ef2b8a7295e3262e1b9a1e8c9a::samurai {
    struct SAMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMURAI>(arg0, 9, b"Samurai", b"Samurai", b"Samurai Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAMURAI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMURAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

