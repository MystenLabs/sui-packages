module 0x516bd97c2c96e2810002d0b8544d95a7565c02bbf17ac795e94a8d4e7c61183f::popepe {
    struct POPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEPE>(arg0, 6, b"POPEPE", b"Pepe the Pope", b"Pepe the Frog takes the holy seat as POPEPE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreied7p5lngxqgktmihh3q7x7g23wup7kiicl7zuv56f6s24rmjosey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

