module 0x5f6ca5ac45659b8ace83965be90bdf942ff6a49d930fb16d499187844f8b030e::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"SHIT", b"Shit Sui", b"Shit shit shit shit shit shit shit shit shit shit shit shit shit shit shit shit!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidz6dpzaobcttzndxhaow64mx6hw4x4k2df2ef6siaerwcwqjjxpy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

