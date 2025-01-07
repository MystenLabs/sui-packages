module 0x88456460b6b7d27d6a7d7a66f531180a3aba1291910504509637f11a67e2d256::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<CHEBU>(arg0, 5238554625587041377, b"Cheburashka", b"Chebu", b"$Chebu to be launch on Hop.fun", b"https://images.hop.ag/ipfs/QmTU5SmELadLbLsiBgMxpCodHsP53ZaapoPTughZsTG4oK", 0x1::string::utf8(b"https://x.com/cheburashkasui"), 0x1::string::utf8(b"https://www.cheburashkasui.com/"), 0x1::string::utf8(b"https://t.me/CheburashkaSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

