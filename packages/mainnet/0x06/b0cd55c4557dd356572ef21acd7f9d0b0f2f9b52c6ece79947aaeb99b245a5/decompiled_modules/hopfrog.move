module 0x6b0cd55c4557dd356572ef21acd7f9d0b0f2f9b52c6ece79947aaeb99b245a5::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 10930178817620118757, b"HopFrogSUi", b"HopFrog", b"Official.Hop Frog On Sui ($HOPFROG): Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.\" Sun Tzu, The Art of War.", b"https://images.hop.ag/ipfs/QmeZP7zsMPsTMwNwJruM9QHzG6sa2exfs4mD9hKEQkECDm", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

