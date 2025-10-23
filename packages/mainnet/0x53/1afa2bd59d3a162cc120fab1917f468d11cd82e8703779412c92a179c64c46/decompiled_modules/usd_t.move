module 0x531afa2bd59d3a162cc120fab1917f468d11cd82e8703779412c92a179c64c46::usd_t {
    struct USD_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD_T>(arg0, 6, b"USD T", b"uSdt", b"ffffff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieatey242le3l27rhcfhq2ljq5ygfpf4oct7ocylr3tv23ggq2p5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD_T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USD_T>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

