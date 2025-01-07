module 0xb97a76ae9cd42f2855f20351abc58e3ae1018b5e526b024cb7660f0a90fcfafe::arc {
    struct ARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ARC>(arg0, 7840843031846615951, b"WINTERARC", b"ARC", b"Winter Arc is a unique meme token on Sui, inspired by the spirit of winter adventures. Symbolizing resilience and unity, Winter Arc brings together a crypto community ready to reach new heights despite the cold times and challenges.", b"https://images.hop.ag/ipfs/QmdXRevnjv1kGZ7EdUw5tqAsY5iB6u5jf9ij7X7orNPFgQ", 0x1::string::utf8(b"https://twitter.com/WINTERARC"), 0x1::string::utf8(b"https://WINTERARC.com"), 0x1::string::utf8(b"https://t.me/winterarcsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

