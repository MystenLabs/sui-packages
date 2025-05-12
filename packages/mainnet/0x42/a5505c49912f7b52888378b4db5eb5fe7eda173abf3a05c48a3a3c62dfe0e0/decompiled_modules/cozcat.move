module 0x42a5505c49912f7b52888378b4db5eb5fe7eda173abf3a05c48a3a3c62dfe0e0::cozcat {
    struct COZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COZCAT>(arg0, 6, b"COZCAT", b"COZCAT ON SUI", x"436f7a6361742c207468652061727420636f696e206f6e20737569206e6574776f726b0a537569454f57572121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidyed7icamk3v7tuw4o6pnl3akz7bxdazs7c2rs3zzheiml6a5nfy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COZCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

