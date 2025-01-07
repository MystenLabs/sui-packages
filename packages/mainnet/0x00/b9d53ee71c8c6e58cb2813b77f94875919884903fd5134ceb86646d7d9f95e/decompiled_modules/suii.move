module 0xb9d53ee71c8c6e58cb2813b77f94875919884903fd5134ceb86646d7d9f95e::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUII>(arg0, 4302407576107220957, b"SUII-CR7", b"SUII", x"4f6666696369616c20437269737469616e6f20526f6e616c646f206d656d65206f6e205355492e200a476f206d6f6f6e20776974682043523720616e642053554949277320636f6c6c61622e", b"https://images.hop.ag/ipfs/QmeAbHVxRq83YssZh6QA4dJeMeMDAvGQbDGStSc582im8Z", 0x1::string::utf8(b"https://x.com/Cristiano"), 0x1::string::utf8(b"https://t.co/Pc19xaN1Sp"), 0x1::string::utf8(b"https://t.me/+LhfyBtzMrHM3OGFk"), arg1);
    }

    // decompiled from Move bytecode v6
}

