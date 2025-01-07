module 0xa806796148e9a0880aa0fd8b67a8f0eaf7ae057cc8c93113ec0f3eae69c4f690::suipac {
    struct SUIPAC has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPAC>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPAC>>(0x2::coin::mint<SUIPAC>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAC>(arg0, 9, b"SuiPac", b"Sui Pac-Man", b"PacMan on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.tvtropes.org/pmwiki/pub/images/pacman_and_the_ghostly_adventures.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPAC>(&mut v2, 400000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

