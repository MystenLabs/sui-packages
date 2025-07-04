module 0xed392e75919ed60be6a70f553eb251b32eefafb584da9e5acd4948613b397182::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKE>(arg0, 6, b"COKE", b"Coke Bear", b"This Bear Loves Coke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagr6d7ccdejei4364z2naoom64eptiq3ug3cfaov5hbchdiotuyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

