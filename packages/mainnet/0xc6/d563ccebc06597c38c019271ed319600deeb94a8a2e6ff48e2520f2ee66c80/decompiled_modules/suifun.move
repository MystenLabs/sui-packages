module 0xc6d563ccebc06597c38c019271ed319600deeb94a8a2e6ff48e2520f2ee66c80::suifun {
    struct SUIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<SUIFUN>(arg0, 296139425, b"SUI FUN", b"suifun", x"43726561746520796f7572206f776e20636f696e20696e206f6e6520636c69636b2e20547261646520697420696e7374616e746c792e20546f74616c6c7920667265652e0a0a2453554946554e2c207475726e696e672065766572792066656520696e746f206669726520616e6420726577617264732e", b"https://ipfs.io/ipfs/bafybeihy67llnace7ohl3qxd4p5ahu4fdj34hp7d33kyixj7dfs5eb2mee", 0x1::string::utf8(b"https://x.com/SuiFun_io"), 0x1::string::utf8(b"https://suifun.io/"), 0x1::string::utf8(b"https://t.me/suifun_io"), arg1);
    }

    // decompiled from Move bytecode v6
}

