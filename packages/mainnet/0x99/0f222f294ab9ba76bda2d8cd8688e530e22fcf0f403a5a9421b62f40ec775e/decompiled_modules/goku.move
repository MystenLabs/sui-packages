module 0x990f222f294ab9ba76bda2d8cd8688e530e22fcf0f403a5a9421b62f40ec775e::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"SUIGOKU", b"GOKU is not just a cryptocurrency; its a fusion ofhumor, innovation, and the limitless potential ofthe blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieo4i4tqyrzdfciihkwxwrdfey3snarbah4dfohyhvjj6sljmngsa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

