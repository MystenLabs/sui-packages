module 0xebf30f262a800e638e11db2b36c37143aa65d93fbb9494f536449a1505b27e8b::weed {
    struct WEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEED>(arg0, 6, b"WEED", b"WEED SUI", b"WEED live now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreietk7hzouhzf7uvuley3liyv3emgfrudoy74fvttyeqnqoi6tmhde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WEED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

