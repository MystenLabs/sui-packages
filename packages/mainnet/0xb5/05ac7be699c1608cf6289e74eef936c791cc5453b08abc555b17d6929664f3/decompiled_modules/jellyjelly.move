module 0xb505ac7be699c1608cf6289e74eef936c791cc5453b08abc555b17d6929664f3::jellyjelly {
    struct JELLYJELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYJELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYJELLY>(arg0, 9, b"jellyjelly", b"jelly-my-jelly", b"from these cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWT4jA2ipuevUfBi1a2LW2gfnPJyvHn1JayAe2qz5kRQJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JELLYJELLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYJELLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYJELLY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

