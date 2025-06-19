module 0x8d3497456d5444adae4392b1c438556d13bd22d45a21b420e6cd5ef9d99bef1a::pingi {
    struct PINGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGI>(arg0, 6, b"PINGI", b"Pingi On Sui", b"The Most Memeable Pinguin Ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqcgdrvbom3tlq5l4vqpc27wubkgz5kzcewzdzuowgtmzclwroxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PINGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

