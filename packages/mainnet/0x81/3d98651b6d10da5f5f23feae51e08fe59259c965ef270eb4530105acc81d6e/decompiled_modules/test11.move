module 0x813d98651b6d10da5f5f23feae51e08fe59259c965ef270eb4530105acc81d6e::test11 {
    struct TEST11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST11>(arg0, 6, b"TEST11", b"TEST TOKEN 11", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiakfvp43c75cm6lrjhd6vt3tytau4eu44oqsaepfqrtaqtzfdhibm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST11>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST11>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

