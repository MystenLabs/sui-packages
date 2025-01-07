module 0xd9c78a69890ec2b319d2110276251f69d6c961b5caf0795f9866150276b463ae::jimmy {
    struct JIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<JIMMY>(arg0, 15738171409880723262, b"Jimmy", b"JIMMY", b"I CAME FROM APECHAIN", b"https://images.hop.ag/ipfs/QmbBMKx1ynGPVWAseF1FJw8YT98YJi195QrjJfAcnxkLef", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

