module 0x576ec7d05a25ce93c4c8b7858d8942d9c226a21d962e4a11ee908a2028547415::cloop {
    struct CLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOOP>(arg0, 6, b"CLOOP", b"CLOOP ON SUI", b"Cloop is a meme token on the Sui blockchain, launched via Moonbags launchpad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemwjtdbdke5oxfqk5dsxfmddrt36oc7yb66pabhlxsm53v5uujr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLOOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

