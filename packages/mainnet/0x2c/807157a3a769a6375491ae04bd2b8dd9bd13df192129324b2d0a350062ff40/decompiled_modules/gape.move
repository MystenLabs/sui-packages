module 0x2c807157a3a769a6375491ae04bd2b8dd9bd13df192129324b2d0a350062ff40::gape {
    struct GAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAPE>(arg0, 9, b"GAPE", b"Golden Ape", b"GAPE Coin is the ultimate meme coin that combines the strength of apes, the allure of gold, and the fun of the crypto jungle. Built for long-term holders, GAPE symbolizes wealth, resilience, and a community-driven future in the ever-evolving crypto space. Hold GAPE and join the golden evolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRMDf9PKZGvwygwqq1r1Ny8H3nZqyYEnp1xmn4i1AAHpQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

