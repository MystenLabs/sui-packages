module 0xc04b6a12c7982810c1b90a875a8a26ea098e0ffa9662f54ba02e811f5c798353::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 6, b"HABIBI", b"Habibi Germany", b"The only real refugee coin :-)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqdloh4shrmq6dczqeh66ju2kk63x3e7s4z7r454uewm7ufeew5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HABIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

