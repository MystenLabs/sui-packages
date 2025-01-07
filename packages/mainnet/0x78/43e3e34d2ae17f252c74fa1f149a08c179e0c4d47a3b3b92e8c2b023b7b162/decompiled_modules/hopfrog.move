module 0x7843e3e34d2ae17f252c74fa1f149a08c179e0c4d47a3b3b92e8c2b023b7b162::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 7069268933340242611, b"Hop Frog On Sui", b"HOPFROG", b"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.\" Sun Tzu, The Art of War.", b"https://images.hop.ag/ipfs/QmSh6YVqXRERS3YcRc2uBrx2EQx6NM5zHzR1cWgFswxnPU", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

