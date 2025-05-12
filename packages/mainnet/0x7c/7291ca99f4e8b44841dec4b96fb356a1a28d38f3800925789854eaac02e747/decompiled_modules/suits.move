module 0x7c7291ca99f4e8b44841dec4b96fb356a1a28d38f3800925789854eaac02e747::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"SUITS", b"SUITSONSUI", b"Where Suit's legal swagger meets Sui's blockchain magic. Litigate, innovate and HODL like Harvey Spectre.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamtmqyr5qvrcqcubedssxxyckksldddav665pfhumk7p3www22b4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

