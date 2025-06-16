module 0x732a97043ce1dbf91ec7d426cd3a4b9fc14aa34b755c434a3c722cbcc53bf269::bluehat {
    struct BLUEHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEHAT>(arg0, 6, b"BLUEHAT", b"Dog Wif Blue Hat", b"Sui type Dog Wif Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidbiglztj4da7onlj5tdzmblgxlcp6brkscpkhiox2dejczen7ubu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEHAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

