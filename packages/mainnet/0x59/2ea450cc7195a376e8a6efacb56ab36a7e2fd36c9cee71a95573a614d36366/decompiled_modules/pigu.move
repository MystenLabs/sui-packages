module 0x592ea450cc7195a376e8a6efacb56ab36a7e2fd36c9cee71a95573a614d36366::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 9, b"PIGU", b"PIGU", b"PIGU MAKE GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xfc71274a94f5d9cd1ae6928ecfc9fa910d03eb28258fddeb9842ac3c7b4f3ae6::pigu::pigu.png?size=lg&key=d385f0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

