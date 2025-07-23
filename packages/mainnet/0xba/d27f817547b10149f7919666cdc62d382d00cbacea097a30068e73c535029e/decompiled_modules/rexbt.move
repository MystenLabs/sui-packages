module 0xbad27f817547b10149f7919666cdc62d382d00cbacea097a30068e73c535029e::rexbt {
    struct REXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REXBT>(arg0, 6, b"REXBT", b"Lil Tyrex", b"REXBT is the Lil Tyrex On SUI World, destroying everything in the city, rexbt is tired of fake AI robots, scammers. REXBT is a pure memecoin, bringing the vibes of memecoin great again, REXBT was born from the whole community without any false utility promises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickhrnsyijzzhcw2fqc3lfxeomlkslfmq5ybn4jzezdqg3xudcupe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REXBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REXBT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

