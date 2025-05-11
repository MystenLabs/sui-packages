module 0xfdafe60cdb24988cce815c24aa6852e2c8cc757a9c7069f4c9d521b6be4cb6c5::tits {
    struct TITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITS>(arg0, 6, b"TITS", b"TITCOIN ON SUI", b"https://t.me/+7Eib5kpciZ9lOTg0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiackjm6mhi74sswtav22mj3jmz4h7h7qish5waaxli26wfo77cdb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TITS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

