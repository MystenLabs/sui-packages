module 0x5e95ce355df7d1f73ac1508df402c5ec9011b8b366968876d94d428cbb0a97cf::elmo {
    struct ELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMO>(arg0, 6, b"Elmo", b"Elmo on sui", b"The cutest chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidxapdioj7qixk5ls2drzldotwo57gsu2rrhyvhixvunorq3co4gy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

