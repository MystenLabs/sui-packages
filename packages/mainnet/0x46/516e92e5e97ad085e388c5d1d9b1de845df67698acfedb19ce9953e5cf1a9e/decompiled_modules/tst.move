module 0x46516e92e5e97ad085e388c5d1d9b1de845df67698acfedb19ce9953e5cf1a9e::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TST Meme Coin by SuiAI", b"TST Meme Coin is a decentralized cryptocurrency that enables users to integrate various AI utilities, making it a fun and innovative way to interact with artificial intelligence technologies. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/ePkgod.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

