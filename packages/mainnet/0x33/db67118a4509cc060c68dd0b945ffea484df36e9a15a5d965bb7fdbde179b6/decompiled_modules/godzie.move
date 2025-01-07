module 0x33db67118a4509cc060c68dd0b945ffea484df36e9a15a5d965bb7fdbde179b6::godzie {
    struct GODZIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODZIE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<GODZIE>(arg0, 3584871001457084589, b"Godzie", b"GODZIE", b"Born from the legendary creature itself, Godzie combines the unstoppable power of blockchain with meme culture that hits harder than a kaiju.", b"https://images.hop.ag/ipfs/QmaXwpGwnQ8WD1z4p1fXgfmtfYbYshdoRFMiZEK1LgLeis", 0x1::string::utf8(b"https://x.com/GodzieonSui"), 0x1::string::utf8(b"https://godzie.fun/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

