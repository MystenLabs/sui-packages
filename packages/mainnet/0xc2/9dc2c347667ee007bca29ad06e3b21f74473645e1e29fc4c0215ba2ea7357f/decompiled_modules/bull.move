module 0xc29dc2c347667ee007bca29ad06e3b21f74473645e1e29fc4c0215ba2ea7357f::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"BULL", b"BULLbasur", b"PokemonIsBull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5KiWVvB9t-abcboxIcAtAIEgcC4j-7k92BA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

