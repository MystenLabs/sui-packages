module 0x9f7bd3b83835d41b8219a1903ae06895ba775688a9551f50030e00a07b1552e5::doph {
    struct DOPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DOPH>(arg0, 3738685444563885337, b"Doph", b"DOPH", x"546865206f6e6c7920446f6c7068696e205377696d6d696e27206f6ec2a0537569", b"https://images.hop.ag/ipfs/QmUq9Z2zbD728o5GGCUcTzM3nb9fyYhP1iT1eaVvKo1yee", 0x1::string::utf8(b"https://x.com/Dophsui"), 0x1::string::utf8(b"https://doponsui.xyz/"), 0x1::string::utf8(b"https://t.me/dophsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

