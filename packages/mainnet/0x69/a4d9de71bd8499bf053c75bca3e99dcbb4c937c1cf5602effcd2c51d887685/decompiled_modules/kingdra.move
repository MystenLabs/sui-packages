module 0x69a4d9de71bd8499bf053c75bca3e99dcbb4c937c1cf5602effcd2c51d887685::kingdra {
    struct KINGDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDRA>(arg0, 6, b"KINGDRA", b"SUI DRAGON", b"$KINGDRA IS THE KING OF DRAGON ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigclkd7vlxxqppjwnvipuho5kxrtz4cexk6vikugwyww65tbz5lsu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGDRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

