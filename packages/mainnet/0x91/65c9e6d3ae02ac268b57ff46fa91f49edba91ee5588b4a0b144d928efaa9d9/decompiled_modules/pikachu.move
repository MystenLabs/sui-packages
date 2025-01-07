module 0x9165c9e6d3ae02ac268b57ff46fa91f49edba91ee5588b4a0b144d928efaa9d9::pikachu {
    struct PIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKACHU>(arg0, 9, b"PIKACHU", x"e29aa150696b61636875", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIKACHU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKACHU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

