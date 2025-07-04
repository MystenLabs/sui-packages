module 0xd13ae295743a95860f3e4aa65a6e34cefbdc28cb31915d919c2a9abcfc51a5e0::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"Melania", b"SuiMelania", b"First Lady on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiclhjxuh3frt2tgk7ef7x22cwsokh2ebxp6yp7aqvz3ydgggcivb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

