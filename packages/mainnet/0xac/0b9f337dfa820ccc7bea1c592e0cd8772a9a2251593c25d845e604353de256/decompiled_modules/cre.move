module 0xac0b9f337dfa820ccc7bea1c592e0cd8772a9a2251593c25d845e604353de256::cre {
    struct CRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRE>(arg0, 6, b"CRE", b"CURE", b"CURE - The memecoin, that heals! Heal the chart, heal the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieixii25fjuwqcumbf74w6rmdxehyduhpbr4csc42sxnfzf3g5gqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

