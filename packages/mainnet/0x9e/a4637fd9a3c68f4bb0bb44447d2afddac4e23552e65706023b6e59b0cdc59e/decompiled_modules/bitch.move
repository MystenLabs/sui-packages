module 0x9ea4637fd9a3c68f4bb0bb44447d2afddac4e23552e65706023b6e59b0cdc59e::bitch {
    struct BITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCH>(arg0, 6, b"BITCH", b"LOVE U BITCH", b"LOVE U BITCH xoxo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidddfuli3ndmtijdyc4bfjru2ge6jjjtwzyizvtrqn7gvxs4mcf5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BITCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

