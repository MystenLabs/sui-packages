module 0xe3f3f8977c94ead06a51e3fc45f2ceed9e2625d542a6b1744c06c159434ce91d::indi {
    struct INDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INDI>(arg0, 6, b"INDI", b"Indian Lofi", b"Meme is too cool to just let it die.. Real Indians know.. https://t.me/indianlofisui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifzqvmxrci4bmuyplzzohmtxv4mremztsigerzejdr4eqqb35tq6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INDI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

