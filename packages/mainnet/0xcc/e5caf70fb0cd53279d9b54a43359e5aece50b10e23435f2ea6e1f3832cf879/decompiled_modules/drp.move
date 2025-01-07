module 0xcce5caf70fb0cd53279d9b54a43359e5aece50b10e23435f2ea6e1f3832cf879::drp {
    struct DRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DRP>(arg0, 13487642991264823485, b"Drip", b"DRP", x"412070696e742073697a65207761746572206d656d652c20656d626f6479696e67202253756922206865e2809973206368617269736d617469632c2066756e20262066756c6c206f6620737761676765722e204a6f696e20757320696e206d616b696e6720612073706c617368206f6e207468652053756920626c6f636b636861696e", b"https://images.hop.ag/ipfs/QmUTrppNwku5z6VzjjRsvrMBC589KMBWSTJuFKD7oqnbMo", 0x1::string::utf8(b"https://x.com/drip_sui?s=21"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/suidrip25"), arg1);
    }

    // decompiled from Move bytecode v6
}

