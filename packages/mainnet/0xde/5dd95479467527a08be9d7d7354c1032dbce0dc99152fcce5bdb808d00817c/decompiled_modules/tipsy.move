module 0xde5dd95479467527a08be9d7d7354c1032dbce0dc99152fcce5bdb808d00817c::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIPSY>(arg0, 6517632579829705544, b"TipsyCTO", b"TIPSY", b"Dev slow, Community Takeover", b"https://images.hop.ag/ipfs/QmPi4dZp3MpJcMFUpLTm1HqLoFMLut6PS6eMN7Ec2vBfcx", 0x1::string::utf8(b"https://x.com/TIPSYcto"), 0x1::string::utf8(b"https://www.tipsyonsui.com/"), 0x1::string::utf8(b"https://t.me/TipsyCTO"), arg1);
    }

    // decompiled from Move bytecode v6
}

