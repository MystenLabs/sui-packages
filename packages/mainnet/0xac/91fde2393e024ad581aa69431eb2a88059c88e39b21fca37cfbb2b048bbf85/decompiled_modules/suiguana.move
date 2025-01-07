module 0xac91fde2393e024ad581aa69431eb2a88059c88e39b21fca37cfbb2b048bbf85::suiguana {
    struct SUIGUANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUANA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIGUANA>(arg0, 6099872423471721005, b"SuIguana Smoking", b"SUIGUANA", b"SuIguana Smoking is more than just a meme token, it's a religion. If you accept this religion, it is forever.", b"https://images.hop.ag/ipfs/QmUuZmoMJU81AmRCgaJxEmvuK371KroXt4xwrfpgbgQYus", 0x1::string::utf8(b"https://x.com/sis_cto"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/suideg"), arg1);
    }

    // decompiled from Move bytecode v6
}

