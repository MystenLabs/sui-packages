module 0xf60003ffa6f794aa62b01a232fd1769c4a9373a8a21bdfa384306b2b75d738ef::trumppumpbtc {
    struct TRUMPPUMPBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPPUMPBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRUMPPUMPBTC>(arg0, 11738420758764884082, b"TRUMPPUMPBTC", b"TRUMPPUMPBTC", b"TRUMPPUMPBTC", b"https://images.hop.ag/ipfs/QmPBWx8S68R9g9ZyzhpdFT7hFNKhuzjDHfbvry1q8P9Qhu", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+Xh65YjCRpV5hMWIy"), arg1);
    }

    // decompiled from Move bytecode v6
}

