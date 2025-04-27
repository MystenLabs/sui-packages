module 0x3417e728357b78fd1abb1ac2e625137bb4e7f3eae2aedab094ffee8209d98b9e::suifun {
    struct SUIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<SUIFUN>(arg0, 516990725, b"SUIFUN", b"suifun", b"$SUIFUN, turning every fee into fire and rewards", b"https://ipfs.io/ipfs/bafybeihy67llnace7ohl3qxd4p5ahu4fdj34hp7d33kyixj7dfs5eb2mee", 0x1::string::utf8(b"https://x.com/SuiFun_io"), 0x1::string::utf8(b"https://suifun.io/"), 0x1::string::utf8(b"https://t.me/suifun_io"), arg1);
    }

    // decompiled from Move bytecode v6
}

