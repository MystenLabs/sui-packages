module 0x7f3540a03b025b8a9b09f245390ed0a8c8a3ec9b3839c5c1c930fed9b8fa8f14::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIPSY>(arg0, 6786332286718400927, b"Tipsy", b"TIPSY", b"Boozing My sorrows in the oceans deep , a narwhal adrift in sorrows keep!", b"https://images.hop.ag/ipfs/QmPi4dZp3MpJcMFUpLTm1HqLoFMLut6PS6eMN7Ec2vBfcx", 0x1::string::utf8(b"https://x.com/tipsyonsui"), 0x1::string::utf8(b"https://www.tipsyonsui.com/"), 0x1::string::utf8(b"https://t.me/TipsyCommunity"), arg1);
    }

    // decompiled from Move bytecode v6
}

