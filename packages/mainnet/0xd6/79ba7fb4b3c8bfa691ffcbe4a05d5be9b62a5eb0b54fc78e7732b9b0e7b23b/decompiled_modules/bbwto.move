module 0xd679ba7fb4b3c8bfa691ffcbe4a05d5be9b62a5eb0b54fc78e7732b9b0e7b23b::bbwto {
    struct BBWTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBWTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBWTO>(arg0, 6, b"Bbwto", b"Baby Mewtwo", b"Mewtwo as a baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifrjl3kbfefairn7qijzuto77n7i5bkldbac57yk3rtxq7rb2kujq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBWTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBWTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

