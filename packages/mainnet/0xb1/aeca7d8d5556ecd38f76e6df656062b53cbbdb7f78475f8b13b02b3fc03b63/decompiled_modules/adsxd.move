module 0xb1aeca7d8d5556ecd38f76e6df656062b53cbbdb7f78475f8b13b02b3fc03b63::adsxd {
    struct ADSXD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSXD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSXD>(arg0, 6, b"ADSxd", b"qdas", b"asda dsadwd  dddda w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagtxpw72hzqcj65f5bvp52ksqk44vg2tcxgu2ozc7vzghatjodaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSXD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADSXD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

