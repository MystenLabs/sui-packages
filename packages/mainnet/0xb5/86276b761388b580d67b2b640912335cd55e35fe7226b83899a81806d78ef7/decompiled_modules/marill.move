module 0xb586276b761388b580d67b2b640912335cd55e35fe7226b83899a81806d78ef7::marill {
    struct MARILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARILL>(arg0, 8, b"MARILL", b"Marill", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/183.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARILL>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARILL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

