module 0x65cbce9b70758f164805442d94866cc93bc845e4dd7a4cc1b07c192b4b5bae9f::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIPSY>(arg0, 17141690800896715765, b"Tipsy", b"TIPSY", b"Boozing My sorrows in the oceans deep , a narwhal adrift in sorrows keep!", b"https://images.hop.ag/ipfs/QmPi4dZp3MpJcMFUpLTm1HqLoFMLut6PS6eMN7Ec2vBfcx", 0x1::string::utf8(b"https://x.com/tipsyonsui"), 0x1::string::utf8(b"https://www.tipsyonsui.com/"), 0x1::string::utf8(b"https://t.me/tipsyonsuiportal"), arg1);
    }

    // decompiled from Move bytecode v6
}

